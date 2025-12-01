from src.core.video import Video
from src.detectors.hands_detector import Hands
from src.detectors.face_detector import Face
from src.detectors.gestures_hand import contar_dedos, es_rock, tirar_dado_dx
from src.detectors.gestures_face import es_guiño, es_parpadeo_largo
from src.ui.overlay import draw_status

cam, hands, face = Video(), Hands(), Face()
while True:
    ok, frame = cam.read(); 
    if not ok: break
    lms = hands.detect(frame)
    fl = face.detect(frame)

    if lms:
        dedos = contar_dedos(lms)
        if dedos == 5: draw_status(frame, "Inicio (5 dedos)")
        elif dedos == 0: draw_status(frame, "Roja (0 dedos)")
        elif dedos == 1: draw_status(frame, "Amarilla (1 dedo)")
        elif dedos == 2: draw_status(frame, "Verde (2 dedos)")
        elif es_rock(lms): draw_status(frame, "Azul (🤘)")
        if tirar_dado_dx(lms): draw_status(frame, "Tirar dado (👋)")

    if fl:
        if es_guiño(fl): draw_status(frame, "Continuar (guiño)")
        if es_parpadeo_largo(fl): draw_status(frame, "Detener (parpadeo largo)")

    cam.show("demo", frame)
    if cam.key_pressed(1) == 27: break
cam.release()
