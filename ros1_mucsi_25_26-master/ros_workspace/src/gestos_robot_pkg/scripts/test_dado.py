import cv2
from src.core.video import Video
from src.detectors.dice_detector import DiceDetector
from src.ui.overlay import draw_text

def main():

    video = Video("src/config/settings.yaml", section="dice_camera")
    detector = DiceDetector()

    while True:
        ok, frame = video.read()
        if not ok:
            break

        numero, frame_annot = detector.detect(frame)
        label = str(numero) if numero is not None else "?"

        draw_text(frame_annot, f"Dado: {label}", (20,40), color=(0,255,0))

        video.show("Camara dado", frame_annot)

        if video.key_pressed(1) == 27:
            break

    video.release()

if __name__ == "__main__":
    main()
