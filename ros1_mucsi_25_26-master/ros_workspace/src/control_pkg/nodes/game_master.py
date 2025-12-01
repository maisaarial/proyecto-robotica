#!/usr/bin/env python3
import rospy

# Mensajes de visión
from vision_pkg.msg import GazeInfo, DiceInfo, GestureInfo
# Servicio para pedir estado del tablero
from vision_pkg.srv import BoardState
# Servicio para mover fichas con el robot
from robot_pkg.srv import MovePiece

###  se usará más adelante con los nombres de gestos, etc, cambiados
# estructura
class GameMaster:
    def __init__(self):
        rospy.loginfo("Inicializando Game Master...")

        #  Turnos --> lo ideal seria no meterlo a mano 
        self.players = ["humano_1", "humano_2", "robot"]
        self.player_type = {"humano_1": "human", "humano_2": "human", "robot": "robot"}
        self.current_index = 0
        self.current_player = self.players[self.current_index]

        # Variables internas
        self.game_started = False
        self.pieces_by_player = {p: None for p in self.players}
        self.available_colors = ["rojo", "amarillo", "verde", "azul"]
        self.current_piece = None
        self.last_roll = None
        self.ready_to_move = False

        #  Suscriptores visión 
        # esto hay que cambiarlo a por peticion
        rospy.Subscriber("/gaze_info", GazeInfo, self.on_gaze)
        rospy.Subscriber("/dice_info", DiceInfo, self.on_dice)
        rospy.Subscriber("/gesture_info", GestureInfo, self.on_gesture)

        #  Servicio tablero
        rospy.wait_for_service("/get_board_state")
        self.get_board_srv = rospy.ServiceProxy("/get_board_state", BoardState)

        #  Servicio robot 
        rospy.wait_for_service("/move_piece")
        self.move_srv = rospy.ServiceProxy("/move_piece", MovePiece)

        rospy.loginfo("Game Master listo, esperando inicio del juego...")

    def on_gesture(self, msg):
        # --- LO QUE VIENE DE VISIÓN ---
        # msg.type = "INICIO", "FICHA_ROJO", "TIRAR_DADO", "CONFIRMAR_MOVIMIENTO"
        # msg.source = "mano" o "rostro"

        # Inicio de partida 
        # en streaming
        if not self.game_started and msg.type == "INICIO":
            self.game_started = True
            rospy.loginfo("¡Partida iniciada! Humanos pueden elegir ficha.")
            return

        # Ignorar gestos si el juego no ha empezado
        if not self.game_started:
            return

        # Solo humanos pueden seleccionar ficha
        if self.current_player_type() != "human":
            return

        #  Selección de ficha 
        if msg.source == "mano" and msg.type.startswith("FICHA_"):
            color = msg.type.split("_")[1].lower()
            if color not in self.available_colors:
                rospy.logwarn(f"Ficha {color} ya seleccionada, elige otra")
                return

            self.pieces_by_player[self.current_player] = color
            self.available_colors.remove(color)
            rospy.loginfo(f"{self.current_player} selecciona ficha {color}")

            # Si todos los humanos eligieron, asignar ficha robot
            if all(self.pieces_by_player[p] is not None for p in ["humano_1", "humano_2"]):
                robot_color = self.available_colors[0]
                self.pieces_by_player["robot"] = robot_color
                self.available_colors.remove(robot_color)
                rospy.loginfo(f"Robot selecciona ficha {robot_color}")
            return

        # Tirar dado 
        if msg.type == "TIRAR_DADO":
            rospy.loginfo(f"{self.current_player} pide tirar dado")

        # Confirmar movimiento 
        if msg.type == "CONFIRMAR_MOVIMIENTO" and self.ready_to_move:
            self.execute_move()
            self.next_turn()

    def on_dice(self, msg):
        #  LO QUE VIENE DE VISIÓN
        # msg.number -> número del dado
        if self.current_player_type() in ["robot", "human"]:
            self.last_roll = msg.number
            rospy.loginfo(f"[Dado {self.current_player}] Número detectado: {self.last_roll}")
            if self.current_player_type() == "human":
                self.ready_to_move = True

    def on_gaze(self, msg):
        #  LO QUE VIENE DE VISIÓN 
        # Para humanos: guiño confirma movimiento
        if self.current_player_type() != "human":
            return

        if msg.wink and self.ready_to_move:
            self.execute_move()
            self.next_turn()

    #  Estado del tablero 
    def check_board(self):
        try:
            resp = self.get_board_srv()
            # --- LO QUE DEBE ENVIAR VISIÓN --- cambiar a lo que de vision formato
            # Cada pieza: color, x (casilla), owner ("humano_1", "humano_2", "robot", "libre")
            return resp.pieces
        except Exception as e:
            rospy.logerr(f"Error pidiendo tablero: {e}")
            return []

    # Turnos
    def current_player_type(self):
        return self.player_type[self.current_player]

    def next_turn(self):
        self.current_index = (self.current_index + 1) % len(self.players)
        self.current_player = self.players[self.current_index]
        rospy.loginfo(f"Turno de {self.current_player}")

    #  Movimiento 
    def execute_move(self):
        if not self.current_piece or not self.last_roll:
            rospy.logwarn("No hay ficha ni dado para mover")
            return

        pieces = self.check_board()
        destino = self.calculate_destination(self.current_piece, self.last_roll, pieces)

        try:
            self.move_srv(self.current_piece, destino)
            rospy.loginfo(f"Movida ficha {self.current_piece} a casilla {destino}")
        except Exception as e:
            rospy.logerr(f"Error moviendo ficha: {e}")

        # Reset
        self.current_piece = None
        self.last_roll = None
        self.ready_to_move = False

    #  Turno robot 
    def robot_turn(self):
        rospy.loginfo("[Turno robot]")

        self.current_piece = self.choose_robot_piece()
        if not self.current_piece:
            rospy.logwarn("Robot no tiene fichas disponibles")
            self.next_turn()
            return

        rospy.loginfo(f"Robot va a mover ficha: {self.current_piece}")

        # Espera número del dado desde visión
        rospy.loginfo("Robot coge y lanza dado. Esperando visión...")
        self.last_roll = None
        while self.last_roll is None and not rospy.is_shutdown():
            rospy.sleep(0.1)

        rospy.loginfo(f"Dado detectado: {self.last_roll}")

        # Calcular destino y mover ficha
        pieces = self.check_board()
        destino = self.calculate_destination(self.current_piece, self.last_roll, pieces)
        try:
            self.move_srv(self.current_piece, destino)
            rospy.loginfo(f"Robot mueve ficha {self.current_piece} a casilla {destino}")
        except Exception as e:
            rospy.logerr(f"Error moviendo ficha robot: {e}")

        # Reset y siguiente turno
        self.current_piece = None
        self.last_roll = None
        self.ready_to_move = False
        self.next_turn()

    #  Auxiliares 
    def available_robot_pieces(self):
        pieces = self.check_board()
        return [p for p in pieces if p.owner == "robot" or p.owner == "libre"]

    def choose_robot_piece(self):
        robot_pieces = self.available_robot_pieces()
        if not robot_pieces:
            return None
        robot_pieces.sort(key=lambda p: p.x, reverse=True)
        return robot_pieces[0].color

    def calculate_destination(self, piece, roll, pieces):
        for p in pieces:
            if p.color == piece:
                return p.x + roll
        return roll

#  Bucle principal 
if __name__ == "__main__":
    rospy.init_node("game_master")
    gm = GameMaster()

    rate = rospy.Rate(0.2)
    while not rospy.is_shutdown():
        if gm.game_started and gm.current_player_type() == "robot":
            gm.robot_turn()
        rate.sleep()
