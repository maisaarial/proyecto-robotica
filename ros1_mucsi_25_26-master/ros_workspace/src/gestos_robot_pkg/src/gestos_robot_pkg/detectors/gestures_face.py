import cv2
import time
import os

# Usar el clasificador de ojos incluido en OpenCV
CASCADE_EYE_PATH = os.path.join(cv2.data.haarcascades, "haarcascade_eye.xml")
eye_cascade = cv2.CascadeClassifier(CASCADE_EYE_PATH)

if eye_cascade.empty():
    raise RuntimeError(f"No se pudo cargar el cascade de ojos en {CASCADE_EYE_PATH}")

# ---------------------------------------------------
# Estado para parpadeo largo (ambos ojos cerrados)
# ---------------------------------------------------
_eyes_closed = False
_close_start = 0.0

# Parpadeo largo: duración mínima en milisegundos
LONG_BLINK_MS = 1200  # ~1.2 segundos

# ---------------------------------------------------
# Estado para doble guiño (CONTINUAR)
# Detectamos dos "guiños cortos" seguidos con un ojo
# ---------------------------------------------------
_prev_eye_mode = 2          # 2 = ambos abiertos (por defecto)
_wink_start_time = None     # inicio del guiño actual
_last_wink_time = None      # cuándo fue el último guiño completo

# Duración máxima de un guiño corto
WINK_MAX_DURATION_MS = 600          # < 0.6 s
# Ventana para considerar doble guiño
DOUBLE_WINK_WINDOW_MS = 1000        # 1.0 s entre guiños


def detectar_ojos(roi_gray):
    """
    Detecta ojos en la ROI de la cara usando Haar cascades.
    Devuelve lista de rectángulos (x, y, w, h) relativos a la ROI.
    """
    eyes = eye_cascade.detectMultiScale(
        roi_gray,
        scaleFactor=1.1,
        minNeighbors=5,
        minSize=(20, 20)
    )
    return eyes


def _ratio_altura_ancho(eye_rect):
    x, y, w, h = eye_rect
    return h / float(w)


def estados_ojos(roi_gray):
    """
    Clasifica cada ojo como 'abierto' o 'cerrado'
    según la relación altura/anchura del rectángulo.
    Devuelve (n_abiertos, n_cerrados).
    """
    eyes = detectar_ojos(roi_gray)
    abiertos = 0
    cerrados = 0

    for (x, y, w, h) in eyes:
        ratio = h / float(w)
        # umbral heurístico: ojo abierto es "alto"
        if ratio > 0.18:
            abiertos += 1
        else:
            cerrados += 1

    return abiertos, cerrados


def es_guiño_roi(roi_gray):
    """
    Gesto CONTINUAR: DOBLE GUIÑO RÁPIDO.

    Lógica:
      - Un 'guiño' se considera cuando pasamos por:
          ambos ojos abiertos (modo 2) ->
          exactamente un ojo detectado (modo 1) ->
          salimos de modo 1
        en menos de WINK_MAX_DURATION_MS.
      - Si detectamos 2 guiños cortos en menos de
        DOUBLE_WINK_WINDOW_MS -> devolvemos True UNA vez.
    """
    global _prev_eye_mode, _wink_start_time, _last_wink_time

    eyes = detectar_ojos(roi_gray)
    n_eyes = len(eyes)

    # Clasificamos el modo actual: 0, 1, 2+
    if n_eyes >= 2:
        eye_mode = 2
    elif n_eyes == 1:
        eye_mode = 1
    else:
        eye_mode = 0

    now = time.time()

    # Entramos en modo guiño (exactamente 1 ojo detectado)
    if eye_mode == 1:
        if _prev_eye_mode != 1:
            # Inicio del guiño
            _wink_start_time = now

    # Salimos de modo guiño
    elif eye_mode != 1 and _prev_eye_mode == 1 and _wink_start_time is not None:
        dur_ms = (now - _wink_start_time) * 1000.0
        # Comprobamos si ha sido un guiño "corto"
        if dur_ms <= WINK_MAX_DURATION_MS:
            # Tenemos un guiño completo
            if _last_wink_time is not None:
                delta_ms = (now - _last_wink_time) * 1000.0
                if delta_ms <= DOUBLE_WINK_WINDOW_MS:
                    # DOBLE GUIÑO DETECTADO
                    _last_wink_time = None
                    _wink_start_time = None
                    _prev_eye_mode = eye_mode
                    return True
            # Primer guiño de la secuencia
            _last_wink_time = now

        _wink_start_time = None

    _prev_eye_mode = eye_mode
    return False


def es_parpadeo_largo_roi(roi_gray):
    """
    Gesto DETENER: PARPADEO LARGO (ambos ojos cerrados).

    Lógica:
      - Consideramos "cerrados" cuando no vemos ojos abiertos
        y sí detectamos al menos un "ojo" con ratio de cerrado.
      - Si el tiempo en estado cerrado supera LONG_BLINK_MS
        y luego se abren, devolvemos True UNA vez.
    """
    global _eyes_closed, _close_start

    abiertos, cerrados = estados_ojos(roi_gray)
    now = time.time()

    # Consideramos "cerrados" cuando no vemos ojos abiertos
    # y detectamos al menos uno "cerrado".
    currently_closed = (abiertos == 0 and cerrados >= 1)

    # Transición: se acaban de cerrar
    if currently_closed and not _eyes_closed:
        _eyes_closed = True
        _close_start = now
        return False

    # Permanecen cerrados
    if currently_closed and _eyes_closed:
        return False

    # Transición: se acaban de abrir
    if not currently_closed and _eyes_closed:
        dur_ms = (now - _close_start) * 1000.0
        _eyes_closed = False
        if dur_ms >= LONG_BLINK_MS:
            # PARPADEO LARGO DETECTADO
            return True

    return False
