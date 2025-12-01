from src.core.video import Video
from src.detectors.hands_detector import Hands
from src.detectors.gestures_hand import tirar_dado_dx
from src.ui.overlay import draw_status

cam, hands = Video(), Hands()
while True:
    ok, frame = cam.read(); 
    if not ok: break
    lms = hands.detect(frame)
    if lms and tirar_dado_dx(lms):
        draw_status(frame, "🎲 Tirar dado!")
    cam.show("tirar_dado", frame)
    if cam.key_pressed(1) == 27: break
cam.release()
