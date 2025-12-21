#!/usr/bin/env python
#ap.py archivo editado para conectarse con ros
import cv2
import time
import copy
import rospy

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
from src.detectors.dice_detector import DiceDetector

from gestos_robot_pkg.ui.overlay import draw_status, draw_text


def main():
    # -------------------------
    # Inicializaciones
    # -------------------------   
    rospy.init_node('gestos_robot_node', anonymous=True)
    
    # -------------------------
    # video_main  -> SOLO GESTOS DE CARA (cámara frontal)
    # -------------------------
    video_main = Video(
        topic_name="/usb_cam/image_raw", #hay que cambiar
        config_path="/home/laboratorio/ros_workspace/src/gestos_robot_pkg/config/settings.yaml",
        section="camera"
    )
    # -------------------------
    # video_dice  -> DADO + GESTOS DE MANO (cámara a la mesa)
    # -------------------------
    video_dice = Video(
        topic_name="/usb_cam/image_raw", #hay que cambiar
        config_path="/home/laboratorio/ros_workspace/src/gestos_robot_pkg/config/settings.yaml",
        section="dice_camera"
    )
    hands = Hands()
    face = Face()
    dice_detector = DiceDetector()

    fsm = FSM()
    robot = Robot(mode="stub")   # Cambiar el modo cuando tengamos robot real
    mapper = ActionMapper(fsm, robot)

    # -------------------------
    # Publisher de gestos
    # -------------------------
    pub_gesture = rospy.Publisher("/gestos/stream", Gesture, queue_size=10)

    print("[APP] Iniciando loop de streaming. ESC para salir.")

    # -------------------------
    # Variables para confirmación de gesto
    # -------------------------
    last_gesture = GestureEvent.NONE
    gesture_start_time = None
    GESTO_CONFIRMAR_SEG = 2.0  # segundos

    while not rospy.is_shutdown():
        # -------------------------
        # LECTURA DE CÁMARA
        # -------------------------
        frame_main = video_main.read()
        if frame_main is None:
            rospy.logwarn("[APP] No se pudo leer frame de la cámara principal.")
            rospy.sleep(0.05)
            continue

        frame_dice = video_dice.read()

        # Gesto global (para la FSM)
        gesture = GestureEvent.NONE
        gesture_label = ""

        # Etiquetas separadas (por si utilizamos en el futuro)
        gesture_label_mano = ""
        gesture_label_cara = ""

        dice_value = None
        dedos= None
        gesture_label_str=""
        long_blink = False
        roi_hand = None

        # =====================================================
        # 1) CÁMARA DEL DADO -> GESTOS DE MANO + DADO
        # =====================================================
        if frame_dice is not None:
            # -------- DETECCIÓN DE MANO --------
            roi_hand, bbox_hand = hands.detect(frame_dice, draw_bbox=True)
            mano_detectada = roi_hand is not None

            if mano_detectada:
                # Procesar gestos de mano
                gesto_mano, dedos = clasificar_gesto_mano(roi_hand)

                if dedos is not None:
                    if dedos >= 4:
                        #Por streaming
                        gesture = GestureEvent.INICIO
                        gesture_label = "Inicio (mano abierta)"
                        gesture_label_mano = gesture_label


        # =====================================================
        # 2) CÁMARA PRINCIPAL -> SOLO GESTOS DE CARA
        # =====================================================
        roi_face, bbox_face = face.detect(frame_main, draw_bbox=True)
        if roi_face is not None:
            gray_face = cv2.cvtColor(roi_face, cv2.COLOR_BGR2GRAY)
            #Parpadeo largo -> DETENER
            #Por streaming
            if es_parpadeo_largo_roi(gray_face):
                gesture = GestureEvent.DETENER
                gesture_label = "Detener (parpadeo largo)"
                gesture_label_cara = gesture_label
                long_blink = True

        # -------------------------
        # LÓGICA DE CONFIRMACIÓN DE GESTO
        # -------------------------
        current_time = time.time()
        confirmed_gesture = None
        countdown_text = ""
        confirmed_label = ""

        if gesture != GestureEvent.NONE:
            if gesture == last_gesture:
                # mismo gesto que antes
                if gesture_start_time is None:
                    gesture_start_time = current_time
                else:
                    elapsed = current_time - gesture_start_time
                    remaining = max(0.0, GESTO_CONFIRMAR_SEG - elapsed)
                    countdown_text = f"Confirmando: {remaining:.1f}s"

                    if elapsed >= GESTO_CONFIRMAR_SEG:
                        confirmed_gesture = gesture
                        confirmed_label = gesture_label
                        gesture_start_time = None
                        last_gesture = GestureEvent.NONE
            else:
                # gesto diferente, reiniciamos contador
                last_gesture = gesture
                gesture_start_time = current_time
        else:
            # no hay gesto
            last_gesture = GestureEvent.NONE
            gesture_start_time = None

        # -------------------------
        # FSM + ROBOT (solo si se confirma)
        # -------------------------
        if confirmed_gesture:
            result = fsm.next(confirmed_gesture)
            if result:
                print(f"[FSM] {result}")
                mapper.handle(confirmed_gesture)

        # -------------------------
        # Overlay de estado
        # -------------------------
        state_text = fsm.state.name

        # HUD PRINCIPAL DEL JUEGO -> SOLO en la cámara de dado + mano
        if frame_dice is not None:
            # FPS / Estado / Gesto (arriba a la izquierda)
            draw_status(frame_dice, state_text, gesture_label)
            # Contador un poco más abajo para que no se pise con "Gesto"
            if countdown_text:
                draw_text(frame_dice, countdown_text, (20, 140), color=(0, 200, 255), scale=0.7)
        else:
            # Fallback si no hay cámara de dado
            draw_status(frame_main, state_text, gesture_label)
            if countdown_text:
                draw_text(frame_main, countdown_text, (20, 140), color=(0, 200, 255), scale=0.7)

        # En la ventana de GESTOS CARA solo mostramos texto de la cara,
        # NUNCA info del dado ni de la mano.
        if gesture_label_cara:
            draw_text(frame_main, gesture_label_cara, (20, 40), color=(0, 255, 255), scale=0.7)

        # -------------------------
        # Publicar gestos a ROS en streaming 
        # DETENER (parpadeo largo) + INICIO (mano abierta)
        # -------------------------
        if confirmed_gesture is not None:
            msg = Gesture()
            msg.type = confirmed_label #streaming
            msg.source = "mano" if roi_hand is not None else "rostro"
            msg.fingers = dedos if (confirmed_gesture == GestureEvent.INICIO and dedos is not None) else -1
            msg.long_blink = long_blink
            pub_gesture.publish(msg)

        # -------------------------
        # MOSTRAR VENTANAS
        # -------------------------
        video_main.show("Gestos Cara - Juego con Robot", frame_main)
        if frame_dice is not None:
            video_dice.show("Cámara dado + mano", frame_dice)

        key = video_main.key_pressed(1)
        if key == 27:  # ESC
            print("[APP] ESC presionado. Saliendo.")
            break


    video_main.release()
    video_dice.release()


if __name__ == "__main__":
    main()