# scripts/test_camera.py
from src.core.video import Video
from src.ui.overlay import draw_text

def main():
    print("[TEST] Creando Video()...")
    cam = Video("src/config/settings.yaml")
    print("[TEST] Video creado, empezando bucle...")

    while True:
        ok, frame = cam.read()
        if not ok:
            print("[TEST] No se pudo leer frame, salgo.")
            break

        draw_text(frame, "Test cam (ESC para salir)", (20, 40))
        cam.show("cam", frame)

        if cam.key_pressed(1) == 27:  # ESC
            break

    cam.release()

if __name__ == "__main__":
    main()

