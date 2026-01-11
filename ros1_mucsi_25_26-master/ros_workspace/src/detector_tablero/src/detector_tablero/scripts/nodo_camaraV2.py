#!/usr/bin/env python3
import rospy
import actionlib
import yaml
from cv_bridge import CvBridge
from sensor_msgs.msg import Image
from geometry_msgs.msg import Pose
from copy import deepcopy
from detector_tablero.msg import Tablero, Cell
from detector_tablero.msg import CasillasAction, CasillasResult, CasillasFeedback

import cv2
import numpy as np

clicked = False
Diametro_CM = 3.0   # lado real en centímetros

# Coordenadas reales de cada cubo
XB = YB = ZB = 0
XG = YG = ZG = 0
XR = YR = ZR = 0

# Focal y escala
focal_px = None
escala_cm_px = None

# Casillas del tablero
nCasillas = 20

# Almacenar información de las fichas
fichas = {
    "rojo": (None, None),   # (centro (x,y), contorno)
    "verde": (None, None),
    "azul": (None, None)
}

class NodoCamara:
    def __init__(self):
        rospy.init_node('nodo_camara')
        self.bridge = CvBridge()
        rospy.Subscriber('/usb_cam/image_raw', Image, self.__cb_image)
        
        self.server = actionlib.SimpleActionServer(
            'casillas',
            CasillasAction,
            execute_cb=self.execute_cb,
            auto_start=False
        )
        self.server.start()

        self.aruco_dict = cv2.aruco.getPredefinedDictionary(cv2.aruco.DICT_6X6_250)
        self.aruco_params = cv2.aruco.DetectorParameters()
        #From Calibration
        yaml_file = "/home/laboratorio/ros_workspace/src/detector_tablero/config/camera_calibration.yaml"

        with open(yaml_file, "r") as f:
            cam_data = yaml.safe_load(f)

        # Extract camera matrix K
        K = cam_data['camera_matrix']['data']
        K = cam_data['camera_matrix']['data']
        fx = K[0]   # K[0,0]
        fy = K[4]   # K[1,1]
        cx = K[2]   # K[0,2]
        cy = K[5]   # K[1,2]
        self.camera_matrix = np.array([
            [fx, 0, cx],
            [0, fy, cy],
            [0,  0,  1]
        ])

        # Extract distortion coefficients D
        k1, k2, p1, p2, k3 = cam_data['distortion_coefficients']['data']      
        self.dist_coeffs = np.array([k1, k2, p1, p2, k3])
        
        self.casillas = None

        
        
    def __cb_image(self, image: Image):
        self.cv_image = self.bridge.imgmsg_to_cv2(image,
                                        desired_encoding='passthrough')
    
    # -------------------------------------------
    # EVENTOS Y FUNCIONES BÁSICAS
    # -------------------------------------------
    def onKey(self):
        global clicked, result
        tecla = cv2.waitKey(1) & 0xFF
        if tecla == ord('s'):
            cv2.imwrite("Captura.jpg", result)
        elif tecla == ord('x'):
            clicked = True


    def getCentroides(self, mask):
        contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        for c in contours:
            if cv2.contourArea(c) > 200:
                M = cv2.moments(c)
                if M["m00"] != 0:
                    cx = int(M["m10"] / M["m00"])
                    cy = int(M["m01"] / M["m00"])
                    return (cx, cy), c
        return None, None


    def casillaPunto(self, punto, casillas):
        for idx, casilla in enumerate(casillas):
            pts = np.array(casilla, np.int32)
            if cv2.pointPolygonTest(pts, punto, False) >= 0:
                return idx
        return None


    # -----------------------------------------------------
    # DETECCIÓN DE CASILLAS VARIABLES Y COLOR (TABLERO PDF)
    # -----------------------------------------------------
    def detectarCasillas(self, frame):
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        blur = cv2.GaussianBlur(gray, (5,5), 0)
        edges = cv2.Canny(blur, 40, 160)

        kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (5,5))
        edges = cv2.morphologyEx(edges, cv2.MORPH_CLOSE, kernel, iterations=2)

        contours, _ = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        casillas = []
        area_min = 1500  # AJUSTABLE según tamaño visto en cámara
        for c in contours:
            area = cv2.contourArea(c)
            if area < area_min:
                continue

            peri = cv2.arcLength(c, True)
            approx = cv2.approxPolyDP(c, 0.02 * peri, True)

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

    def getCentro(self, casilla):
        cx = int(sum([p[0] for p in casilla]) / len(casilla))
        cy = int(sum([p[1] for p in casilla]) / len(casilla))
        return (cx, cy)

    def detectarCasillasColor(self, casillas, frame):
        hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
        resultados = []

        for casilla in casillas:
            # Crear máscara de la casilla
            mask = np.zeros(frame.shape[:2], dtype=np.uint8)
            pts = np.array(casilla, np.int32)
            cv2.fillPoly(mask, [pts], 255)

            # Calcular color medio en HSV
            h, s, v = cv2.mean(hsv, mask=mask)[:3]

            # Clasificación de color
            if 10 <= h <= 25 and s > 120 and v > 120:
                color = "naranja"

            elif 25 < h <= 35 and s > 120 and v > 140:
                color = "amarillo"

            elif 155 <= h <= 170 and 69 <= s <= 151 and 134 <= v <= 233:
                color = "rosa"

            elif 120 <= h <= 140 and 95 <= s <= 200 and 120 <= v <= 195:
                color = "morado"

            else:
                color = "blanco"

            resultados.append((self.getCentro(casilla), color))

        print(resultados)
        return resultados

    def ordenarCasillas(self, casillas):
        # Ordenar casillas por posición (de arriba a abajo, de izquierda a derecha)
        def centroide(casilla):
            cx = sum([p[0] for p in casilla]) / len(casilla)
            cy = sum([p[1] for p in casilla]) / len(casilla)
            return (cx, cy)

        casillas.sort(key=lambda c: (centroide(c)[1], centroide(c)[0]))
        return casillas

    # -------------------------------------------
    # DISTANCIAS Y COORDENADAS REALES
    # -------------------------------------------
    def detectarAruco(self, frame):
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

        corners, ids, _ = cv2.aruco.detectMarkers(
            gray, self.aruco_dict, parameters=self.aruco_params
        )

        if ids is None:
            return None, None

        # Marker side length in cm
        marker_size = 5.0  

        rvecs, tvecs, _ = cv2.aruco.estimatePoseSingleMarkers(
            corners,
            marker_size,
            self.camera_matrix,
            self.dist_coeffs
        )

        return rvecs[0], tvecs[0]

    def pixelToMarker(self, px, py, rvec, tvec):
        # Ray from camera through pixel
        uv1 = np.array([[px, py, 1]], dtype=np.float32).T
        cam_inv = np.linalg.inv(self.camera_matrix)
        ray = cam_inv @ uv1

        # Rotation matrix
        R, _ = cv2.Rodrigues(rvec)

        # Transform ray into marker frame
        ray_marker = R.T @ ray
        cam_marker = -R.T @ tvec.reshape(3,1)

        # Intersect with marker plane (Z=0)
        s = -cam_marker[2] / ray_marker[2]
        point = cam_marker + s * ray_marker

        return point[0][0], point[1][0], 0.0

    def piezaPixelToAruco(self, cx, cy, rvec, tvec):
        """
        Convert piece centroid (pixel) to coordinates
        in the ArUco marker reference frame (cm)
        """

        # Pixel to normalized camera ray
        uv1 = np.array([[cx, cy, 1]], dtype=np.float32).T
        cam_inv = np.linalg.inv(self.camera_matrix)
        ray_cam = cam_inv @ uv1

        # Rotation marker->camera
        R, _ = cv2.Rodrigues(rvec)

        # Transform to marker frame
        ray_marker = R.T @ ray_cam
        cam_marker = -R.T @ tvec.reshape(3,1)

        # Assume pieces lie on board plane (Z=0)
        scale = -cam_marker[2] / ray_marker[2]
        P = cam_marker + scale * ray_marker

        return float(P[0]), float(P[1]), 0.0


    # -------------------------------------------
    # CÁMARA Y LOOP PRINCIPAL
    # -------------------------------------------
    def execute_cb(self, goal):
        cv2.namedWindow("Deteccion tablero y fichas")
        frame = self.cv_image
        height, width = frame.shape[:2]
        centro_img = (width//2, height//2)
        
        result = None
        feedback = CasillasFeedback()
        result = CasillasResult()

        frames_without_success = 0
        frame = deepcopy(self.cv_image)
        display = frame.copy()

        ycrcb = cv2.cvtColor(frame, cv2.COLOR_BGR2YCrCb)

        # Aruco info
        rvec, tvec = self.detectarAruco(frame)
        if rvec is None:
            rospy.logwarn("ArUco no detectado")
            return


        # ------------------------------ TABLERO --------------------------------
        for i in range(10):
            frame = self.cv_image
            if frame is None:
                rospy.sleep(0.1)
                continue

            casillas = self.detectarCasillas(frame)
            feedback.detected_count = len(casillas) if casillas else 0
            self.server.publish_feedback(feedback)

            if casillas and len(casillas) == rospy.get_param("/detection/required_boxes", 20):
                tablero_list = []
                colores = self.detectarCasillasColor(casillas, frame)
                for centro, color in colores:
                    c = Cell()
                    p = Pose()
                    p.position.x, p.position.y, p.position.z = self.pixelToMarker(
                        centro[0], centro[1], rvec, tvec)
                    p.orientation.x, p.orientation.y, p.orientation.z, p.orientation.w = 0, 0, 0, 1
                    c.pose = p
                    c.label = color
                    tablero_list.append(c)

                result.casillas = tablero_list
                self.server.set_succeeded(result)
                return
            else:
                frames_without_success += 1

            if frames_without_success >= rospy.get_param("/detection/max_retry_frames", 10):
                rospy.logwarn("No se pudieron detectar las casillas en el tiempo límite")
                self.server.set_aborted(text="No se pudo enviar correctamente")
                return
        
        for i, casilla in enumerate(casillas):
            pts = np.array(casilla, np.int32)
            cv2.polylines(display, [pts], True, (0,255,0), 2)

            cx = int(sum([p[0] for p in casilla]) / 4)
            cy = int(sum([p[1] for p in casilla]) / 4)
            cv2.putText(display, str(i), (cx, cy),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0,255,0), 2)
        
        casillas = self.ordenarCasillas(casillas)
        color = self.detectarCasillasColor(casillas, frame)
        print(color)

        # ------------------------ CUBOS ROJO/VERDE/AZUL ------------------------
        # Convertimos a HSV
        hsv = cv2.cvtColor(display, cv2.COLOR_BGR2HSV)

        # Kernel para limpiar ruido
        kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (5,5))


        # ==========================================================
        # ----------------------- ROJO -----------------------------
        # ==========================================================

        maskR1 = cv2.inRange(hsv, (0, 100, 100), (10, 255, 255))
        maskR2 = cv2.inRange(hsv, (170, 100, 100), (180, 255, 255))
        maskR = cv2.bitwise_or(maskR1, maskR2)
        maskR = cv2.morphologyEx(maskR, cv2.MORPH_OPEN, kernel)

        contornosR, _ = cv2.findContours(maskR, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        if len(contornosR) > 0:
            cR = max(contornosR, key=cv2.contourArea)
            areaR = cv2.contourArea(cR)

            if areaR >= 150:
                M = cv2.moments(cR)
                if M["m00"] != 0:
                    cxR = int(M["m10"] / M["m00"])
                    cyR = int(M["m01"] / M["m00"])
                    fichas["rojo"] = ((cxR, cyR), cR)


        # ==========================================================
        # ----------------------- VERDE ----------------------------
        # ==========================================================

        maskG = cv2.inRange(hsv, (35, 80, 80), (85, 255, 255))
        maskG = cv2.morphologyEx(maskG, cv2.MORPH_OPEN, kernel)

        contornosG, _ = cv2.findContours(maskG, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        if len(contornosG) > 0:
            cG = max(contornosG, key=cv2.contourArea)
            areaG = cv2.contourArea(cG)

            if areaG >= 150:
                M = cv2.moments(cG)
                if M["m00"] != 0:
                    cxG = int(M["m10"] / M["m00"])
                    cyG = int(M["m01"] / M["m00"])
                    fichas["verde"] = ((cxG, cyG), cG)


        # ==========================================================
        # ----------------------- AZUL -----------------------------
        # ==========================================================

        maskB = cv2.inRange(hsv, (90, 80, 80), (140, 255, 255))
        maskB = cv2.morphologyEx(maskB, cv2.MORPH_OPEN, kernel)

        contornosB, _ = cv2.findContours(maskB, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        if len(contornosB) > 0:
            cB = max(contornosB, key=cv2.contourArea)
            areaB = cv2.contourArea(cB)

            if areaB >= 150:
                M = cv2.moments(cB)
                if M["m00"] != 0:
                    cxB = int(M["m10"] / M["m00"])
                    cyB = int(M["m01"] / M["m00"])
                    fichas["azul"] = ((cxB, cyB), cB)


        # ==========================================================
        # --------------------- DIBUJAR FICHAS ---------------------
        # ==========================================================

        if fichas["rojo"][0] is not None:
            cv2.circle(display, fichas["rojo"][0], 10, (0, 0, 255), -1)

        if fichas["verde"][0] is not None:
            cv2.circle(display, fichas["verde"][0], 10, (0, 255, 0), -1)

        if fichas["azul"][0] is not None:
            cv2.circle(display, fichas["azul"][0], 10, (255, 0, 0), -1)

        # ------------------------ CASILLA DE CADA FICHA ------------------------

        centro_R, cont_R = fichas["rojo"]
        centro_G, cont_G = fichas["verde"]
        centro_B, cont_B = fichas["azul"]

        if centro_R:
            idx = self.casillaPunto(centro_R, casillas)
            print("Rojo en casilla:", idx)

        if centro_G:
            idx = self.casillaPunto(centro_G, casillas)
            print("Verde en casilla:", idx)

        if centro_B:
            idx = self.casillaPunto(centro_B, casillas)
            print("Azul en casilla:", idx)


        # --------------------- ESCALA REAL Y COORDENADAS -----------------------

        # ----------- ROJO -----------
        if centro_R:
            XR, YR, ZR = self.piezaPixelToAruco(centro_R[0],centro_R[1],rvec,tvec)

        # ----------- VERDE ----------
        if centro_G:
            XG, YG, ZG = self.piezaPixelToAruco(centro_G[0],centro_G[1],rvec,tvec)

        # ----------- AZUL -----------
        if centro_B:
            XB, YB, ZB = self.piezaPixelToAruco(centro_B[0],centro_B[1],rvec,tvec)

        rospy.sleep(1)
        cv2.imshow("Deteccion tablero y fichas", display)
        cv2.waitKey(1)

    
if __name__== "__main__":
    nodo = NodoCamara()
    rospy.spin()