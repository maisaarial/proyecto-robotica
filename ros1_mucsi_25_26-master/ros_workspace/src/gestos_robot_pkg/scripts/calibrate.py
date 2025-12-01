# Mide EAR medio con ojos abiertos y cerrados; guarda en JSON
from src.detectors.face_detector import Face
from src.core.video import Video
from src.core.utils import save_calibration

face = Face()
cam = Video()
samples_open, samples_closed = [], []

print("Mira a cámara y mantén ojos abiertos (3s)…")
# recolecta EAR
# luego pide cerrar ojos (2s)
# calcula umbrales personalizados y guarda en data/calibrations/user_default.json
save_calibration({...})
