import cv2
from src.core.video import Video
from src.detectors.hands_detector import Hands

def main():
    video = Video("src/config/settings.yaml")
    hands = Hands()

    print("[TEST] Mostrando ROI de la mano…")
    print("[TEST] Pulsa ESC para salir")

    while True:
        ok, frame = video.read()
        if not ok:
            break

        roi_hand, bbox = hands.detect(frame, draw_bbox=True)

        # Mostrar la ROI en una ventana aparte
        if roi_hand is not None:
            cv2.imshow("ROI Mano", roi_hand)
        else:
            cv2.imshow("ROI Mano", frame*0)  # ventana negra cuando no hay ROI

        # Mostrar el frame general
        cv2.imshow("Frame", frame)

        if cv2.waitKey(1) == 27:
            break

    video.release()

if __name__ == "__main__":
    main()
