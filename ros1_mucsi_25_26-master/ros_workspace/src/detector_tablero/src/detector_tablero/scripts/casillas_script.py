#!/usr/bin/env python3
import rospy
import actionlib
from geometry_msgs.msg import Pose
from detector_tablero.msg import CasillasAction, CasillasResult, CasillasFeedback, Tablero
from nodo_camara import NodoCamara

class CasillasActionServer:
    def __init__(self):
        self.server = actionlib.SimpleActionServer(
            'check_boxes',
            CasillasAction,
            execute_cb=self.execute_cb,
            auto_start=False
        )
        self.server.start()
        self.nodo_camara = NodoCamara()

    def centro_a_pose(self, centro):
        pose = Pose()
        pose.position.x = float(centro[0])
        pose.position.y = float(centro[1])
        pose.position.z = 0.0
        pose.orientation.w = 1.0
        return pose

    def execute_cb(self, goal):
        feedback = CasillasFeedback()
        result = CasillasResult()

        frames_without_success = 0

        while not rospy.is_shutdown():
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

            rospy.sleep(0.1)

if __name__ == "__main__":
    rospy.init_node("check_boxes_server")
    server = CasillasActionServer()
    rospy.spin()
