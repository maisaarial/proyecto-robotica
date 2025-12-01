# scripts/check_cameras.py
import cv2

def main():
    print("Probando índices de cámara 0..5")
    for i in range(6):
        cap = cv2.VideoCapture(i)
        if not cap.isOpened():
            print(f"[{i}] No hay cámara en este índice")
            continue

        ok, frame = cap.read()
        if not ok:
            print(f"[{i}] Error leyendo frame")
            cap.release()
            continue

        cv2.imshow(f"Camara {i}", frame)
        print(f"[{i}] Cámara encontrada en índice {i}")
        key = cv2.waitKey(0)
        cv2.destroyAllWindows()
        cap.release()

if __name__ == "__main__":
    main()
