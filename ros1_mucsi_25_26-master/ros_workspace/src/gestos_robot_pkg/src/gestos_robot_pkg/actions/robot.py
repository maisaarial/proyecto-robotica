import time


class Robot:
    """
    Interfaz con el robot.
    Por ahora está en modo 'stub': solo imprime en consola.
    Luego puedes cambiar a serial, MQTT, etc.
    """

    def __init__(self, mode="stub", port=None, baudrate=115200):
        self.mode = mode
        self.port = port
        self.baudrate = baudrate

        if self.mode == "stub":
            print("[Robot] Modo STUB: no se envían comandos reales.")
        else:
            # Aquí podrías inicializar conexión serial/MQTT/etc.
            print(f"[Robot] Inicializando en modo {self.mode}...")
            # Ejemplo:
            # import serial
            # self.ser = serial.Serial(self.port, self.baudrate)

    def move_piece(self, color: str):
        """
        color: 'roja', 'amarilla', 'verde', 'azul'
        """
        if self.mode == "stub":
            print(f"[Robot] Mover pieza {color}")
        else:
            # Ejemplo: enviar comando
            # cmd = f"MOVE_{color.upper()}\n"
            # self.ser.write(cmd.encode())
            print(f"[Robot] (REAL) Mover pieza {color}")

    def roll_dice(self):
        if self.mode == "stub":
            print("[Robot] Tirar dado 🎲")
        else:
            # cmd = "ROLL_DICE\n"
            # self.ser.write(cmd.encode())
            print("[Robot] (REAL) Tirar dado 🎲")

    def stop(self):
        if self.mode == "stub":
            print("[Robot] ⛔ Detener juego / emergencia")
        else:
            # cmd = "STOP\n"
            # self.ser.write(cmd.encode())
            print("[Robot] (REAL) ⛔ Detener")
