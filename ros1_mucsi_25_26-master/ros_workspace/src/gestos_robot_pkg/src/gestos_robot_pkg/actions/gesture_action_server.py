#!/usr/bin/env python
import rospy
import actionlib
import time

from gestos_robot_pkg.msg import GestoAction, GestoResult, GestoFeedback
from gestos_robot_pkg.core.events import GestureEvent
from gestos_robot_pkg.core.video import Video
from gestos_robot_pkg.detectors.hands_detector import Hands
from gestos_robot_pkg.detectors.gestures_hand import clasificar_gesto_mano, es_rock_roi, gesto_tirar_dado_roi
from gestos_robot_pkg.detectors.gestures_face import es_guiño_roi, es_parpadeo_largo_roi


class GestureActionServer:
    def __init__(self):
        rospy.init_node("gesture_action_server")
        rospy.loginfo("[GESTURE-AS] Inicializando...")

        self.video_dice = Video(
            topic_name="/cam_dado/image_raw", #hay que cambiar el nombre
            config_path="/home/laboratorio/ros_workspace/src/gestos_robot_pkg/config/settings.yaml",
            section="dice_camera",
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
        rospy.loginfo(f"[GESTURE-AS] Goal recibido: detectar")
        start_time = time.time()
        timeout = 15.0  # segundos para intentar detectar
        feedback = GestoFeedback()
        result = GestoResult()
    

        while not rospy.is_shutdown() and time.time() - start_time < timeout:
            # -------------------------
            # LECTURA DE CÁMARAS
            # -------------------------
            frame_dice = self.video_dice.read()
            if frame_main is None:
                print("[APP] No se pudo leer frame de la cámara principal.")
                break

            # -------------------------
            # DETECCIÓN DE MANO  (MediaPipe -> ROI)
            # -------------------------
            roi_hand, bbox_hand = self.hands.detect(frame_main, draw_bbox=True)

            # comprobar condiciones según target
            detected = False
            if frame_dice is not None:
            # -------- DETECCIÓN DE MANO --------
            mano_detectada = roi_hand is not None

            if mano_detectada:
                # Procesar gestos de mano
                gesto_mano, dedos = clasificar_gesto_mano(roi_hand)

                if dedos is not None:
                    if dedos == 0:
                        gesture = GestureEvent.FICHA_ROJA
                        gesture_label = "(0 dedos)" #antes: Ficha roja (0 dedos)
                        gesture_label_mano = gesture_label
                    elif dedos == 1:
                        gesture = GestureEvent.FICHA_AMARILLA
                        gesture_label = "(1 dedo)" #antes: Ficha amarilla (1 dedo),ahora se utiliza para player 1 y human
                        gesture_label_mano = gesture_label
                    elif dedos == 3:
                        gesture = GestureEvent.FICHA_VERDE
                        gesture_label = "(3 dedos)" #antes: Ficha verde (3 dedos)
                        gesture_label_mano = gesture_label

                # Rock (ficha azul) tiene prioridad sobre otros gestos con 2 dedos
                if es_rock_roi(roi_hand):
                    gesture = GestureEvent.FICHA_AZUL
                    gesture_label = "(rock)" #antes: Ficha azul (🤘)
                    gesture_label_mano = gesture_label

                # Tirar dado (pulgar arriba)
                if bbox_hand is not None and gesto_tirar_dado_roi(roi_hand, bbox_hand):
                    gesture = GestureEvent.TIRAR_DADO
                    gesture_label = "(pulgar arriba)" #antes: Tirar dado (pulgar arriba)
                    gesture_label_mano = gesture_label
            
            feedback.status = f"Buscando"
            self._as.publish_feedback(feedback)

            if detected:
                self._as.set_succeeded(result)
                rospy.loginfo(f"[GESTURE-AS] detectado.")
                return

            rospy.sleep(0.05)

        # timeout sin detección
        rospy.logwarn(f"[GESTURE-AS] Timeout detectando")
        self._as.set_aborted(result)

if __name__ == "__main__":
    GestureActionServer()
    rospy.spin()