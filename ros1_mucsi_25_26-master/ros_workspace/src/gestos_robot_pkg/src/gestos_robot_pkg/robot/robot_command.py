#!/usr/bin/env python3
from gestos_robot_pkg.actions.request_gesture import GestureActionClient
from gestos_robot_pkg.msg import Gesture
import rospy
import actionlib
import time

class Player:
    def __init__(self, color, type):
        self.color = color
        self.type = type
        self.position = 0

class Robot_Command:
    def __init__(self, gesture_server : GestureActionClient):
        self.gesture_server = gesture_server
        self.on = False
        self.players = []
        
        rospy.Subscriber("/gestos/stream", Gesture, self.stream_callback)
    
    def stream_callback(self, msg):
        """Start or stop gesture detection loop."""
        gesture_type = msg.type

        if gesture_type == "Inicio (mano abierta)" and not self.on:
            rospy.loginfo("[GESTURE-STREAM] >>> INICIO recibido. Comenzando escucha.")
            self.on = True
            self.players = self.set_up()

        elif gesture_type == "Detener (parpadeo largo)" and self.on:
            rospy.loginfo("[GESTURE-STREAM] >>> DETENER recibido. Terminando escucha.")
            self.on = False
    
    def set_up(self):
        # Choose number of players 
        num_player = 0
        while num_player == 0:
            rospy.loginfo("[SET-UP] >>> Elegir numero de jugadores :")
            result = self.gesture_server.request_gesture()
            print(f"result : {result}")
            if result == "Ficha roja (0 dedos)" :
                num_player = 1
            elif result == "Ficha amarilla (1 dedo)" :
                num_player = 2
            elif result == "Ficha azul (rock)" :
                num_player = 3
            elif result == "Ficha verde (3 dedos)" :
                num_player = 4
            else :
                rospy.loginfo("[SET-UP] >>> El gesto no es apropiado.")
            time.sleep(2)
                
        rospy.loginfo(f"[SET-UP] >>> Juego inicializado : {num_player} jugador.es")
        
        #Choose colors of players 
        fichas_disponibles = ["Ficha roja (0 dedos)", "Ficha amarilla (1 dedo)", 
                              "Ficha azul (rock)","Ficha verde (3 dedos)"]
        players = []
        for i in range (num_player):
            rospy.loginfo(f"[SET-UP] >>> Elegir el color del jugadore {i} :")
            color = None
            while color is None :
                result = self.gesture_server.request_gesture()
                if result in fichas_disponibles:
                    color = result
                    fichas_disponibles.remove(result)
                else : 
                    rospy.loginfo(f"[SET-UP] >>> El gesto no es apropiado :")
                    rospy.loginfo(f"[SET-UP] >>> Elegir el color del jugadore {i} :")
                time.sleep(2)
            players.append(color)
        return players
            
    

if __name__ == "__main__":
    rospy.init_node("robot_command")
    server = GestureActionClient()
    client = Robot_Command(server)
    # Example repeated calls
    rospy.loginfo("[ROBOT-COMMAND] Node started, waiting for gestures...")
    rospy.spin()
    #client.spin()