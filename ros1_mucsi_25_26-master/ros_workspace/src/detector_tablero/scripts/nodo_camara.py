import rospy
import actionlib
from cv_bridge import CvBridge
from sensor_msgs.msg import Image
from copy import deepcopy
from detector_tablero.msg import Tablero
from detector_tablero.msg import CheckBoxesAction, CheckBoxesResult, CheckBoxesFeedback, Tablero
from nodo_camara import NodoCamara

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
        self.server = actionlib.SimpleActionServer(
            'check_boxes',
            CheckBoxesAction,
            execute_cb=self.execute_cb,
            auto_start=False
        )
        self.server.start()
        self.nodo_camara = NodoCamara()
    
    def __init__(self) -> None:
        rospy.init_node('nodo_camara')
        self.bridge = CvBridge()
        rospy.Subscriber('/usb_cam/image_raw', Image, self.__cb_image)
        
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
        if len(casillas) != nCasillas:
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

            elif 140 <= h <= 170 and s > 150 and v > 150:
                color = "rosa"

            elif 110 <= h <= 150 and s > 100 and v > 80:
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

    def tamanoPx(self, contorno):
        x, y, w, h = cv2.boundingRect(contorno)
        return (w + h) / 2


    def calcularFocal(self, dist_real_cm, lado_real_cm, lado_px):
        return (lado_px * dist_real_cm) / lado_real_cm


    def coordenadasReales(self, cx, cy, cx0, cy0):
        X = (cx - cx0) * escala_cm_px
        Y = (cy - cy0) * escala_cm_px
        Z = 0
        return X, Y, Z


    # -------------------------------------------
    # CÁMARA Y LOOP PRINCIPAL
    # -------------------------------------------

    cameraCapture = cv2.VideoCapture(1)
    cv2.namedWindow("Deteccion tablero y fichas")

    success, frame = cameraCapture.read()
    height, width = frame.shape[:2]
    centro_img = (width//2, height//2)
    result = None
    
    def run(self):
        feedback = CheckBoxesFeedback()
        result = CheckBoxesResult()

        frames_without_success = 0
        frame = deepcopy(self.cv_image)
            
        frame_copy = frame.copy()
        ycrcb = cv2.cvtColor(frame, cv2.COLOR_BGR2YCrCb)

        # ------------------------------ TABLERO --------------------------------
        for i in range(10):
            frame = getattr(self.nodo_camara, "cv_image", None)
            if frame is None:
                rospy.sleep(0.1)
                continue

            casillas = self.nodo_camara.detectarCasillas(frame)
            feedback.detected_count = len(casillas) if casillas else 0
            self.server.publish_feedback(feedback)

            if casillas and len(casillas) == rospy.get_param("/detection/required_boxes", 20):
                tablero_list = []
                colores = self.nodo_camara.detectarCasillasColor(casillas, frame)
                for centro, color in colores:
                    t = Tablero()
                    t.pose = self.centro_a_pose(centro)
                    t.label = color
                    tablero_list.append(t)

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
            cv2.polylines(result, [pts], True, (0,255,0), 2)

            cx = int(sum([p[0] for p in casilla]) / 4)
            cy = int(sum([p[1] for p in casilla]) / 4)
            cv2.putText(result, str(i), (cx, cy),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0,255,0), 2)
        
        casillas = self.ordenarCasillas(casillas)
        color = self.detectarCasillasColor(casillas, frame)
        print(color)

        # ------------------------ CUBOS ROJO/VERDE/AZUL ------------------------
        # Convertimos a HSV
        hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

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
            cv2.circle(result, fichas["rojo"][0], 10, (0, 0, 255), -1)

        if fichas["verde"][0] is not None:
            cv2.circle(result, fichas["verde"][0], 10, (0, 255, 0), -1)

        if fichas["azul"][0] is not None:
            cv2.circle(result, fichas["azul"][0], 10, (255, 0, 0), -1)

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

        # Solo calibramos una vez usando la ficha roja (la que primero aparezca)
        if focal_px is None and cont_R is not None:
            lado_px = self.tamanoPx(cont_R)
            if lado_px != 0:
                focal_px = self.calcularFocal(40, Diametro_CM, lado_px)
                escala_cm_px = Diametro_CM / lado_px


        if escala_cm_px is not None:

            # ----------- ROJO -----------
            if centro_R:
                XR, YR, ZR = self.coordenadasReales(*centro_R, self.centro_img[0], self.centro_img[1])
                cv2.putText(result, f"({XR:.1f},{YR:.1f})",
                            (centro_R[0]+10, centro_R[1]),
                            cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0,0,255), 2)

            # ----------- VERDE ----------
            if centro_G:
                XG, YG, ZG = self.coordenadasReales(*centro_G, self.centro_img[0], self.centro_img[1])
                cv2.putText(result, f"({XG:.1f},{YG:.1f})",
                            (centro_G[0]+10, centro_G[1]),
                            cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0,255,0), 2)

            # ----------- AZUL -----------
            if centro_B:
                XB, YB, ZB = self.coordenadasReales(*centro_B, self.centro_img[0], self.centro_img[1])
                cv2.putText(result, f"({XB:.1f},{YB:.1f})",
                            (centro_B[0]+10, centro_B[1]),
                            cv2.FONT_HERSHEY_SIMPLEX, 0.6, (255,0,0), 2)

            rospy.sleep(1)
    
if __name__== "__main__":
    nodo = NodoCamara()
    nodo.run()