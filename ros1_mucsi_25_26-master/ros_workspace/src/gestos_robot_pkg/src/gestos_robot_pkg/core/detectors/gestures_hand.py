import cv2
import numpy as np

# -------------------------
# UMBRALES AJUSTABLES
# -------------------------

# Profundidad mínima del defecto (valle entre dedos) para contarlo
MIN_DEFECT_DEPTH = 1800  # subimos umbral para evitar valles falsos (ruido)

# Área mínima del contorno para considerarlo mano (para quitar ruido)
MIN_HAND_AREA = 3000  # pedimos una mano un poco más grande

# Umbral de solidity para considerar puño (mano muy compacta)
SOLIDITY_PUNIO = 0.88  # ligeramente más permisivo con el puño

# Distancia mínima horizontal entre defectos para contarlos como valles distintos
MIN_DIST_DEFECTS = 25  # separamos más los valles para distinguir 1 vs 2 dedos

# Diferencia vertical mínima para gesto "rock" (separación pulgar–meñique)
MIN_DELTA_Y_ROCK = 50  # hace falta más separación vertical para el gesto rock


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
    if finger_gaps <= 0 and solidity > SOLIDITY_PUNIO:
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

    Solo tiene sentido evaluarlo si hay 2 dedos extendidos.
    Requiere:
      - 2 dedos detectados
      - hull más ancho que alto
      - separación vertical grande entre puntas (pulgar/meñique)
    """
    dedos = contar_dedos_roi(roi_bgr)
    if dedos != 2:
        return False

    mask = _segmentar_piel(roi_bgr)
    cont = _contorno_mano(mask)
    if cont is None:
        return False

    hull = cv2.convexHull(cont)
    xs = hull[:, 0][:, 0]
    ys = hull[:, 0][:, 1]

    x_min, x_max = xs.min(), xs.max()
    y_min, y_max = ys.min(), ys.max()

    ancho = x_max - x_min
    alto = y_max - y_min

    # Rock suele ser más "horizontal" que vertical
    if ancho <= alto:
        return False

    delta_y = y_max - y_min

    # umbral de separación vertical entre pulgar y meñique
    if delta_y < MIN_DELTA_Y_ROCK:
        return False

    return True

def gesto_tirar_dado_roi(roi_bgr, bbox, min_aspect_ratio=1.2, min_top_offset=0.15):
    """
    Detecta el gesto de 'tirar dado' como un pulgar arriba (👍):

      - mano cerrada / compacta
      - un único saliente hacia arriba (pulgar) bien por encima del centro de la mano

    Solo usa contornos y convex hull (OpenCV).
    """
    mask = _segmentar_piel(roi_bgr)
    cont = _contorno_mano(mask)
    if cont is None:
        return False

    # Conteo de dedos para comprobar que no parece mano abierta
    dedos = contar_dedos_roi(roi_bgr)
    if dedos is None:
        return False
    if dedos > 2:
        # si parece que hay muchos dedos, no es pulgar arriba
        return False

    # Bounding box y proporciones
    x, y, w, h = cv2.boundingRect(cont)
    aspect = h / (w + 1e-6)
    if aspect < min_aspect_ratio:
        # queremos algo más alto que ancho
        return False

    # Centroide de la mano
    M = cv2.moments(cont)
    if M["m00"] == 0:
        return False
    cx = int(M["m10"] / M["m00"])
    cy = int(M["m01"] / M["m00"])

    # Punto más alto del hull
    hull = cv2.convexHull(cont)
    top_idx = np.argmin(hull[:, 0][:, 1])
    topmost = hull[top_idx, 0]  # (x, y)

    # Debe sobresalir claramente por encima del centroide
    if topmost[1] > cy - h * min_top_offset:
        return False

    # Pulgar suele estar un poco desplazado hacia un lado
    if abs(topmost[0] - cx) < w * 0.1:
        return False

    return True


def clasificar_gesto_mano(roi_bgr):
    """
    Devuelve una etiqueta de gesto y el número de dedos detectados.

    Etiquetas finales:
      - 'inicio'         -> mano abierta (4-5 dedos)
      - 'ficha_roja'     -> puño (0 dedos)
      - 'ficha_amarilla' -> 1 dedo (índice)
      - 'ficha_verde'    -> 3 dedos
      - 'ficha_azul'     -> gesto rock 🤘
      - 'desconocido'    -> cualquier otra cosa
    """
    dedos = contar_dedos_roi(roi_bgr)

    if dedos is None:
        return None, None

    # Puño
    if dedos == 0:
        return "ficha_roja", dedos

    # Mano abierta (inicio)
    if dedos >= 4:
        return "inicio", dedos

    # Rock tiene prioridad sobre otros gestos con pocos dedos
    if es_rock_roi(roi_bgr):
        return "ficha_azul", dedos

    # 3 dedos -> verde
    if dedos == 3:
        return "ficha_verde", dedos

    # 1 dedo -> amarilla
    if dedos == 1:
        return "ficha_amarilla", dedos

    # cualquier otra cosa
    return "desconocido", dedos
