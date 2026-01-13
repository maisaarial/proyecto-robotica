#!/usr/bin/env python3
import rospy
import actionlib
from gestos_robot_pkg.msg import GestoAction, GestoGoal, GestoResult
from gestos_robot_pkg.msg import Gesture
import time

class GestureActionClient:
    def __init__(self):
        #rospy.init_node('gesture_client', anonymous=True)

        # --- LIST TO STORE DETECTED GESTURES ---
        self.on = False

        # --- ACTION CLIENT SETUP ---
        rospy.loginfo("[GESTURE-CLIENT] Esperando al servidor...")
        self.client = actionlib.SimpleActionClient('gesto_action', GestoAction)
        self.client.wait_for_server()
        rospy.loginfo("[GESTURE-CLIENT] Servidor conectado.")

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
    def check_coherencia(self, gestures):
        valid = False
        if len(gestures)>=3:
            if gestures[-1]==gestures[-2] and gestures[-2]==gestures[-3]:
                valid = True
        return valid

    def request_gesture(self):
        """Send a gesture request and append the result to the list."""
        time.sleep(2)
        gestures = []
        gesture = None
        valid = False
        while not valid :
            goal = GestoGoal()
            self.client.send_goal(goal)
            self.client.wait_for_result()
            result = self.client.get_result()
            if result and result.type:
                gesture = result.type
                gestures.append(gesture)
            valid = self.check_coherencia(gestures)
            time.sleep(0.2)
        return gestures[-1]
    
    def run(self):
        rate = rospy.Rate(0.2)   # 2 Hz = call server max every 0.5 seconds
        while not rospy.is_shutdown():
            res = self.request_gesture()
            rate.sleep()
        return res


if __name__ == "__main__":
    client = GestureActionClient()
    # Example repeated calls
    client.run()
