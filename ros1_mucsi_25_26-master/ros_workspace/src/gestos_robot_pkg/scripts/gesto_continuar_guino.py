from src.core.video import Video
from src.detectors.face_detector import Face
from src.detectors.gestures_face import es_guiño
from src.ui.overlay import draw_status

cam, face = Video(), Face()
while True:
    ok, frame = cam.read(); 
    if not ok: break
    fl = face.detect(frame)
    if fl and es_guiño(fl):
        draw_status(frame, "Continuar (guiño) 😉")
    cam.show("guiño", frame)
    if cam.key_pressed(1) == 27: break
cam.release()
