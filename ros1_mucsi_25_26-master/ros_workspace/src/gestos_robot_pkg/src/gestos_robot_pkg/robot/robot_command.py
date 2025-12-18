#!/usr/bin/env python3
from gestos_robot_pkg.actions.request_gesture import GestureActionClient
from gestos_robot_pkg.actions.request_dice import DiceActionClient
from gestos_robot_pkg.actions.request_tablero import TableroActionClient
from gestos_robot_pkg.msg import Gesture
#from detector_tablero.src.detector_tablero.scripts.request_tablero import TableroActionClient
import rospy
import actionlib
import time
from copy import deepcopy
import random

class Player:
    def __init__(self, color, type):
        self.color = color
        self.type = type
        self.position = 0
        self.trapped = False
        self.replay = False
        
class Robot_Command:
    def __init__(self, 
                 gesture_server : GestureActionClient,
                 tablero_server : TableroActionClient,
                 dice_server=None):
        self.gesture_server = gesture_server
        self.dice_server = dice_server
        self.tablero_server = tablero_server
        self.on = False
        self.players = []
        self.cells = None
        self.pieces = None
        self.terminated = False
        
        rospy.Subscriber("/gestos/stream", Gesture, self.stream_callback)
    
    def stream_callback(self, msg):
        """Start or stop gesture backend detection loop."""
        gesture_type = msg.type

        if gesture_type == "(mano abierta)" and not self.on:
            rospy.loginfo("[GESTURE-STREAM] >>> INICIO recibido. Comenzando escucha.")
            self.on = True
            self.cells = None
            while self.cells is None:
                self.cells = self.tablero_server.request_tablero(modo=0)
            self.setup_players()
            self.pieces = self.tablero_server.request_tablero()
            self.game()

        elif gesture_type == "(parpadeo largo)" and self.on:
            rospy.loginfo("[GESTURE-STREAM] >>> DETENER recibido. Terminando escucha.")
            self.on = False
    
    def setup_players(self):
        """Select the number of players as well as their colors and types""" 
        num_player = 0
        rospy.loginfo("[SET-UP] >>> Elegir numero de jugadores (1-3) :")
        while num_player == 0:
            result = self.gesture_server.request_gesture()
            if result == "(1 dedo)" :
                num_player = 1
            elif result == "(rock)" :
                num_player = 2
            elif result ==  "(3 dedos)" :
                num_player = 3
            time.sleep(2)
        rospy.loginfo(f"[SET-UP] >>> Juego inicializado : {num_player} jugador.es")
        
        #Choose colors and type of players 
        fichas_disponibles = {"(0 dedos)":"rojo",  "(rock)":"azul", "(3 dedos)":"verde"}
        possible_types = {"(1 dedo)":"human", "(pulgar arriba)":"robot"}

        for i in range (num_player):
            rospy.loginfo(f"[SET-UP] >>> Elegir el color del jugadore {i} :")
            color = None
            type = None
            while color is None :
                result = self.gesture_server.request_gesture()
                if result in fichas_disponibles.keys():
                    color = fichas_disponibles[result]
                    del fichas_disponibles[result]
                    rospy.loginfo(f"[SET-UP] >>> Jugadore {i} is {color}:")
                    rospy.loginfo(f"[SET-UP] >>> Elegir el tipo del jugadore {i} :")
                    while type is None :
                        result = self.gesture_server.request_gesture()
                        if result in possible_types.keys():
                            type = possible_types[result]
                            rospy.loginfo(f"[SET-UP] >>> Jugadore {i} is {type}:")
                    time.sleep(2)
                time.sleep(2)
            new_player = Player(color, type)
            self.players.append(new_player)

    def check_termination(self, player):
        """Check if there is a winner""" 
        if player.position == 19 :
            rospy.loginfo(f"[Game] >>> Player {player.color} has won : Congratulations ! ")
            self.terminated = True

    def check_rules(self, player):
        """Check whether the current cell has an associated rule"""
        color_cell = self.cells[player.position].color
        player.replay = False
        #Oca
        if color_cell == "amarillo":
            rospy.loginfo(f"[Game] >>>  Goose cell : go to next similar")
            following_cells = deepcopy(self.cells)
            following_cells = following_cells[player.position +1:]
            next_cell = next((c for c in following_cells if c.color == "amarillo"), None)
            rospy.loginfo(f"[Game] >>> next similar = {next_cell.idx}")
            player.position = next_cell.idx
            #move piece to next cell
        #Posada
        elif color_cell == "rosa":
            rospy.loginfo(f"[Game] >>>  Well cell : stqy trapped")
            player.trapped = True
        #Calavera
        elif color_cell == "morado":
            rospy.loginfo(f"[Game] >>>  skull cell : go back to start")
            #move piece to start()
            player.position = 0
            rospy.loginfo(f"[Game] >>>  new position : {player.position}")
        elif color_cell == "naranja":
            rospy.loginfo(f"[Game] >>>  dice cell : replay")
            player.replay = True
        

    def human_turn(self,player):
        rospy.loginfo(f"[Game] >>> Player {player.color} : your turn !")
        rospy.loginfo(f"[Game] >>> Once finished please do : gesture '1 dedo'")
        finished = False
        while not finished : 
            result = self.gesture_server.request_gesture()
            if result == "(1 dedo)" :
                finished = True
            else :
                time.sleep(1)
        self.pieces = self.tablero_server.request_tablero()
        player_piece = next((p for p in self.pieces if p.color == player.color), None)
        if player_piece is not None : 
            player.position = player_piece.idx
        else : 
            rospy.loginfo(f"[Game] >>> Player {player.color} : piece out of bound !")
        return player_piece
    
    def robot_turn(self,player):
        rospy.loginfo(f"[Game] >>> Player {player.color} : robot's turn !")
        rospy.loginfo(f"[Game] >>> Tell him to throw the dice : gesture 'pulgar arriba'")
        finished = False
        while not finished : 
            result = self.gesture_server.request_gesture()
            if result == "(pulgar arriba)" :
                finished = True
            else :
                time.sleep(1)
        #throwthedice() 
        '''dice_value = -1
        while dice_value == -1 :
            dice_value = self.dice_server.request_dice()
            time.sleep(1)'''
        dice_value = random.randint(1,6)
        rospy.loginfo(f"[Game] >>>  dice = {dice_value}")
        player_piece = next((p for p in self.pieces if p.color == player.color), None)
        if player_piece is not None : 
            player.position += dice_value
            rospy.loginfo(f"[Game] >>>  new position = {player.position}")
            current_pose = player_piece.pose
            new_cell = self.cells[player.position]
            # robot move_piece_to_cell(pose_piece, new_cell.pose)

    def game(self):
        """Game mechanic for a normal turn""" 
        while self.on and not self.terminated :
            for player in self.players :
                #Check if trapped for the turn
                if player.trapped :
                        rospy.loginfo(f"[Game] >>> Player {player.color} : you are trapped !")
                        rospy.loginfo(f"[Game] >>> Wait your next turn")
                        player.trapped = False
                #If not we consider he'll play at least once
                player.replay = True
                while player.replay: 
                    if player.type == "human" :
                        self.human_turn(player)
                    else :  
                        self.robot_turn(player)
                    self.check_termination(player) 
                    self.check_rules(player) #if not replay cell sets player.replay at False and breaks loop
                   
    

if __name__ == "__main__":
    rospy.init_node("robot_command")
    gesture_server = GestureActionClient()
    #dice_server = DiceActionClient()
    tablero_server = TableroActionClient()
    client = Robot_Command(gesture_server, tablero_server)
    # Example repeated calls
    rospy.loginfo("[ROBOT-COMMAND] Node started, waiting for gestures...")
    rospy.spin()