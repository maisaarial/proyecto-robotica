;; Auto-generated. Do not edit!


(when (boundp 'detector_tablero::Tablero)
  (if (not (find-package "DETECTOR_TABLERO"))
    (make-package "DETECTOR_TABLERO"))
  (shadow 'Tablero (find-package "DETECTOR_TABLERO")))
(unless (find-package "DETECTOR_TABLERO::TABLERO")
  (make-package "DETECTOR_TABLERO::TABLERO"))

(in-package "ROS")
;;//! \htmlinclude Tablero.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass detector_tablero::Tablero
  :super ros::object
  :slots (_colores _casillas ))

(defmethod detector_tablero::Tablero
  (:init
   (&key
    ((:colores __colores) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:casillas __casillas) (instance geometry_msgs::Pose :init))
    )
   (send-super :init)
   (setq _colores __colores)
   (setq _casillas __casillas)
   self)
  (:colores
   (&optional __colores)
   (if __colores (setq _colores __colores)) _colores)
  (:casillas
   (&rest __casillas)
   (if (keywordp (car __casillas))
       (send* _casillas __casillas)
     (progn
       (if __casillas (setq _casillas (car __casillas)))
       _casillas)))
  (:serialization-length
   ()
   (+
    ;; string[] _colores
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _colores)) 4
    ;; geometry_msgs/Pose _casillas
    (send _casillas :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string[] _colores
     (write-long (length _colores) s)
     (dolist (elem _colores)
       (write-long (length elem) s) (princ elem s)
       )
     ;; geometry_msgs/Pose _casillas
       (send _casillas :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string[] _colores
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _colores (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _colores i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; geometry_msgs/Pose _casillas
     (send _casillas :deserialize buf ptr-) (incf ptr- (send _casillas :serialization-length))
   ;;
   self)
  )

(setf (get detector_tablero::Tablero :md5sum-) "71151b07a522e59996993ee37495dfc2")
(setf (get detector_tablero::Tablero :datatype-) "detector_tablero/Tablero")
(setf (get detector_tablero::Tablero :definition-)
      "string[] colores
geometry_msgs/Pose casillas
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



(provide :detector_tablero/Tablero "71151b07a522e59996993ee37495dfc2")


