import cv2
import mediapipe as mp

class Hands:
    def __init__(self, max_num_hands=1, detection_confidence=0.5, tracking_confidence=0.5):
        self.mp_hands = mp.solutions.hands
        self.hands = self.mp_hands.Hands(
            max_num_hands=max_num_hands,
            model_complexity=1,
            min_detection_confidence=detection_confidence,
            min_tracking_confidence=tracking_confidence
        )
        self.mp_drawing = mp.solutions.drawing_utils

    def detect(self, frame, draw_bbox=False):
        h, w, _ = frame.shape
        rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        results = self.hands.process(rgb)

        if not results.multi_hand_landmarks:
            return None, None

        # Tomamos la primera mano detectada
        hand = results.multi_hand_landmarks[0]

        # Obtener coordenadas normalizadas y llevarlas a pixel
        xs = []
        ys = []

        for lm in hand.landmark:
            xs.append(int(lm.x * w))
            ys.append(int(lm.y * h))

        xmin = max(0, min(xs))
        xmax = min(w, max(xs))
        ymin = max(0, min(ys))
        ymax = min(h, max(ys))

        # ---- REFINAR ROI (padding) ----
        padding = 20
        x1 = max(0, xmin - padding)
        y1 = max(0, ymin - padding)
        x2 = min(w, xmax + padding)
        y2 = min(h, ymax + padding)

        roi = frame[y1:y2, x1:x2]

        if draw_bbox:
            cv2.rectangle(frame, (x1, y1), (x2, y2), (0,255,0), 2)

        return roi, (x1, y1, x2, y2)
