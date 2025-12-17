;; Auto-generated. Do not edit!


(when (boundp 'detector_tablero::Cell)
  (if (not (find-package "DETECTOR_TABLERO"))
    (make-package "DETECTOR_TABLERO"))
  (shadow 'Cell (find-package "DETECTOR_TABLERO")))
(unless (find-package "DETECTOR_TABLERO::CELL")
  (make-package "DETECTOR_TABLERO::CELL"))

(in-package "ROS")
;;//! \htmlinclude Cell.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass detector_tablero::Cell
  :super ros::object
  :slots (_idx _color _pose ))

(defmethod detector_tablero::Cell
  (:init
   (&key
    ((:idx __idx) "")
    ((:color __color) "")
    ((:pose __pose) (instance geometry_msgs::Pose :init))
    )
   (send-super :init)
   (setq _idx (string __idx))
   (setq _color (string __color))
   (setq _pose __pose)
   self)
  (:idx
   (&optional __idx)
   (if __idx (setq _idx __idx)) _idx)
  (:color
   (&optional __color)
   (if __color (setq _color __color)) _color)
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
    ;; string _idx
    4 (length _idx)
    ;; string _color
    4 (length _color)
    ;; geometry_msgs/Pose _pose
    (send _pose :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _idx
       (write-long (length _idx) s) (princ _idx s)
     ;; string _color
       (write-long (length _color) s) (princ _color s)
     ;; geometry_msgs/Pose _pose
       (send _pose :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _idx
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _idx (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _color
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _color (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; geometry_msgs/Pose _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;;
   self)
  )

(setf (get detector_tablero::Cell :md5sum-) "6ff0b5688a4dc590464614af933c2f7d")
(setf (get detector_tablero::Cell :datatype-) "detector_tablero/Cell")
(setf (get detector_tablero::Cell :definition-)
      "string idx
string color
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



(provide :detector_tablero/Cell "6ff0b5688a4dc590464614af933c2f7d")


