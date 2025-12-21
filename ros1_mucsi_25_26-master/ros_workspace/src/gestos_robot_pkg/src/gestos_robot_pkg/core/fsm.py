from enum import Enum, auto
from src.core.events import GestureEvent

class State(Enum):
    INACTIVO = auto()
    ESPERA_INICIO = auto()
    SELECCION_FICHA = auto()
    ESPERA_TIRAR_DADO = auto()
    CONFIRMAR_MOVIMIENTO_GUINO = auto()
    EJECUTAR_ACCION = auto()
    DETENIDO = auto()

class FSM:
    def __init__(self):
        self.state = State.ESPERA_INICIO
        self.selected_piece = None
        self.dice_value = None

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
                self.state = State.ESPERA_TIRAR_DADO
                return f"Ficha seleccionada: {event.name}, esperando tirar dado"

            if event == GestureEvent.DETENER:
                self.state = State.DETENIDO
                return "Detenido"

        # ------------------------
        # Espera tirar dado
        # ------------------------
        if self.state == State.ESPERA_TIRAR_DADO:
            if event == GestureEvent.TIRAR_DADO:
                self.state = State.CONFIRMAR_MOVIMIENTO_GUINO
                return "Dado tirado, esperar confirmación (guiño)"
            if event == GestureEvent.DETENER:
                self.state = State.DETENIDO
                return "Detenido"

        # ------------------------
        # Confirmación de movimiento
        # ------------------------
        if self.state == State.CONFIRMAR_MOVIMIENTO_GUINO:
            if event == GestureEvent.CONTINUAR:
                self.state = State.EJECUTAR_ACCION
                return "Confirmado, ejecutar movimiento"
            if event == GestureEvent.DETENER:
                self.state = State.DETENIDO
                return "Detenido"

        # ------------------------
        # Ejecutar acción
        # ------------------------
        if self.state == State.EJECUTAR_ACCION:
            # Una vez ejecutada la acción, volvemos a seleccionar ficha
            self.state = State.SELECCION_FICHA
            self.selected_piece = None
            self.dice_value = None
            return "Movimiento ejecutado, volver a seleccionar ficha"

        return None

