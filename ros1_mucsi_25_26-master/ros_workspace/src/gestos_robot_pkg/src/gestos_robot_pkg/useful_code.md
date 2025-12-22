# para encender la captación de la cámara de gestos (usb_cam) 
# ord .26 se encarga del robot, es el master
rosrun usb_cam usb_cam_node _video_device:=/dev/video0 _image_width:=640 _image_height:=480 _framerate:=30

# cámara de dado + tablero 
roslaunch gestos_robot_pkg system.launch

# en cada terminal a ejecutar y tambien en el master
export ROS_IP=10.172.21.26
echo $ROS_IP
export ROS_MASTER_URI=http://10.172.21.26:11311
echo $ROS_MASTER_URI
source devel/setup.bash

##
sudo apt-get install ros-noetic-camera-calibration

rosrun camera_calibration cameracalibrator.py --size 4x4 --square 0.032 image:=/usb_cam/image_raw camera:=/usb_cam
[size : nombre de carrés du ckerboard, square : longueur d'un coté en m]

Après bouger le checkerboard en droit gauche, haut bas, profondeur, rotation tilt....
Calibrate
choose to save and choose path of save in the config


###
Calibrate
Test move from Aruco
test get result casillas. from V2
install contenedores
test dé/ test server


Préparer les launchs des caméras avec noms streams différents