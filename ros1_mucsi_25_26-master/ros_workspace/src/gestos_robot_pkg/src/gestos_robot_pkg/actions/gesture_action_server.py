#!/usr/bin/env python
import rospy
import actionlib
import time
import cv2
from gestos_robot_pkg.msg import Gesture
from gestos_robot_pkg.msg import GestoAction, GestoResult, GestoFeedback
from gestos_robot_pkg.core.video import Video
from gestos_robot_pkg.detectors.hands_detector import Hands
from gestos_robot_pkg.detectors.face_detector import Face
from gestos_robot_pkg.detectors.gestures_hand import clasificar_gesto_mano, es_rock_roi, gesto_tirar_dado_roi
from gestos_robot_pkg.detectors.gestures_face import es_guiño_roi, es_parpadeo_largo_roi


class GestureActionServer:
    def __init__(self):
        rospy.init_node("gesture_action_server")
        rospy.loginfo("[GESTURE-AS] Inicializando...")

        self.video_main = Video(
            topic_name="/usb_cam/image_raw", #hay que cambiar el nombre
            config_path="/home/laboratorio/ros_workspace/src/gestos_robot_pkg/config/settings.yaml",
            section="camera",
            wait_timeout=3.0
        )
        self.hands = Hands()
        self.face = Face()

        self._as = actionlib.SimpleActionServer(
            'gesto_action',
            GestoAction,
            execute_cb=self.execute_cb,
            auto_start=False
        )
        self._as.start()
        rospy.loginfo("[ActionServer] Listo para gestos por petición")

    # Execute callback para gestos por petición (fichas)
    def execute_cb(self, goal):
        """Goal.gesture es el nombre del gesto a detectar (string)."""
        target = getattr(goal, "gesture", None)
        if not target:
            rospy.logwarn("[GESTURE-AS] Goal sin 'gesture'. Abortando.")
            res = GestoResult()
            self._as.set_aborted(res)
            return

        rospy.loginfo(f"[GESTURE-AS] Goal recibido: detectar '{target}'")
        start_time = time.time()
        timeout = 15.0  # segundos para intentar detectar
        feedback = GestoFeedback()
        result = GestoResult()
    

        while not rospy.is_shutdown() and time.time() - start_time < timeout:
            # -------------------------
            # LECTURA DE CÁMARAS
            # -------------------------
            ok_main, frame_main = self.video_main.read()
            if not ok_main:
                print("[APP] No se pudo leer frame de la cámara principal.")
                break

            # -------------------------
            # DETECCIÓN DE MANO Y CARA (MediaPipe -> ROI)
            # -------------------------
            roi_hand, bbox_hand = self.hands.detect(frame_main, draw_bbox=True)
            roi_face, bbox_face = self.face.detect(frame_main, draw_bbox=False)

            # comprobar condiciones según target
            detected = False
            # Fichas por número de dedos
            if target == "FICHA_ROJA" or target == "FICHA_AMARILLA" or target == "FICHA_VERDE":
                if roi_hand is not None:
                    _, dedos = clasificar_gesto_mano(roi_hand)
                    if dedos is not None:
                        if (target == "FICHA_ROJA" and dedos == 0) or \
                           (target == "FICHA_AMARILLA" and dedos == 1) or \
                           (target == "FICHA_VERDE" and dedos == 2):
                            detected = True
                            result.type = target
                            result.source = "mano"
                            result.fingers = int(dedos)
                            result.rock = False
                            result.wink = False
            elif target == "FICHA_AZUL":
                if roi_hand is not None and es_rock_roi(roi_hand):
                    detected = True
                    result.type = target
                    result.source = "mano"
                    result.fingers = -1
                    result.rock = True
                    result.wink = False
            elif target == "TIRAR_DADO":
                # detecta el gesto de tirar_dado (por ejemplo movimiento)
                if roi_hand is not None and bbox_hand is not None and gesto_tirar_dado_roi(roi_hand, bbox_hand):
                    detected = True
                    result.type = target
                    result.source = "mano"
                    result.fingers = -1
                    result.rock = False
                    result.wink = False
            elif target == "CONTINUAR":
                if roi_face is not None:
                    gray_face = cv2.cvtColor(roi_face, cv2.COLOR_BGR2GRAY)
                    if es_guiño_roi(gray_face):
                        detected = True
                        result.type = target
                        result.source = "rostro"
                        result.fingers = -1
                        result.wink = True
                        result.rock = False


            feedback.status = f"Buscando {target}"
            self._as.publish_feedback(feedback)

            if detected:
                self._as.set_succeeded(result)
                rospy.loginfo(f"[GESTURE-AS] '{target}' detectado.")
                return

            rospy.sleep(0.05)

        # timeout sin detección
        rospy.logwarn(f"[GESTURE-AS] Timeout detectando '{target}'")
        self._as.set_aborted(result)

if __name__ == "__main__":
    GestureActionServer()
    rospy.spin()