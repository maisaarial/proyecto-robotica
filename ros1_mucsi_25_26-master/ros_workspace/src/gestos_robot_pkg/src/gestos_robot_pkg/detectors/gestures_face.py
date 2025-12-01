import cv2
import time
import os

# Usar el clasificador de ojos incluido en OpenCV
CASCADE_EYE_PATH = os.path.join(cv2.data.haarcascades, "haarcascade_eye.xml")
eye_cascade = cv2.CascadeClassifier(CASCADE_EYE_PATH)

# Estado para parpadeo largo
_eyes_closed = False
_close_start = 0.0
LONG_BLINK_MS = 700

if eye_cascade.empty():
    raise RuntimeError(f"No se pudo cargar el cascade de ojos en {CASCADE_EYE_PATH}")

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
    Guiño: un ojo abierto y otro cerrado.
    """
    abiertos, cerrados = estados_ojos(roi_gray)
    # si detectamos 2 ojos, uno abierto y otro cerrado
    return abiertos == 1 and cerrados == 1


def es_parpadeo_largo_roi(roi_gray):
    """
    Parpadeo largo: ambos ojos cerrados durante > LONG_BLINK_MS.
    """
    global _eyes_closed, _close_start

    abiertos, cerrados = estados_ojos(roi_gray)
    now = time.time()

    # Consideramos "cerrados" cuando no vemos ojos abiertos
    currently_closed = (abiertos == 0 and cerrados >= 1)

    if currently_closed and not _eyes_closed:
        _eyes_closed = True
        _close_start = now
        return False

    if currently_closed and _eyes_closed:
        return False

    if not currently_closed and _eyes_closed:
        dur_ms = (now - _close_start) * 1000.0
        _eyes_closed = False
        if dur_ms >= LONG_BLINK_MS:
            return True

    return False
