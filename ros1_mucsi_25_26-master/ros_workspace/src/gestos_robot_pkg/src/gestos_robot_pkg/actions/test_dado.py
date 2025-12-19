#!/usr/bin/python3
import cv2
from gestos_robot_pkg.core.video import Video
from gestos_robot_pkg.detectors.dice_detector import DiceDetector
from gestos_robot_pkg.ui.overlay import draw_text

def main():

    video = Video(
            topic_name="/usb_cam/image_raw",  # Topic ROS de la cámara del dado
            config_path="/home/laboratorio/ros_workspace/src/gestos_robot_pkg/config/settings.yaml",
            section="camera")
    detector = DiceDetector()

    while True:
        frame = video.read()
        if frame is None:
            break

        numero, frame_annot = detector.detect(frame)
        label = str(numero) if numero is not None else "?"

        draw_text(frame_annot, f"Dado: {label}", (20,40), color=(0,255,0))

        video.show("Camara dado", frame_annot)

        if video.key_pressed(1) == 27:
            break

if __name__ == "__main__":
    main()
