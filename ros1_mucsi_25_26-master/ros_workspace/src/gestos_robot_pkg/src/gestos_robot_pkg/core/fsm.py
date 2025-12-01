from enum import Enum, auto
from gestos_robot_pkg.core.events import GestureEvent

class State(Enum):
    INACTIVO = auto()
    ESPERA_INICIO = auto()
    SELECCION_FICHA = auto()
    CONFIRMAR_MOVIMIENTO = auto()
    EJECUTAR_ACCION = auto()
    ESPERA_TIRAR_DADO = auto()
    DETENIDO = auto()

class FSM:
    def __init__(self):
        self.state = State.ESPERA_INICIO
        self.selected_piece = None

    def next(self, event: GestureEvent):
        # ------------------------
        # Estado: esperando inicio
        # ------------------------
        if self.state == State.ESPERA_INICIO:
            if event == GestureEvent.INICIO:
                self.state = State.SELECCION_FICHA
                return "Juego iniciado"

        # ------------------------
        # Selección de ficha
        # ------------------------
        if self.state == State.SELECCION_FICHA:
            if event in (
                GestureEvent.FICHA_ROJA,
                GestureEvent.FICHA_AMARILLA,
                GestureEvent.FICHA_VERDE,
                GestureEvent.FICHA_AZUL
            ):
                self.selected_piece = event
                self.state = State.CONFIRMAR_MOVIMIENTO
                return f"Ficha seleccionada: {event.name}"

            if event == GestureEvent.DETENER:
                self.state = State.DETENIDO
                return "Detenido"

        # ------------------------
        # Confirmación
        # ------------------------
        if self.state == State.CONFIRMAR_MOVIMIENTO:
            if event == GestureEvent.CONTINUAR:
                self.state = State.EJECUTAR_ACCION
                return "Confirmado"
            if event == GestureEvent.DETENER:
                self.state = State.DETENIDO
                return "Detenido"

        # ------------------------
        # Ejecutar acción
        # ------------------------
        if self.state == State.EJECUTAR_ACCION:
            self.state = State.ESPERA_TIRAR_DADO
            return "Ejecutar movimiento"

        # ------------------------
        # Espera tirar dado
        # ------------------------
        if self.state == State.ESPERA_TIRAR_DADO:
            if event == GestureEvent.TIRAR_DADO:
                self.state = State.SELECCION_FICHA
                return "Dado tirado"
            if event == GestureEvent.DETENER:
                self.state = State.DETENIDO
                return "Detenido"

        return None
