import rospy
import actionlib
import cv2
import numpy as np

from cv_bridge import CvBridge
from sensor_msgs.msg import Image
from geometry_msgs.msg import Pose

from detector_tablero.msg import (
    CheckBoxesAction,
    CheckBoxesResult,
    CheckBoxesFeedback,
    Tablero,
    Ficha
)


class NodoCamaraActionServer:

    # =====================================================
    # INIT
    # =====================================================
    def __init__(self):
        rospy.init_node("nodo_camara_action_server")

        self.bridge = CvBridge()
        self.last_image = None
        self.DIAMETRO_CM = 3.0
        self.escala_cm_px = None
        self.centro_img = None
        self.required_boxes = rospy.get_param("~required_boxes", 20)
        self.max_retry_frames = rospy.get_param("~max_retry_frames", 15)

        rospy.Subscriber(
            "/usb_cam/image_raw",
            Image,
            self.cb_image,
            queue_size=1
        )

        self.server = actionlib.SimpleActionServer(
            "check_boxes",
            CheckBoxesAction,
            execute_cb=self.execute_cb,
            auto_start=True
        )

        rospy.loginfo("Action Server con detección de fichas listo")

    # =====================================================
    # ROS CALLBACK
    # =====================================================
    def cb_image(self, msg):
        self.last_image = self.bridge.imgmsg_to_cv2(msg, "bgr8")

    # =====================================================
    # ACTION CALLBACK
    # =====================================================
    def execute_cb(self, goal):

        feedback = CheckBoxesFeedback()
        result = CheckBoxesResult()

        retries = 0
        rate = rospy.Rate(10)

        while not rospy.is_shutdown():

            if self.server.is_preempt_requested():
                self.server.set_preempted()
                return

            if self.last_image is None:
                rate.sleep()
                continue

            frame = self.last_image.copy()

            # ================= TABLERO =================
            casillas = self.detectarCasillas(frame)
            feedback.detected_boxes = len(casillas)

            if len(casillas) == self.required_boxes:
                casillas = self.ordenarCasillas(casillas)
                colores = self.detectarCasillasColor(casillas, frame)

                tablero_msgs = []
                for centro, color in colores:
                    t = Tablero()
                    t.pose = self.centro_a_pose(centro)
                    t.label = color
                    tablero_msgs.append(t)

                result.casillas = tablero_msgs

                # ================= FICHAS =================
                fichas = self.detectarFichas(frame, casillas)
                feedback.detected_fichas = len(fichas)

                result.fichas = fichas

                self.server.publish_feedback(feedback)
                self.server.set_succeeded(result)
                return

            retries += 1
            self.server.publish_feedback(feedback)

            if retries >= self.max_retry_frames:
                self.server.set_aborted(text="No se detectó el tablero completo")
                return

            rate.sleep()

    # =====================================================
    # TABLERO
    # =====================================================
    def detectarCasillas(self, frame):
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        edges = cv2.Canny(cv2.GaussianBlur(gray, (5, 5), 0), 40, 160)

        kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (5, 5))
        edges = cv2.morphologyEx(edges, cv2.MORPH_CLOSE, kernel, 2)

        contours, _ = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        casillas = []
        for c in contours:
            if cv2.contourArea(c) < 1500:
                continue

            peri = cv2.arcLength(c, True)
            approx = cv2.approxPolyDP(c, 0.02 * peri, True)

            if len(approx) in (3, 4):
                casillas.append(self.ordenarPuntos(approx.reshape(-1, 2).tolist()))

        return casillas

    def ordenarPuntos(self, pts):
        pts = sorted(pts, key=lambda p: (p[1], p[0]))
        if len(pts) == 4:
            top = sorted(pts[:2], key=lambda p: p[0])
            bottom = sorted(pts[2:], key=lambda p: p[0])
            return [top[0], top[1], bottom[1], bottom[0]]
        return pts

    def ordenarCasillas(self, casillas):
        return sorted(
            casillas,
            key=lambda c: (
                sum(p[1] for p in c) / len(c),
                sum(p[0] for p in c) / len(c)
            )
        )

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

            elif 120 <= h <= 140 and 95 <= s <= 200  and 120 <= v <= 195:
                color = "morado"

            else:
                color = "blanco"

            resultados.append((self.getCentro(casilla), color))

        return resultados

    # =====================================================
    # FICHAS
    # =====================================================
    def detectarFichas(self, frame, casillas):

        hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
        kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (5, 5))

        fichas_def = {
            "rojo": [(0, 100, 100), (10, 255, 255), (170, 100, 100), (180, 255, 255)],
            "verde": [(35, 80, 80), (85, 255, 255)],
            "azul": [(90, 80, 80), (140, 255, 255)]
        }

        fichas_msg = []

        for color, rangos in fichas_def.items():

            if color == "rojo":
                mask = cv2.inRange(hsv, rangos[0], rangos[1]) | \
                       cv2.inRange(hsv, rangos[2], rangos[3])
            else:
                mask = cv2.inRange(hsv, rangos[0], rangos[1])

            mask = cv2.morphologyEx(mask, cv2.MORPH_OPEN, kernel)

            contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
            if not contours:
                continue

            c = max(contours, key=cv2.contourArea)
            if cv2.contourArea(c) < 150:
                continue

            # -------- CALIBRACIÓN --------
            if self.escala_cm_px is None:
                lado_px = self.tamanoPx(c)
                self.escala_cm_px = self.DIAMETRO_CM / lado_px
                rospy.loginfo(f"Escala calibrada: {self.escala_cm_px:.4f} cm/px")

            M = cv2.moments(c)
            if M["m00"] == 0:
                continue

            cx = int(M["m10"] / M["m00"])
            cy = int(M["m01"] / M["m00"])

            X, Y = self.coordenadasReales(cx, cy)
            casilla_id = self.casillaPunto((cx, cy), casillas)

            f = Ficha()
            f.pose = self.pose_real(X, Y)
            f.color = color
            f.casilla_id = casilla_id if casilla_id is not None else -1

            fichas_msg.append(f)

        return fichas_msg

    # =====================================================
    # UTILIDADES FÍSICAS
    # =====================================================
    def tamanoPx(self, contorno):
        x, y, w, h = cv2.boundingRect(contorno)
        return (w + h) / 2.0

    def coordenadasReales(self, cx, cy):
        X = (cx - self.centro_img[0]) * self.escala_cm_px
        Y = (cy - self.centro_img[1]) * self.escala_cm_px
        return X, Y

    def pose_real(self, X, Y):
        p = Pose()
        p.position.x = X
        p.position.y = Y
        p.position.z = 0.0
        p.orientation.w = 1.0
        return p

    def getCentro(self, casilla):
        return (
            int(sum(p[0] for p in casilla) / len(casilla)),
            int(sum(p[1] for p in casilla) / len(casilla))
        )

    def casillaPunto(self, punto, casillas):
        for i, c in enumerate(casillas):
            if cv2.pointPolygonTest(np.array(c, np.int32), punto, False) >= 0:
                return i
        return None

    def casilla_msg(self, centro, color):
        X, Y = self.coordenadasReales(*centro)
        t = Tablero()
        t.pose = self.pose_real(X, Y)
        t.label = color
        return t


# =====================================================
# MAIN
# =====================================================
if __name__ == "__main__":
    NodoCamaraActionServer()
    rospy.spin()