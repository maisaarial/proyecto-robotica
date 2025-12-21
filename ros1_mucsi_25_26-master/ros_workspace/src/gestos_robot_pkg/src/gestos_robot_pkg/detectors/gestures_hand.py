import cv2
import numpy as np

# -------------------------
# UMBRALES AJUSTABLES
# -------------------------

# Profundidad mínima del defecto (valle entre dedos) para contarlo
MIN_DEFECT_DEPTH = 1800   # sube/baja si cuenta demasiados/pocos valles

# Área mínima del contorno para considerarlo mano (para quitar ruido)
MIN_HAND_AREA = 3000      # pide una mano con cierto tamaño

# Umbral de solidity para considerar puño (mano muy compacta)
SOLIDITY_PUNIO = 0.88     # si da muchos falsos puños, bájalo un poco

# Distancia mínima horizontal entre defectos para contarlos como valles distintos
MIN_DIST_DEFECTS = 40     # subirlo ayuda a que 1 dedo no se confunda con 3

# Diferencia vertical mínima para gesto "rock" (separación pulgar–meñique)
MIN_DELTA_Y_ROCK = 50

# Para "tirar dado" (pulgar arriba)
MIN_ASPECT_RATIO_TIRAR = 1.2   # mano más alta que ancha
MIN_TOP_OFFSET_TIRAR = 0.25    # qué tanto debe sobresalir el pulgar por encima del centro


# -------------------------
# UTILIDADES BÁSICAS
# -------------------------

def _segmentar_piel(roi_bgr):
    """
    Segmenta piel en la ROI usando HSV.
    Ajusta los rangos según tu piel / iluminación si hace falta.
    """
    hsv = cv2.cvtColor(roi_bgr, cv2.COLOR_BGR2HSV)

    # Rango típico de piel (dos bandas de tono)
    lower1 = np.array([0, 30, 60], dtype=np.uint8)
    upper1 = np.array([20, 150, 255], dtype=np.uint8)

    lower2 = np.array([160, 30, 60], dtype=np.uint8)
    upper2 = np.array([180, 150, 255], dtype=np.uint8)

    mask1 = cv2.inRange(hsv, lower1, upper1)
    mask2 = cv2.inRange(hsv, lower2, upper2)
    mask = cv2.bitwise_or(mask1, mask2)

    # Limpiar ruido
    kernel = np.ones((3, 3), np.uint8)
    mask = cv2.morphologyEx(mask, cv2.MORPH_OPEN, kernel, iterations=2)
    mask = cv2.dilate(mask, kernel, iterations=2)
    mask = cv2.GaussianBlur(mask, (5, 5), 0)

    return mask


def _contorno_mano(mask):
    """
    Devuelve el mayor contorno de la máscara (mano), o None si no hay.
    """
    contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    if not contours:
        return None

    c = max(contours, key=cv2.contourArea)
    if cv2.contourArea(c) < MIN_HAND_AREA:
        return None

    return c


# -------------------------
# CONTEO DE DEDOS (NÚCLEO)
# -------------------------

def contar_dedos_roi(roi_bgr, debug_draw=False):
    """
    Cuenta dedos levantados usando:
      - Segmentación de piel
      - Contorno mayor
      - Convex hull + convexity defects

    Devuelve número de dedos (0..5) o None si no hay mano clara.

    Mejoras para tu caso:
      - Ignoramos defectos por debajo del centro de la mano (muñeca)
      - Usamos 'solidity' para diferenciar puño de mano abierta
      - MIN_DIST_DEFECTS alto para que 1 dedo no parezca 3
    """
    mask = _segmentar_piel(roi_bgr)
    cont = _contorno_mano(mask)
    if cont is None:
        return None

    # Hull para defects y para solidity
    hull = cv2.convexHull(cont)
    hull_idx = cv2.convexHull(cont, returnPoints=False)
    if hull_idx is None or len(hull_idx) < 3:
        return None

    # Solidity (área contorno vs área hull)
    area = cv2.contourArea(cont)
    hull_area = cv2.contourArea(hull)
    solidity = float(area) / hull_area if hull_area > 0 else 1.0

    defects = cv2.convexityDefects(cont, hull_idx)

    # Caso: sin defects -> o puño o 1 dedo mal segmentado
    if defects is None:
        if solidity > SOLIDITY_PUNIO:
            return 0
        else:
            return 1

    # centro de la mano (para descartar valles cercanos a la muñeca)
    x, y, w, h = cv2.boundingRect(cont)
    centro_y = y + h * 0.5

    finger_gaps = 0
    last_far_x = None

    for d in defects[:, 0]:
        s, e, f, depth = d
        if depth < MIN_DEFECT_DEPTH:
            continue

        start = cont[s][0]
        end   = cont[e][0]
        far   = cont[f][0]

        # ignorar defectos por debajo del centro (zona muñeca)
        if far[1] > centro_y:
            continue

        # ángulo en el valle (si es muy obtuso, no son dos dedos separados)
        a = np.linalg.norm(end - far)
        b = np.linalg.norm(start - far)
        c_len = np.linalg.norm(end - start)
        if a == 0 or b == 0:
            continue
        cos_angle = (a**2 + b**2 - c_len**2) / (2 * a * b)
        cos_angle = np.clip(cos_angle, -1.0, 1.0)
        angle = np.degrees(np.arccos(cos_angle))

        if angle > 80:  # valles demasiado abiertos -> no cuentan como separaciones de dedos
            continue

        # Unificar valles muy cercanos en X (para que 1 dedo no sea 2-3)
        if last_far_x is not None and abs(far[0] - last_far_x) < MIN_DIST_DEFECTS:
            continue

        finger_gaps += 1
        last_far_x = far[0]

        if debug_draw:
            cv2.circle(roi_bgr, tuple(far), 5, (0, 0, 255), -1)

    # Dedos ≈ gaps + 1
    if finger_gaps <= 0:
        # si es muy compacto -> puño; si no, al menos 1 dedo
        if solidity > SOLIDITY_PUNIO:
            dedos = 0
        else:
            dedos = 1
    else:
        dedos = finger_gaps + 1

    # Clamp 0..5
    dedos = max(0, min(5, dedos))

    return dedos


# -------------------------
# GESTO ROCK (🤘 FICHA AZUL)
# -------------------------

def es_rock_roi(roi_bgr):
    """
    Detecta gesto 🤘 (ficha azul).

    Reglas:
      - Primero exige exactamente 2 dedos extendidos
      - Contorno más ancho que alto
      - Gran diferencia vertical en el hull (pulgar y meñique separados en Y)
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

    # En tu caso el rock es con los dedos hacia arriba: mano más alta que ancha
    if alto <= ancho:
        return False


    delta_y = y_max - y_min
    if delta_y < MIN_DELTA_Y_ROCK:
        return False

    return True


# -------------------------
# GESTO TIRAR DADO (PULGAR ARRIBA)
# -------------------------

def gesto_tirar_dado_roi(roi_bgr, bbox, min_aspect_ratio=MIN_ASPECT_RATIO_TIRAR,
                         min_top_offset=MIN_TOP_OFFSET_TIRAR):
    """
    Detecta el gesto de 'tirar dado' como un pulgar arriba (👍):

      - mano cerrada / compacta (0-1 dedos)
      - un único saliente hacia arriba (pulgar) bien por encima del centro de la mano
      - mano más alta que ancha

    Solo usa segmentación + contornos + hull (sin landmarks de MediaPipe).
    El parámetro bbox se ignora, se deja solo por compatibilidad.
    """
    mask = _segmentar_piel(roi_bgr)
    cont = _contorno_mano(mask)
    if cont is None:
        return False

    dedos = contar_dedos_roi(roi_bgr)
    if dedos is None:
        return False

    # Debe parecer un puño con "algo" arriba (0-1 dedos)
    if dedos > 1:
        return False

    x, y, w, h = cv2.boundingRect(cont)

    # Mano claramente más alta que ancha (pulgar hacia arriba)
    if h < w * min_aspect_ratio:
        return False

    # Centroide de la mano
    M = cv2.moments(cont)
    if M["m00"] == 0:
        return False
    cx = M["m10"] / M["m00"]
    cy = M["m01"] / M["m00"]

    # Punto más alto del hull
    hull = cv2.convexHull(cont)
    top_idx = np.argmin(hull[:, 0][:, 1])
    topmost = hull[top_idx, 0]  # (x, y)

    # El pulgar debe estar claramente por encima del centroide
    if topmost[1] > cy - h * min_top_offset:
        return False

    # Y razonablemente cerca del centro en X (para evitar manos laterales)
    if abs(topmost[0] - cx) > w * 0.35:
        return False

    return True


# -------------------------
# CLASIFICADOR DE GESTO DE MANO
# -------------------------

def clasificar_gesto_mano(roi_bgr):
    """
    Devuelve una etiqueta de gesto y el número de dedos detectados.

    Etiquetas:
      - 'inicio'         -> mano abierta (4-5 dedos)
      - 'ficha_roja'     -> puño (0 dedos)
      - 'ficha_amarilla' -> 1 dedo (índice)
      - 'ficha_verde'    -> 3 dedos
      - 'ficha_azul'     -> gesto rock 🤘
      - 'tirar_dado'     -> pulgar arriba 👍
      - 'desconocido'    -> cualquier otra cosa
    """
    dedos = contar_dedos_roi(roi_bgr)
    if dedos is None:
        return None, None

    # 1) Tirar dado (pulgar arriba) tiene prioridad sobre mano abierta
    if gesto_tirar_dado_roi(roi_bgr, bbox=None):
        return "tirar_dado", dedos

    # 2) Mano muy abierta -> inicio
    if dedos >= 4:
        return "inicio", dedos

    # 3) Puño
    if dedos == 0:
        return "ficha_roja", dedos

    # 4) Rock tiene prioridad sobre otros gestos con 2 dedos
    if es_rock_roi(roi_bgr):
        return "ficha_azul", dedos

    # 5) 3 dedos -> verde
    if dedos == 3:
        return "ficha_verde", dedos

    # 6) 1 dedo -> amarilla
    if dedos == 1:
        return "ficha_amarilla", dedos

    # 7) cualquier otra cosa
    return "desconocido", dedos
