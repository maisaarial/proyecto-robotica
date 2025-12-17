#!/usr/bin/env python3
import rospy
import actionlib
from detector_tablero.msg import Tablero
from detector_tablero.msg import CasillasAction, CasillasResult, CasillasGoal
from gestos_robot_pkg.msg import Gesture
import time

class TableroActionClient:
    def __init__(self):
        #rospy.init_node('tablero_client', anonymous=True)

        # --- ACTION CLIENT SETUP ---
        rospy.loginfo("[Casillas-CLIENT] Waiting for server...")
        self.client = actionlib.SimpleActionClient('tablero', CasillasAction)
        self.client.wait_for_server()
        rospy.loginfo("[Casillas-CLIENT] Server connected.")
    
    def request_tablero(self, modo=1):
        """Send a request for pieces by default, for cells with modo = 0, return a list of Ficha.msg or a list of Cell.msg"""
        time.sleep(2)
        tablero = None
        goal = CasillasGoal()
        goal.modo = modo
        rospy.loginfo(f"[Casillas-CLIENT] Sending request")
        self.client.send_goal(goal)
        self.client.wait_for_result()

        result = self.client.get_result()
        if modo == 0 :
            if result and result.casillas:
                rospy.loginfo(f"[Casillas-CLIENT] Detected: {result.casillas}")
                tablero = result.casillas
            else:
                rospy.logwarn("[Casillas-CLIENT] Cells not detected (timeout or abort)")
            return tablero
        elif modo == 1 :
            if result and result.fichas:
                rospy.loginfo(f"[Casillas-CLIENT] Detected: {result.fichas}")
                tablero = result.fichas
            else:
                rospy.logwarn("[Casillas-CLIENT] Pieces not detected (timeout or abort)")
            return tablero
            
    
    def run(self):
        rate = rospy.Rate(0.2)   # 2 Hz = call server max every 0.5 seconds
        res = self.request_tablero(modo = 0)
        while not rospy.is_shutdown():
            res = self.request_tablero()
            rate.sleep()
        return res


if __name__ == "__main__":
    client = TableroActionClient()
    # Example repeated calls
    client.run()
