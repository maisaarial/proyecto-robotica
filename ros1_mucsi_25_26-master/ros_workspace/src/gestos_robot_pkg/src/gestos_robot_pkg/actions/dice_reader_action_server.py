#!/usr/bin/env python3
import rospy
import cv2
import time
import actionlib
from std_msgs.msg import String
from gestos_robot_pkg.msg import GestoAction, GestoResult
from gestos_robot_pkg.msg import FaceGestureAction, FaceGestureResult
from gestos_robot_pkg.msg import DiceReadAction, DiceReadResult, DiceReadFeedback
from gestos_robot_pkg.core.video import Video
from gestos_robot_pkg.detectors.dice_detector import DiceDetector

class DiceReadServer:
    def __init__(self):
        # Inicializa nodo ROS
        rospy.init_node("dice_reader_action_server")
        rospy.loginfo("[DADO] Inicializando cámara del dado...")

        # Suscripción a la cámara del dado
        self.video_dice = Video(
            topic_name="/usb_cam/image_raw",  # Topic ROS de la cámara del dado
            config_path="/home/laboratorio/ros_workspace/src/gestos_robot_pkg/config/settings.yaml",
            section="dice_camera", 
            wait_timeout=3.0
        )

        # Detector de dado
        self.detector = DiceDetector()

        # Crea el Action Server
        self.server = actionlib.SimpleActionServer(
            "read_dice",           # nombre del action
            DiceReadAction,        # tipo definido en DiceRead.action
            execute_cb=self.execute_cb,
            auto_start=False
        )
        self.server.start()
        rospy.loginfo("[DADO] Action Server listo: /read_dice")

    def execute_cb(self, goal):
        start_time = time.time()         # <--- Guardamos tiempo inicial
        window_duration = 30.0           # <--- Duración máxima (segundos)
        feedback = DiceReadFeedback()
        result = DiceReadResult()

        #Mostrar la ventana de la cámara del dado
        while not rospy.is_shutdown():

            # ❗ Si pasaron 30s -> cerrar ventana y salir
            if time.time() - start_time > window_duration:
                rospy.loginfo("No hemos detectado un dado después de 30 segundos.")
                break

            frame = self.video_dice.read()
            if frame is None:
                rospy.sleep(0.03)
                continue

            # Probar detección
            value, annotated = self.detector.detect(frame)  # tu detect devuelve (value, frame_annot)
            feedback.status = f"Intentando detectar... valor={value}"
            self.server.publish_feedback(feedback)

            if value is not None:
                result.value = int(value)
                self.server.set_succeeded(result)
                return

            rospy.sleep(0.05)

        # Si no detectó nada en 30s
        result.value = -1
        self.server.set_aborted(result)

if __name__ == "__main__":
    client = DiceReadServer()
    rospy.spin()
