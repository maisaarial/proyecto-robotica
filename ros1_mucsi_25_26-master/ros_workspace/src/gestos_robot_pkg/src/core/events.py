from enum import Enum, auto

class GestureEvent(Enum):
    NONE = auto()

    INICIO = auto()
    FICHA_ROJA = auto()
    FICHA_AMARILLA = auto()
    FICHA_VERDE = auto()
    FICHA_AZUL = auto()

    TIRAR_DADO = auto()
    CONTINUAR = auto()
    DETENER = auto()
