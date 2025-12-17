#!/usr/bin/env python3
import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import cv2
import numpy as np
import yaml

class ArucoDetector:
    def __init__(self):
        rospy.init_node('nodo_camara')
        self.bridge = CvBridge()
        self.cv_image = None

        rospy.Subscriber('/usb_cam/image_raw', Image, self.__cb_image)

        # ArUco
        self.aruco_dict = cv2.aruco.getPredefinedDictionary(cv2.aruco.DICT_6X6_250)
        self.aruco_params = cv2.aruco.DetectorParameters()

        # Load camera calibration
        yaml_file = "/home/laboratorio/ros_workspace/src/detector_tablero/config/camera_calibration.yaml"
        with open(yaml_file, "r") as f:
            cam_data = yaml.safe_load(f)

        K = cam_data['camera_matrix']['data']
        fx = K[0]
        fy = K[4]
        cx = K[2]
        cy = K[5]
        self.camera_matrix = np.array([
            [fx, 0, cx],
            [0, fy, cy],
            [0, 0, 1]
        ])

        k1, k2, p1, p2, k3 = cam_data['distortion_coefficients']['data']
        self.dist_coeffs = np.array([k1, k2, p1, p2, k3])

        rospy.loginfo("Aruco detector initialized.")

    def __cb_image(self, image: Image):
        # Convert ROS Image to OpenCV
        self.cv_image = self.bridge.imgmsg_to_cv2(image, desired_encoding='bgr8')

        # Detect markers
        self.detect_aruco()

    def detect_aruco(self):
        if self.cv_image is None:
            return

        # Optional: undistort
        undistorted = cv2.undistort(self.cv_image, self.camera_matrix, self.dist_coeffs)

        # Detect markers
        corners, ids, _ = cv2.aruco.detectMarkers(undistorted, self.aruco_dict, parameters=self.aruco_params)

        if ids is not None:
            # Draw markers
            cv2.aruco.drawDetectedMarkers(undistorted, corners, ids)

        # Show frame (optional for debugging)
        cv2.imshow("Aruco Detection", undistorted)
        cv2.waitKey(1)

if __name__ == "__main__":
    detector = ArucoDetector()
    rospy.spin()
