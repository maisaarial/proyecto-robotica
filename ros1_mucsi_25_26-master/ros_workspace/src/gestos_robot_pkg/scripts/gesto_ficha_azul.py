from src.core.video import Video
from src.detectors.hands_detector import Hands
from src.detectors.gestures_hand import es_rock
from src.ui.overlay import draw_status


def main():
    video = Video("src/config/settings.yaml")
    hands = Hands()

    while True:
        ok, frame = video.read()
        if not ok:
            break

        gesture_text = ""
        lms = hands.detect(frame, draw=True)

        if lms is not None and es_rock(lms):
            gesture_text = "Ficha AZUL (🤘 pulgar + meñique)"

        draw_status(frame, "TEST FICHA AZUL", gesture_text)
        video.show("Gesto ficha azul", frame)

        if video.key_pressed(1) == 27:  # ESC
            break

    video.release()


if __name__ == "__main__":
    main()
