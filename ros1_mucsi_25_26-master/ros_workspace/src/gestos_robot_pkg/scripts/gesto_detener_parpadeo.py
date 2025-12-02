from src.core.video import Video
from src.detectors.face_detector import Face
from src.detectors.gestures_face import es_parpadeo_largo
from src.ui.overlay import draw_status

cam, face = Video(), Face()
while True:
    ok, frame = cam.read(); 
    if not ok: break
    fl = face.detect(frame)
    if fl and es_parpadeo_largo(fl):
        draw_status(frame, "⛔ Detener juego")
    cam.show("parpadeo_largo", frame)
    if cam.key_pressed(1) == 27: break
cam.release()
