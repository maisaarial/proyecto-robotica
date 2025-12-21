import cv2
import mediapipe as mp


class Face:
    """
    Usa MediaPipe SOLO para localizar el rostro.
    detect(frame_bgr) devuelve:
        - roi_bgr: recorte de la cara
        - bbox: (x1, y1, x2, y2)
      o (None, None) si no hay cara.
    """

    def __init__(self,
                 detection_confidence: float = 0.7,
                 tracking_confidence: float = 0.7):
        self.mp_face = mp.solutions.face_mesh
        self.face_mesh = self.mp_face.FaceMesh(
            max_num_faces=1,
            refine_landmarks=False,
            min_detection_confidence=detection_confidence,
            min_tracking_confidence=tracking_confidence
        )

    def detect(self, frame_bgr, draw_bbox: bool = False):
        h, w, _ = frame_bgr.shape
        image_rgb = cv2.cvtColor(frame_bgr, cv2.COLOR_BGR2RGB)
        results = self.face_mesh.process(image_rgb)

        if not results.multi_face_landmarks:
            return None, None

        face_landmarks = results.multi_face_landmarks[0]

        xs = [lm.x * w for lm in face_landmarks.landmark]
        ys = [lm.y * h for lm in face_landmarks.landmark]

        x1, x2 = int(max(min(xs) - 20, 0)), int(min(max(xs) + 20, w))
        y1, y2 = int(max(min(ys) - 20, 0)), int(min(max(ys) + 20, h))

        roi = frame_bgr[y1:y2, x1:x2].copy()

        if draw_bbox:
            cv2.rectangle(frame_bgr, (x1, y1), (x2, y2), (255, 0, 0), 2)

        return roi, (x1, y1, x2, y2)
