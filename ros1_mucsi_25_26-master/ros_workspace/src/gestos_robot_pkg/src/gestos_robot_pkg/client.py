#!/usr/bin/env python
import rospy
from gestos_robot_pkg.msg import Gesture


class GestureActionClient:
    def __init__(self):
        rospy.Subscriber("/gestos/stream", Gesture, self.stream_callback)

    def stream_callback(self, msg):
        """Start or stop gesture detection loop."""
        gesture_type = msg.type

        if gesture_type == "Inicio (5 dedos)":
            rospy.loginfo("[GESTURE-CLIENT] >>> INICIO recibido. Comenzando escucha.")

        elif gesture_type == "Detener (parpadeo largo)":
            rospy.loginfo("[GESTURE-CLIENT] >>> DETENER recibido. Terminando escucha.")


if __name__ == "__main__":
    rospy.init_node("gesture_action_client")
    client = GestureActionClient()
    rospy.spin() 