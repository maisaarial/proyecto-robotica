import cv2
import time

# Pequeño helper para FPS global
_last_time = time.time()
_fps = 0.0


def update_fps():
    global _last_time, _fps
    now = time.time()
    dt = now - _last_time
    _last_time = now
    if dt > 0:
        _fps = 1.0 / dt
    return _fps


def draw_text(img, text, org, scale=0.7, color=(0, 255, 0), thickness=2):
    """
    Dibuja texto con un pequeño borde para que se vea mejor.
    """
    x, y = org
    # Sombra negra
    cv2.putText(img, text, (x + 1, y + 1),
                cv2.FONT_HERSHEY_SIMPLEX, scale, (0, 0, 0), thickness + 1, cv2.LINE_AA)
    # Texto principal
    cv2.putText(img, text, (x, y),
                cv2.FONT_HERSHEY_SIMPLEX, scale, color, thickness, cv2.LINE_AA)


def draw_status(frame, state_text: str, gesture_text: str = ""):
    """
    Dibuja:
      - Estado actual
      - Último gesto detectado (opcional)
      - FPS
    """
    h, w, _ = frame.shape

    fps = update_fps()
    draw_text(frame, f"FPS: {fps:.1f}", (10, 25), scale=0.6, color=(0, 255, 255))

    draw_text(frame, f"Estado: {state_text}", (10, 55), scale=0.7, color=(255, 255, 255))

    if gesture_text:
        draw_text(frame, f"Gesto: {gesture_text}", (10, 85), scale=0.7, color=(0, 200, 255))
