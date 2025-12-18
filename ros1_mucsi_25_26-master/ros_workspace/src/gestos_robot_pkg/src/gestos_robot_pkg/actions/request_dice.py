#!/usr/bin/env python3
import rospy
import actionlib
from gestos_robot_pkg.msg import DiceReadAction, DiceReadGoal, DiceReadResult
import time

class DiceActionClient:
    def __init__(self):
        #rospy.init_node("dice_reader")
        # --- LIST TO STORE DETECTED GESTURES ---
        self.on = False

        # --- ACTION CLIENT SETUP ---
        rospy.loginfo("[DICE-CLIENT] Waiting for server...")
        self.client = actionlib.SimpleActionClient('read_dice', DiceReadAction)
        self.client.wait_for_server()
        rospy.loginfo("[DICE-CLIENT] Server connected.")

        #rospy.Subscriber("/gestos/stream", Gesture, self.stream_callback)

    def request_dice(self):
        """Send a dice request and return the displayed value"""
        time.sleep(2)
        obtained_result = None
        goal = DiceReadGoal()
        rospy.loginfo(f"[DICE-CLIENT] Sending request")
        self.client.send_goal(goal)
        self.client.wait_for_result()

        result = self.client.get_result()

        if result and result.value:
            rospy.loginfo(f"[DICE-CLIENT] Detected: {result.value}")
            obtained_result = result.value
        else:
            rospy.logwarn("[DICE-CLIENT] dice not detected (timeout or abort)")
        return obtained_result
    
    def run(self):
        rate = rospy.Rate(0.2)   # 2 Hz = call server max every 0.5 seconds
        while not rospy.is_shutdown():
            res = self.request_dice()
            rate.sleep()
        return res


if __name__ == "__main__":
    client = DiceActionClient()
    # Example repeated calls
    client.run()
