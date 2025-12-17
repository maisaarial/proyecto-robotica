rosrun usb_cam usb_cam_node _video_device:=/dev/video0 _image_width:=640 _image_height:=480 _framerate:=30


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