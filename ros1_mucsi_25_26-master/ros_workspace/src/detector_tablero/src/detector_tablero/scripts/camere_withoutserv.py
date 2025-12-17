#!/usr/bin/env python3
import rospy
from cv_bridge import CvBridge
from sensor_msgs.msg import Image
import cv2
import numpy as np
import yaml

Diametro_CM = 50.0   # lado real en centímetros
nCasillas = 20

# Almacenar información de las fichas
fichas = {
    "rojo": (None, None),   
    "verde": (None, None),
    "azul": (None, None)
}

class NodoCamara:
    def __init__(self):
        rospy.init_node('nodo_camara', anonymous=True)
        self.bridge = CvBridge()
        self.cv_image = None
        rospy.Subscriber('/usb_cam/image_raw', Image, self.__cb_image)
        
        # ArUco
        self.aruco_dict = cv2.aruco.getPredefinedDictionary(cv2.aruco.DICT_6X6_250)
        self.aruco_params = cv2.aruco.DetectorParameters()

        # Camera calibration
        yaml_file = "/home/laboratorio/ros_workspace/src/detector_tablero/config/camera_calibration.yaml"
        with open(yaml_file, "r") as f:
            cam_data = yaml.safe_load(f)

        K = cam_data['camera_matrix']['data']
        fx, fy, cx, cy = K[0], K[4], K[2], K[5]
        self.camera_matrix = np.array([[fx, 0, cx],[0, fy, cy],[0, 0, 1]])
        k1, k2, p1, p2, k3 = cam_data['distortion_coefficients']['data']
        self.dist_coeffs = np.array([k1, k2, p1, p2, k3])

    def __cb_image(self, image: Image):
        self.cv_image = self.bridge.imgmsg_to_cv2(image, desired_encoding='bgr8')

    # -------------------------
    # ArUco detection
    # -------------------------
    def detectarAruco(self, frame):
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        corners, ids, _ = cv2.aruco.detectMarkers(gray, self.aruco_dict, parameters=self.aruco_params)
        if ids is None:
            return None, None
        if ids is not None:
            cv2.aruco.drawDetectedMarkers(frame, corners, ids)
        marker_size = 5.0  # cm
        rvecs, tvecs, _ = cv2.aruco.estimatePoseSingleMarkers(corners, marker_size, self.camera_matrix, self.dist_coeffs)
        return rvecs[0], tvecs[0]

    def piezaPixelToAruco(self, cx, cy, rvec, tvec):
        uv1 = np.array([[cx, cy, 1]], dtype=np.float32).T
        ray_cam = np.linalg.inv(self.camera_matrix) @ uv1
        R, _ = cv2.Rodrigues(rvec)
        ray_marker = R.T @ ray_cam
        cam_marker = -R.T @ tvec.reshape(3,1)
        scale = -cam_marker[2] / ray_marker[2]
        P = cam_marker + scale * ray_marker
        return float(P[0]), float(P[1]), 0.0

    # -------------------------
    # Board squares detection
    # -------------------------
    def detectarCasillas(self, frame):
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        blur = cv2.GaussianBlur(gray, (5,5), 0)
        edges = cv2.Canny(blur, 40, 160)
        kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (3,3))
        edges = cv2.morphologyEx(edges, cv2.MORPH_CLOSE, kernel, iterations=1)
        #cv2.imshow("Edges", edges)
        contours, _ = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        casillas = []
        area_min = 1100
        for c in contours:
            if cv2.contourArea(c) < area_min:
                continue
            peri = cv2.arcLength(c, True)
            approx = cv2.approxPolyDP(c, 0.02*peri, True)
            if len(approx) == 4:
                pts = approx.reshape(4,2).tolist()

                # Ordenar puntos (arriba izq -> arriba der -> abajo der -> abajo izq)
                pts = sorted(pts, key=lambda p: (p[1], p[0]))
                top = sorted(pts[:2], key=lambda p: p[0])
                bottom = sorted(pts[2:], key=lambda p: p[0])
                ordered = [top[0], top[1], bottom[1], bottom[0]]

                casillas.append(ordered)
            
            elif len(approx) == 3:
                pts = approx.reshape(3,2).tolist()

                # Ordenar puntos (arriba izq -> arriba der -> abajo izq -> abajo der)
                pts = sorted(pts, key=lambda p: (p[1], p[0]))
                top = pts[0]
                bottom = sorted(pts[1:], key=lambda p: p[0])
                ordered = [top, bottom[0], bottom[1]]

                casillas.append(ordered)
        if len(casillas) == nCasillas:
            return casillas
        return casillas

    def getCentro(self, casilla):
        cx = int(sum([p[0] for p in casilla]) / len(casilla))
        cy = int(sum([p[1] for p in casilla]) / len(casilla))
        return (cx, cy)

    def casillaPunto(self, punto, casillas):
        for idx, casilla in enumerate(casillas):
            pts = np.array(casilla, np.int32)
            if cv2.pointPolygonTest(pts, punto, False) >= 0:
                return idx
        return None

    # -------------------------
    # Color detection
    # -------------------------
    def detectarFichas(self, frame):
        hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
        kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (5,5))

        # Rojo
        maskR1 = cv2.inRange(hsv, (0,100,100),(10,255,255))
        maskR2 = cv2.inRange(hsv, (170,100,100),(180,255,255))
        maskR = cv2.bitwise_or(maskR1, maskR2)
        maskR = cv2.morphologyEx(maskR, cv2.MORPH_OPEN, kernel)
        contours, _ = cv2.findContours(maskR, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        if contours:
            c = max(contours, key=cv2.contourArea)
            M = cv2.moments(c)
            if M["m00"] != 0:
                fichas["rojo"] = ((int(M["m10"]/M["m00"]), int(M["m01"]/M["m00"])), c)

        # Verde
        maskG = cv2.inRange(hsv, (35,80,80),(85,255,255))
        maskG = cv2.morphologyEx(maskG, cv2.MORPH_OPEN, kernel)
        contours, _ = cv2.findContours(maskG, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        if contours:
            c = max(contours, key=cv2.contourArea)
            M = cv2.moments(c)
            if M["m00"] != 0:
                fichas["verde"] = ((int(M["m10"]/M["m00"]), int(M["m01"]/M["m00"])), c)

        # Azul
        maskB = cv2.inRange(hsv, (100,150,70),(130,255,255))
        maskB = cv2.morphologyEx(maskB, cv2.MORPH_OPEN, kernel)
        contours, _ = cv2.findContours(maskB, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        if contours:
            c = max(contours, key=cv2.contourArea)
            M = cv2.moments(c)
            if M["m00"] != 0:
                fichas["azul"] = ((int(M["m10"]/M["m00"]), int(M["m01"]/M["m00"])), c)

    # -------------------------
    # Main loop
    # -------------------------
    def run(self):
        cv2.namedWindow("Deteccion tablero y fichas")
        rate = rospy.Rate(10)
        while not rospy.is_shutdown():
            if self.cv_image is None:
                rate.sleep()
                continue
            frame = self.cv_image.copy()

            # Detect ArUco
            rvec, tvec = self.detectarAruco(frame)

            # Detect board
            casillas = self.detectarCasillas(frame)
            casillas.sort(key=lambda c: (self.getCentro(c)[0]))
            for idx, c in enumerate(casillas):
                pts = np.array(c, np.int32)
                cv2.polylines(frame, [pts], True, (0,255,0), 2)
                cx, cy = self.getCentro(c)
                cv2.putText(frame, str(idx), (cx, cy), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0,255,0), 2)
            '''if casillas and rvec is not None and tvec is not None:
                cx, cy = self.getCentro(casillas[1])
                x, y, z = self.piezaPixelToAruco(cx, cy, rvec, tvec)
                print(f"Cell 1 pixel coords: ({cx}, {cy})")
                print(f"Cell 1 ArUco coordinates: x={x:.2f} cm, y={y:.2f} cm, z={z:.2f} cm")
                cv2.circle(frame, (cx, cy), 5, (0, 255, 255), -1)
                cv2.putText(frame, f"({x:.1f},{y:.1f})", (cx+5, cy-5), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,255,255), 1)'''


            # Detect pieces
            self.detectarFichas(frame)
            colors = {"rojo":(0,0,255), "verde":(0,255,0), "azul":(255,0,0)}
            for color, (centro, _) in fichas.items():
                if centro:
                    cv2.circle(frame, centro, 10, colors[color], -1)
                    if casillas:
                        idx = self.casillaPunto(centro, casillas)
                        cv2.putText(frame, color[0], centro, cv2.FONT_HERSHEY_SIMPLEX, 0.5, colors[color], 2)

            cv2.imshow("Deteccion tablero y fichas", frame)
            if cv2.waitKey(1) & 0xFF == ord('q'):
                break
            rate.sleep()
        cv2.destroyAllWindows()


if __name__ == "__main__":
    nodo = NodoCamara()
    nodo.run()
