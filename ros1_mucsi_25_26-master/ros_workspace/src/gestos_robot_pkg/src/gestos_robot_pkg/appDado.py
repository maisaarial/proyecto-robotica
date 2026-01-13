#!/usr/bin/env python

import cv2
import time

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

from gestos_robot_pkg.detectors.dice_detector import DiceDetector

from gestos_robot_pkg.ui.overlay import draw_status, draw_text


def main():
    # -------------------------
    # Inicializaciones
    # -------------------------
    rospy.init_node('dado_robot_node', anonymous=True)
    
    
    video_main = Video(
        topic_name="/cam_dado/image_raw", #hay que cambiar
        config_path="/home/laboratorio/ros_workspace/src/gestos_robot_pkg/config/settings.yaml",
        section="camera")
    video_dice = Video(
        topic_name="/cam_dado/image_raw", #hay que cambiar
        config_path="/home/laboratorio/ros_workspace/src/gestos_robot_pkg/config/settings.yaml",
        section="camera")

    hands = Hands()
    face = Face()
    dice_detector = DiceDetector()

    fsm = FSM()
    robot = Robot(mode="stub")  # Cambia a "real" cuando tengas el robot físico
    mapper = ActionMapper(fsm, robot)

    print("[APP] Iniciando loop principal. ESC para salir.")
    pub_gesture = rospy.Publisher("/gestos/stream", Gesture, queue_size=10)
    # -------------------------
    # Variables para confirmación de gesto
    # -------------------------
    last_gesture = GestureEvent.NONE
    gesture_start_time = None
    GESTO_CONFIRMAR_SEG = 2.0  # segundos

    while True:
        # -------------------------
        # LECTURA DE CÁMARAS
        # -------------------------
        frame_main = video_main.read()
        if frame_main is None:
            rospy.logwarn("[APP] No se pudo leer frame de la cámara principal.")
            rospy.sleep(0.05)
            continue

        frame_dice = video_dice.read()
        if frame_dice is None:
            frame_dice = None

        gesture = GestureEvent.NONE
        gesture_label = ""
        dice_value = None

        # -------------------------
        # DETECCIÓN DE MANO
        # -------------------------
        roi_hand, bbox_hand = hands.detect(frame_main, draw_bbox=True)
        if roi_hand is not None:
            gesto_mano, dedos = clasificar_gesto_mano(roi_hand)

            if dedos is not None:
                if dedos is not None and dedos >= 4:
                    gesture = GestureEvent.INICIO
                    gesture_label = "(mano abierta)"
                elif dedos == 0:
                    gesture = GestureEvent.FICHA_ROJA
                    gesture_label = "(0 dedos)"
                elif dedos == 1:
                    gesture = GestureEvent.FICHA_AMARILLA
                    gesture_label = "(1 dedo)"
                elif dedos == 3:
                    gesture = GestureEvent.FICHA_VERDE
                    gesture_label = "Ficha verde (3 dedos)"

            if es_rock_roi(roi_hand):
                gesture = GestureEvent.FICHA_AZUL
                gesture_label = "(rock)"

            if bbox_hand is not None and gesto_tirar_dado_roi(roi_hand, bbox_hand):
                gesture = GestureEvent.TIRAR_DADO
                gesture_label = "(pulgar arriba)"


        # -------------------------
        # DETECCIÓN DE ROSTRO
        # -------------------------
        roi_face, bbox_face = face.detect(frame_main, draw_bbox=True)
        if roi_face is not None:
            gray_face = cv2.cvtColor(roi_face, cv2.COLOR_BGR2GRAY)
            if es_guiño_roi(gray_face):
                gesture = GestureEvent.CONTINUAR
                gesture_label = "(guiño)"
            if es_parpadeo_largo_roi(gray_face):
                gesture = GestureEvent.DETENER
                gesture_label = "(parpadeo largo)"

        # -------------------------
        # DETECCIÓN DEL DADO
        # -------------------------
        if frame_dice is not None:
            dice_value, frame_dice_annot = dice_detector.detect(frame_dice)
            label_dado = str(dice_value) if dice_value is not None else "?"
            draw_text(frame_dice_annot, f"Dado: {label_dado}", (20, 40), color=(0, 255, 0))
            frame_dice = frame_dice_annot
            draw_text(frame_main, f"Dado: {label_dado}", (20, 80), color=(0, 255, 0))

        # -------------------------
        # LÓGICA DE CONFIRMACIÓN DE GESTO
        # -------------------------
        current_time = time.time()
        confirmed_gesture = None
        countdown_text = ""
        if gesture != GestureEvent.NONE:
            

            # Manejar FSM + robot
            mapper.handle(gesture)
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
                        gesture_start_time = None
                        last_gesture = GestureEvent.NONE
                        msg = Gesture()
                        msg.type = gesture_label
                        msg.source = "mano" if roi_hand is not None else "rostro"
                        msg.fingers = dedos if dedos is not None else -1
                        msg.long_blink = False
                        pub_gesture.publish(msg)
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
        draw_status(frame_main, state_text, gesture_label)
        if countdown_text:
            draw_text(frame_main, countdown_text, (20, 120), color=(0, 200, 255), scale=0.7)

        # -------------------------
        # MOSTRAR VENTANAS
        # -------------------------
        video_main.show("Gestos - Juego con Robot", frame_main)
        #if frame_dice is not None:
        #    video_dice.show("Cámara dado", frame_dice)

        key = video_main.key_pressed(1)
        if key == 27:  # ESC
            print("[APP] ESC presionado. Saliendo.")
            break

    video_main.release()
    video_dice.release()


if __name__ == "__main__":
    main()