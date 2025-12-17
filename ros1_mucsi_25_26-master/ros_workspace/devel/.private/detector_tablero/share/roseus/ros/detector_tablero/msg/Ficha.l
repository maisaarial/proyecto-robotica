;; Auto-generated. Do not edit!


(when (boundp 'detector_tablero::Ficha)
  (if (not (find-package "DETECTOR_TABLERO"))
    (make-package "DETECTOR_TABLERO"))
  (shadow 'Ficha (find-package "DETECTOR_TABLERO")))
(unless (find-package "DETECTOR_TABLERO::FICHA")
  (make-package "DETECTOR_TABLERO::FICHA"))

(in-package "ROS")
;;//! \htmlinclude Ficha.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass detector_tablero::Ficha
  :super ros::object
  :slots (_color _idx _pose ))

(defmethod detector_tablero::Ficha
  (:init
   (&key
    ((:color __color) "")
    ((:idx __idx) 0)
    ((:pose __pose) (instance geometry_msgs::Pose :init))
    )
   (send-super :init)
   (setq _color (string __color))
   (setq _idx (round __idx))
   (setq _pose __pose)
   self)
  (:color
   (&optional __color)
   (if __color (setq _color __color)) _color)
  (:idx
   (&optional __idx)
   (if __idx (setq _idx __idx)) _idx)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:serialization-length
   ()
   (+
    ;; string _color
    4 (length _color)
    ;; int32 _idx
    4
    ;; geometry_msgs/Pose _pose
    (send _pose :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _color
       (write-long (length _color) s) (princ _color s)
     ;; int32 _idx
       (write-long _idx s)
     ;; geometry_msgs/Pose _pose
       (send _pose :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _color
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _color (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _idx
     (setq _idx (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/Pose _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;;
   self)
  )

(setf (get detector_tablero::Ficha :md5sum-) "13349da357d8ddbc33f9cc5515913440")
(setf (get detector_tablero::Ficha :datatype-) "detector_tablero/Ficha")
(setf (get detector_tablero::Ficha :definition-)
      "string color
int32 idx
geometry_msgs/Pose pose
================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

")



(provide :detector_tablero/Ficha "13349da357d8ddbc33f9cc5515913440")


