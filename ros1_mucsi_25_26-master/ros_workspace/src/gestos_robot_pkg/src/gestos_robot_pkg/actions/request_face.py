#!/usr/bin/env python3
import rospy
import actionlib
from gestos_robot_pkg.msg import GestoAction, GestoGoal, GestoResult
from gestos_robot_pkg.msg import FaceGestureAction, FaceGestureResult, FaceGestureGoal
from gestos_robot_pkg.msg import Gesture
import time

class FaceActionClient:
    def __init__(self):
        #rospy.init_node('gesture_client', anonymous=True)

        # --- LIST TO STORE DETECTED GESTURES ---
        self.on = False

        # --- ACTION CLIENT SETUP ---
        rospy.loginfo("[FACE-CLIENT] Waiting for server...")
        self.client = actionlib.SimpleActionClient('face_action', FaceGestureAction)
        self.client.wait_for_server()
        rospy.loginfo("[FACE-CLIENT] Server connected.")

    def request_face(self):
        """Send a gesture request and append the result to the list."""
        time.sleep(2)
        face = None
        goal = FaceGestureGoal()
        self.client.send_goal(goal)
        self.client.wait_for_result()

        result = self.client.get_result()

        if result and result.type:
            face = result.type
        return face
    
    def run(self):
        rate = rospy.Rate(0.2)   # 2 Hz = call server max every 0.5 seconds
        while not rospy.is_shutdown():
            res = self.request_face()
            rate.sleep()
        return res


if __name__ == "__main__":
    client = FaceActionClient()
    # Example repeated calls
    client.run()
