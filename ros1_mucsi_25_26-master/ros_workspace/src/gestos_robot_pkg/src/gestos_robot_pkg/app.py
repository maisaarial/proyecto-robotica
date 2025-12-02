#!/usr/bin/env python
#ap.py archivo editado para conectarse con ros
import cv2

from gestos_robot_pkg.core.video import Video
from gestos_robot_pkg.core.events import GestureEvent
from gestos_robot_pkg.core.fsm import FSM
from gestos_robot_pkg.actions.robot import Robot
from gestos_robot_pkg.actions.mapping import ActionMapper

from gestos_robot_pkg.detectors.hands_detector import Hands
from gestos_robot_pkg.detectors.face_detector import Face
from gestos_robot_pkg.detectors.gestures_hand import (
    contar_dedos_roi,
    es_rock_roi,
    gesto_tirar_dado_roi,
    clasificar_gesto_mano,
)
from gestos_robot_pkg.detectors.gestures_face import (
    es_guiño_roi,
    es_parpadeo_largo_roi,
)
from gestos_robot_pkg.msg import Gesture
import copy

from gestos_robot_pkg.ui.overlay import draw_status, draw_text
import rospy

def main():
    # -------------------------
    # Inicializaciones
    # -------------------------
    rospy.init_node('gestos_robot_node', anonymous=True)
    
    # -------------------------
    # Cámara principal (gestos mano + rostro)
    # -------------------------
    video_main = Video(
        topic_name="/usb_cam/image_raw", #hay que cambiar
        config_path="/home/laboratorio/ros_workspace/src/gestos_robot_pkg/config/settings.yaml",
        section="camera"
    )

    hands = Hands()
    face = Face()
    fsm = FSM()
    robot = Robot(mode="stub")   # Cambiar el modo cuando tangamos robot real
    mapper = ActionMapper(fsm, robot)

    # -------------------------
    # Publisher de gestos
    # -------------------------
    pub_gesture = rospy.Publisher("/gestos/stream", Gesture, queue_size=10)

    print("[APP] Iniciando loop de streaming. ESC para salir.")

    while not rospy.is_shutdown():
        # -------------------------
        # LECTURA DE CÁMARA
        # -------------------------
        frame_main = video_main.read()
        if frame_main is None:
            rospy.logwarn("[APP] No se pudo leer frame de la cámara principal.")
            rospy.sleep(0.05)
            continue

        gesture = GestureEvent.NONE
        gesture_label = ""
        wink, long_blink = False, False

        # -------------------------
        # DETECCIÓN DE MANO (solo INICIO, 5 dedos)
        # -------------------------
        roi_hand, _ = hands.detect(frame_main, draw_bbox=True)

        if roi_hand is not None:
            # Clasificar gesto de mano (número de dedos)
            _, dedos = clasificar_gesto_mano(roi_hand)
            if dedos == 5:
                gesture = GestureEvent.INICIO
                gesture_label = "Inicio (5 dedos)"

        # -------------------------
        # DETECCIÓN DE ROSTRO (solo DETERNER, parpadeo largo)
        # -------------------------
        roi_face, _ = face.detect(frame_main, draw_bbox=True)
        if roi_face is not None:
            gray_face = cv2.cvtColor(roi_face, cv2.COLOR_BGR2GRAY)
            
            if es_parpadeo_largo_roi(gray_face):
                gesture = GestureEvent.DETENER
                gesture_label = "Detener (parpadeo largo)"
                long_blink = True
        
        # -------------------------
        # Publicar gestos a ROS
        # -------------------------
        if gesture != GestureEvent.NONE:
            msg = Gesture()
            msg.type = gesture_label
            msg.source = "mano" if roi_hand is not None else "rostro"
            msg.fingers = dedos if dedos is not None else -1
            msg.long_blink = long_blink
            pub_gesture.publish(msg)

            # Manejar FSM + robot
            mapper.handle(gesture)

        # Texto de estado en overlay (ventana principal)
        state_text = fsm.state.name
        draw_status(frame_main, state_text, gesture_label)

        # -------------------------
        # MOSTRAR VENTANA
        # -------------------------
        video_main.show("Gestos - Juego con Robot", frame_main)

        key = video_main.key_pressed(1)
        if key == 27:  # ESC
            rospy.loginfo("[APP] ESC presionado. Saliendo del streaming.")
            break

    video_main.release()


if __name__ == "__main__":
    main()