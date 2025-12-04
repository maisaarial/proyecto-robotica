#!/usr/bin/env python3
import rospy
import actionlib
from gestos_robot_pkg.msg import GestoAction, GestoGoal, GestoResult
from gestos_robot_pkg.msg import Gesture

class GestureActionClient:
    def __init__(self):
        rospy.init_node('gesture_client', anonymous=True)

        # --- LIST TO STORE DETECTED GESTURES ---
        self.detected_gestures = []
        self.on = False

        # --- ACTION CLIENT SETUP ---
        rospy.loginfo("[GESTURE-CLIENT] Waiting for server...")
        self.client = actionlib.SimpleActionClient('gesto_action', GestoAction)
        self.client.wait_for_server()
        rospy.loginfo("[GESTURE-CLIENT] Server connected.")

        rospy.Subscriber("/gestos/stream", Gesture, self.stream_callback)

    def stream_callback(self, msg):
        """Start or stop gesture detection loop."""
        gesture_type = msg.type

        if gesture_type == "Inicio (mano abierta)" and not self.on:
            rospy.loginfo("[GESTURE-CLIENT] >>> INICIO recibido. Comenzando escucha.")
            self.on = True

        elif gesture_type == "Detener (parpadeo largo)" and self.on:
            rospy.loginfo("[GESTURE-CLIENT] >>> DETENER recibido. Terminando escucha.")
            self.on = False

    def request_gesture(self):
        """Send a gesture request and append the result to the list."""
        goal = GestoGoal()

        rospy.loginfo(f"[GESTURE-CLIENT] Sending request")
        self.client.send_goal(goal)
        self.client.wait_for_result()

        result = self.client.get_result()

        if result and result.type:
            rospy.loginfo(f"[GESTURE-CLIENT] Detected: {result.type}")
            self.detected_gestures.append(result.type)
        else:
            rospy.logwarn("[GESTURE-CLIENT] Gesture not detected (timeout or abort)")
            self.detected_gestures.append("NONE")

        print("\n=== Gesture History ===")
        print(self.detected_gestures)
        print("=======================\n")

        return result
    
    def run(self):
        rate = rospy.Rate(0.1)   # 2 Hz = call server max every 0.5 seconds
        while not rospy.is_shutdown():
            if self.on:
                self.request_gesture()
                print(f"detected : {self.detected_gestures}")
            rate.sleep()


if __name__ == "__main__":
    client = GestureActionClient()
    # Example repeated calls
    client.run()
