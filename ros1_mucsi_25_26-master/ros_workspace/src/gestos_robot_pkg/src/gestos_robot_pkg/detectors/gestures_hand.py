import cv2
import numpy as np

# -------------------------
# UMBRALES AJUSTABLES
# -------------------------

# Profundidad mínima del defecto (valle entre dedos) para contarlo
MIN_DEFECT_DEPTH = 3200

# Área mínima del contorno para considerarlo mano (para quitar ruido)
MIN_HAND_AREA = 2000

# Umbral de solidity para considerar puño (mano muy compacta)
SOLIDITY_PUNIO = 0.92

# Distancia mínima horizontal entre defectos para contarlos como valles distintos
MIN_DIST_DEFECTS = 35

# Diferencia vertical mínima para gesto "rock" (separación pulgar–meñique)
MIN_DELTA_Y_ROCK = 45

# Para "tirar dado" usando movimiento del centroide
_last_cx = None
_dx_hist = []


def _segmentar_piel(roi_bgr):
    """
    Segmenta piel en la ROI usando HSV.
    (puedes ajustar los rangos según tu piel / iluminación)
    """
    hsv = cv2.cvtColor(roi_bgr, cv2.COLOR_BGR2HSV)

    # Rango típico de piel (aprox)
    lower = np.array([0, 30, 60], dtype=np.uint8)
    upper = np.array([20, 150, 255], dtype=np.uint8)

    mask = cv2.inRange(hsv, lower, upper)

    # Más limpio: operaciones morfológicas
    kernel = np.ones((3, 3), np.uint8)
    mask = cv2.erode(mask, kernel, iterations=1)
    mask = cv2.dilate(mask, kernel, iterations=2)
    mask = cv2.GaussianBlur(mask, (7, 7), 0)

    return mask


def _contorno_mano(mask):
    """
    Devuelve el mayor contorno de la máscara (mano),
    o None si no hay nada suficientemente grande.
    """
    contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    if not contours:
        return None

    c = max(contours, key=cv2.contourArea)
    if cv2.contourArea(c) < MIN_HAND_AREA:  # descartar ruido
        return None

    return c


def contar_dedos_roi(roi_bgr, debug_draw=False):
    """
    Cuenta dedos levantados usando:
      - Segmentación de piel
      - Contorno mayor
      - Convex hull + convexity defects

    Devuelve número de dedos (0..5) o None si no hay mano clara.

    Mejoras:
      - Ignora defectos por debajo del centro de la mano (muñeca)
      - Usa 'solidity' para diferenciar puño de mano abierta.
      - last_far_x es LOCAL (no arrastra entre frames).
    """
    mask = _segmentar_piel(roi_bgr)
    cont = _contorno_mano(mask)
    if cont is None:
        return None

    # Hull con índices para defects
    hull_idx = cv2.convexHull(cont, returnPoints=False)
    if hull_idx is None or len(hull_idx) < 3:
        return None

    # Hull con puntos para dibujar / área
    hull_pts = cv2.convexHull(cont)
    area_cont = cv2.contourArea(cont)
    area_hull = cv2.contourArea(hull_pts)
    solidity = area_cont / (area_hull + 1e-6)

    # Centro de la mano
    M = cv2.moments(cont)
    if M["m00"] == 0:
        return None
    cx = M["m10"] / M["m00"]
    cy = M["m01"] / M["m00"]

    defects = cv2.convexityDefects(cont, hull_idx)
    if defects is None:
        # contorno muy compacto → probablemente puño
        return 0

    finger_gaps = 0
    last_far_x = None  # 🔴 AHORA ES LOCAL AL FRAME

    for i in range(defects.shape[0]):
        s, e, f, depth = defects[i, 0]
        start = cont[s][0]
        end = cont[e][0]
        far = cont[f][0]

        # 1) profundidad mínima del valle
        if depth < MIN_DEFECT_DEPTH:
            continue

        # 2) ignorar valles por debajo del centro de la mano (muñeca)
        if far[1] > cy * 1.05:
            continue

        # 3) descartar defectos muy cercanos entre sí (ruido)
        if last_far_x is not None:
            dist = abs(far[0] - last_far_x)
            if dist < MIN_DIST_DEFECTS:
                continue

        finger_gaps += 1
        last_far_x = far[0]

        if debug_draw:
            cv2.circle(roi_bgr, tuple(far), 5, (0, 0, 255), -1)

    # dedos ≈ gaps + 1 (clásico truco)
    dedos = finger_gaps + 1

    # Heurística extra: si no hay valles o la mano es muy compacta → puño
    if finger_gaps <= 0 or solidity > SOLIDITY_PUNIO:
        dedos = 0

    # Acotar a 0..5
    dedos = max(0, min(5, dedos))

    if debug_draw:
        cv2.drawContours(roi_bgr, [cont], -1, (0, 255, 0), 2)
        cv2.drawContours(roi_bgr, [hull_pts], -1, (255, 0, 0), 2)
        cv2.putText(roi_bgr, f"dedos: {dedos}", (10, 30),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.7, (255, 255, 255), 2)

    return dedos


def es_rock_roi(roi_bgr):
    """
    Detecta gesto 🤘 (ficha azul).

    IMPORTANTE: solo tiene sentido evaluarlo si hay 2 dedos.
    """
    dedos = contar_dedos_roi(roi_bgr)
    # 👉 si NO hay exactamente 2 dedos, NO puede ser rock
    if dedos != 2:
        return False

    mask = _segmentar_piel(roi_bgr)
    cont = _contorno_mano(mask)
    if cont is None:
        return False

    hull = cv2.convexHull(cont)
    ys = hull[:, 0][:, 1]
    delta_y = ys.max() - ys.min()

    # umbral de separación vertical entre pulgar y meñique
    return delta_y > MIN_DELTA_Y_ROCK


def gesto_tirar_dado_roi(roi_bgr, bbox, factor_umbral=40, ventana=5):
    """
    Detecta el gesto de 'tirar dado' como un movimiento lateral
    del centroide de la mano (en coordenadas de la imagen completa).

    bbox = (x1, y1, x2, y2) de la mano en el frame original.
    """
    global _last_cx, _dx_hist

    mask = _segmentar_piel(roi_bgr)
    cont = _contorno_mano(mask)
    if cont is None:
        _last_cx = None
        _dx_hist = []
        return False

    M = cv2.moments(cont)
    if M["m00"] == 0:
        return False

    cx_local = int(M["m10"] / M["m00"])

    # Pasamos a coordenadas globales usando bbox
    x1, _, _, _ = bbox
    cx = x1 + cx_local

    if _last_cx is None:
        _last_cx = cx
        return False

    dx = cx - _last_cx
    _last_cx = cx

    _dx_hist.append(dx)
    if len(_dx_hist) > ventana:
        _dx_hist.pop(0)

    # Umbral en píxeles acumulados
    if abs(sum(_dx_hist)) > factor_umbral:
        _dx_hist = []
        return True

    return False


def clasificar_gesto_mano(roi_bgr):
    """
    Devuelve una etiqueta de gesto y el número de dedos detectados.

    Posibles etiquetas:
      - 'inicio'         -> mano abierta (4-5 dedos)
      - 'ficha_roja'     -> puño (0 dedos)
      - 'ficha_amarilla' -> 1 dedo
      - 'ficha_verde'    -> 2 dedos
      - 'ficha_azul'     -> gesto rock 🤘
      - 'desconocido'    -> cualquier otra cosa
    """
    dedos = contar_dedos_roi(roi_bgr)

    if dedos is None:
        return None, None

    # 0 dedos -> puño
    if dedos == 0:
        return "ficha_roja", dedos

    # 4 o 5 dedos -> inicio de juego
    if dedos >= 4:
        return "inicio", dedos

    # Rock (azul) tiene prioridad sobre "2 dedos normales"
    if es_rock_roi(roi_bgr):
        return "ficha_azul", dedos

    # 2 dedos -> verde
    if dedos == 2:
        return "ficha_verde", dedos

    # 1 dedo -> amarilla
    if dedos == 1:
        return "ficha_amarilla", dedos

    # cualquier otra cosa
    return "desconocido", dedos