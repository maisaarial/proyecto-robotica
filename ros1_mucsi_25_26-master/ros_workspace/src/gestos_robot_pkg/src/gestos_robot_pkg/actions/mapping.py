from gestos_robot_pkg.core.events import GestureEvent
from gestos_robot_pkg.core.fsm import State, FSM
from gestos_robot_pkg.actions.robot import Robot


class ActionMapper:
    """
    Recibe:
      - la FSM (para saber estado y ficha seleccionada)
      - el Robot
    Expone:
      - handle(event) → ejecuta lo que toque según el estado y el gesto
    """

    def __init__(self, fsm: FSM, robot: Robot):
        self.fsm = fsm
        self.robot = robot

    def handle(self, event: GestureEvent):
        """
        Procesa el evento:
          1) se lo pasa a la FSM
          2) según el resultado/estado, manda acciones al robot
        """
        msg = self.fsm.next(event)

        if msg is None:
            return  # nada que hacer

        print(f"[FSM] {msg} | Estado: {self.fsm.state.name}")

        # Dependiendo del mensaje/estado, disparamos acciones
        if msg == "Ejecutar movimiento":
            self._execute_move()

        elif msg == "Dado tirado":
            self._execute_roll_dice()

        elif msg == "Detenido":
            self.robot.stop()

    # ----------------------------
    # Acciones internas
    # ----------------------------
    def _execute_move(self):
        piece_event = self.fsm.selected_piece
        if piece_event is None:
            return

        color = None
        if piece_event == GestureEvent.FICHA_ROJA:
            color = "roja"
        elif piece_event == GestureEvent.FICHA_AMARILLA:
            color = "amarilla"
        elif piece_event == GestureEvent.FICHA_VERDE:
            color = "verde"
        elif piece_event == GestureEvent.FICHA_AZUL:
            color = "azul"

        if color:
            self.robot.move_piece(color)

    def _execute_roll_dice(self):
        self.robot.roll_dice()
