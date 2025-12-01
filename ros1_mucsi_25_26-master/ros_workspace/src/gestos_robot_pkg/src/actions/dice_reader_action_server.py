#!/usr/bin/env python3
import rospy
import cv2
import time
import actionlib
from std_msgs.msg import String
from gestos_robot.msg import GestoAction, GestoResult
from msg import DiceReadAction, DiceReadResult, DiceReadFeedback
from src.core.video import Video
from src.detectors.dice_detector import DiceDetector

class DiceReadServer:
    def __init__(self):
        # Inicializa nodo ROS
        rospy.init_node("dice_reader_action_server")

        rospy.loginfo("[DADO] Inicializando cámara del dado...")

        # Suscripción a la cámara del dado
        self.video_dice = Video(
            topic_name="/camera_dice/image_raw",  # Topic ROS de la cámara del dado
            config_path="src/config/settings.yaml",
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
        cv2.namedWindow("Camara Dado - Action Server", cv2.WINDOW_NORMAL)
        rospy.loginfo("[DADO] Solicitud recibida: leyendo dado...mostrando cámara durante 30s.")

        while not rospy.is_shutdown():

            # ❗ Si pasaron 30s -> cerrar ventana y salir
            if time.time() - start_time > window_duration:
                rospy.loginfo("Cerrando ventana del dado después de 30 segundos.")
                try:
                    cv2.destroyWindow("Camara Dado - Action Server")
                except Exception:
                    pass
                break

            ok, frame = self.video_dice.read()
            if not ok or frame is None:
                rospy.sleep(0.03)
                continue

            # Mostrar ventana
            cv2.imshow("Camara Dado - Action Server", frame)
            cv2.waitKey(1)

            # Probar detección
            value, annotated = self.detector.detect(frame)  # tu detect devuelve (value, frame_annot)
            feedback.status = f"Intentando detectar... valor={value}"
            self.server.publish_feedback(feedback)

            if value is not None:
                result.value = int(value)
                try:
                    cv2.destroyWindow("Camara Dado - Action Server")
                except Exception:
                    pass
                self.server.set_succeeded(result)
                return

            rospy.sleep(0.05)

        # Si no detectó nada en 30s
        result.value = -1
        self.server.set_aborted(result)

if __name__ == "__main__":
    DiceReadServer()
    rospy.spin()
