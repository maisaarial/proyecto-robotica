#!/usr/bin/env python3
import rospy

# Mensajes de visión
from vision_pkg.msg import GazeInfo, DiceInfo, GestureInfo
# Servicio para pedir estado del tablero
from vision_pkg.srv import BoardState
# Servicio para mover fichas con el robot
from robot_pkg.srv import MovePiece

class GameMaster:
    def __init__(self):
        rospy.loginfo("Inicializando Game Master...")
        
