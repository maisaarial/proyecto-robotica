#!/usr/bin/env python3
import rospy
import actionlib
from detector_tablero.msg import Tablero
from detector_tablero.msg import CasillasAction, CasillasResult, CasillasGoal
from gestos_robot_pkg.msg import Gesture
import time

class TableroActionClient:
    def __init__(self):
        rospy.init_node('gesture_client', anonymous=True)

        # --- LIST TO STORE DETECTED GESTURES ---
        self.on = False

        # --- ACTION CLIENT SETUP ---
        rospy.loginfo("[GESTURE-CLIENT] Waiting for server...")
        self.client = actionlib.SimpleActionClient('casillas', CasillasAction)
        self.client.wait_for_server()
        rospy.loginfo("[GESTURE-CLIENT] Server connected.")

        #rospy.Subscriber("/gestos/stream", Gesture, self.stream_callback)
    """
    def stream_callback(self, msg):
        '''Start or stop gesture detection loop.'''
        gesture_type = msg.type

        if gesture_type == "Inicio (mano abierta)" and not self.on:
            rospy.loginfo("[GESTURE-CLIENT] >>> INICIO recibido. Comenzando escucha.")
            self.on = True

        elif gesture_type == "Detener (parpadeo largo)" and self.on:
            rospy.loginfo("[GESTURE-CLIENT] >>> DETENER recibido. Terminando escucha.")
            self.on = False
    """
    
    def request_tablero(self):
        """Send a gesture request and append the result to the list."""
        time.sleep(2)
        tablero = None
        goal = CasillasGoal()
        rospy.loginfo(f"[Casillas-CLIENT] Sending request")
        self.client.send_goal(goal)
        self.client.wait_for_result()

        result = self.client.get_result()

        if result and result.casillas:
            rospy.loginfo(f"[Casillas-CLIENT] Detected: {result.casillas}")
            tablero = result.casillas
        else:
            rospy.logwarn("[Casillas-CLIENT] Gesture not detected (timeout or abort)")
        return tablero
    
    def run(self):
        rate = rospy.Rate(0.2)   # 2 Hz = call server max every 0.5 seconds
        while not rospy.is_shutdown():
            res = self.request_tablero()
            rate.sleep()
        return res


if __name__ == "__main__":
    client = TableroActionClient()
    # Example repeated calls
    client.run()
