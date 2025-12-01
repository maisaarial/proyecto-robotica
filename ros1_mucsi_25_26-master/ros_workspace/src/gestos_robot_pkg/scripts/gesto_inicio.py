from src.core.video import Video
from src.detectors.hands_detector import Hands
from src.detectors.gestures_hand import contar_dedos
from src.ui.overlay import draw_status

cam, hands = Video(), Hands()
while True:
    ok, frame = cam.read(); 
    if not ok: break
    lms = hands.detect(frame)
    if lms and contar_dedos(lms) == 5:
        draw_status(frame, "Inicio detectado ✅")
    cam.show("inicio", frame)
    if cam.key_pressed(1) == 27: break
cam.release()
 