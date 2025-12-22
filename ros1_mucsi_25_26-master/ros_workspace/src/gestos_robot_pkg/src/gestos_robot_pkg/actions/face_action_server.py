#!/usr/bin/env python
#hand action server
import rospy
import actionlib
import time
import cv2
from gestos_robot_pkg.msg import Gesture
from gestos_robot_pkg.msg import GestoAction, GestoResult, GestoFeedback
from gestos_robot_pkg.msg import FaceGestureAction, FaceGestureResult
from gestos_robot_pkg.core.events import GestureEvent
from gestos_robot_pkg.core.video import Video
from gestos_robot_pkg.detectors.hands_detector import Hands
from gestos_robot_pkg.detectors.face_detector import Face
from gestos_robot_pkg.detectors.gestures_hand import clasificar_gesto_mano, es_rock_roi, gesto_tirar_dado_roi
from gestos_robot_pkg.detectors.gestures_face import es_guiño_roi, es_parpadeo_largo_roi


class FaceActionServer:
    def __init__(self):
        rospy.init_node("face_action_server")
        rospy.loginfo("[FACE-AS] Inicializando...")

        self.video_main = Video(
            topic_name="/cam_face/image_raw", #hay que cambiar el nombre
            config_path="/home/laboratorio/ros_workspace/src/gestos_robot_pkg/config/settings.yaml",
            section="camera",
            wait_timeout=3.0
        )
        self.hands = Hands()
        self.face = Face()

        self._as = actionlib.SimpleActionServer(
            'face_action',
            FaceGestureAction,
            execute_cb=self.execute_cb,
            auto_start=False
        )
        self._as.start()
        rospy.loginfo("[ActionServer] Listo para gestos de rostro por petición")

    # Execute callback para gestos de cara por petición (continuar)
    def execute_cb(self, goal):
        """Goal.gesture es el nombre del gesto a detectar (string)."""
        rospy.loginfo(f"[FACE-AS] Goal recibido: detectar")
        start_time = time.time()
        timeout = 15.0  # segundos para intentar detectar
        feedback = GestoFeedback()
        result = GestoResult()
    

        while not rospy.is_shutdown() and time.time() - start_time < timeout:
            # -------------------------
            # LECTURA DE CÁMARAS
            # -------------------------
            frame_main = self.video_main.read()
            if frame_main is None:
                print("[APP] No se pudo leer frame de la cámara principal.")
                break

            # -------------------------
            # DETECCIÓN DE CARA (MediaPipe -> ROI)
            # -------------------------
            roi_face, bbox_face = self.face.detect(frame_main, draw_bbox=False)

            # comprobar condiciones según target
            detected = False

            if roi_face is not None:
                gray_face = cv2.cvtColor(roi_face, cv2.COLOR_BGR2GRAY)
                # Guiño -> CONTINUAR
                if es_guiño_roi(gray_face):
                    gesture = GestureEvent.CONTINUAR
                    gesture_label = "Continuar (guiño)"
                    gesture_label_cara = gesture_label
                    detected = True

                feedback.status = f"Buscando"
                self._as.publish_feedback(feedback)

            if detected:
                self._as.set_succeeded(result)
                rospy.loginfo(f"[FACE-AS] detectado.")
                return

            rospy.sleep(0.05)

        # timeout sin detección
        rospy.logwarn(f"[FACE-AS] Timeout detectando")
        self._as.set_aborted(result)

if __name__ == "__main__":
    FaceActionServer()
    rospy.spin()