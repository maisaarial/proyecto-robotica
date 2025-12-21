import cv2
import numpy as np

class DiceDetector:

    def __init__(self):
        # parámetros ajustables
        self.blur = 7
        self.min_area = 80
        self.max_area = 800

    def detect(self, frame):
        """
        Devuelve (numero_dado, frame_annotated)
        numero_dado = 1..6 o None
        """

        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

        # Suavizado fuerte para eliminar ruido y reflejos
        gray = cv2.GaussianBlur(gray, (self.blur, self.blur), 0)

        # Umbral adaptativo para separar puntos del fondo
        thresh = cv2.adaptiveThreshold(
            gray, 255,
            cv2.ADAPTIVE_THRESH_GAUSSIAN_C,
            cv2.THRESH_BINARY_INV, # puntos NEGROS pasan a blancos 
            21, 5
        )

        # Detectar contornos
        contours, _ = cv2.findContours(thresh, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        puntos = 0

        for cnt in contours:
            area = cv2.contourArea(cnt)

            # filtrar ruido
            if area < self.min_area or area > self.max_area:
                continue

            x, y, w, h = cv2.boundingRect(cnt)

            # aceptamos formas casi circulares
            ratio = w / float(h)
            if 0.6 < ratio < 1.4:
                puntos += 1
                cv2.rectangle(frame, (x, y), (x+w, y+h), (0,255,0), 2)

        # si el número es coherente con un dado (1..6)
        if 1 <= puntos <= 6:
            return puntos, frame

        return None, frame
