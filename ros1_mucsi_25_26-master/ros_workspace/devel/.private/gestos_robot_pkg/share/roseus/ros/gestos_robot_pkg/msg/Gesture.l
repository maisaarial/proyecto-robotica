;; Auto-generated. Do not edit!


(when (boundp 'gestos_robot_pkg::Gesture)
  (if (not (find-package "GESTOS_ROBOT_PKG"))
    (make-package "GESTOS_ROBOT_PKG"))
  (shadow 'Gesture (find-package "GESTOS_ROBOT_PKG")))
(unless (find-package "GESTOS_ROBOT_PKG::GESTURE")
  (make-package "GESTOS_ROBOT_PKG::GESTURE"))

(in-package "ROS")
;;//! \htmlinclude Gesture.msg.html


(defclass gestos_robot_pkg::Gesture
  :super ros::object
  :slots (_type _source _fingers _long_blink ))

(defmethod gestos_robot_pkg::Gesture
  (:init
   (&key
    ((:type __type) "")
    ((:source __source) "")
    ((:fingers __fingers) 0)
    ((:long_blink __long_blink) nil)
    )
   (send-super :init)
   (setq _type (string __type))
   (setq _source (string __source))
   (setq _fingers (round __fingers))
   (setq _long_blink __long_blink)
   self)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:source
   (&optional __source)
   (if __source (setq _source __source)) _source)
  (:fingers
   (&optional __fingers)
   (if __fingers (setq _fingers __fingers)) _fingers)
  (:long_blink
   (&optional (__long_blink :null))
   (if (not (eq __long_blink :null)) (setq _long_blink __long_blink)) _long_blink)
  (:serialization-length
   ()
   (+
    ;; string _type
    4 (length _type)
    ;; string _source
    4 (length _source)
    ;; int32 _fingers
    4
    ;; bool _long_blink
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _type
       (write-long (length _type) s) (princ _type s)
     ;; string _source
       (write-long (length _source) s) (princ _source s)
     ;; int32 _fingers
       (write-long _fingers s)
     ;; bool _long_blink
       (if _long_blink (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _type
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _type (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _source
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _source (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _fingers
     (setq _fingers (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _long_blink
     (setq _long_blink (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get gestos_robot_pkg::Gesture :md5sum-) "12e6b3f163de8d922be0c5c5e43c1a72")
(setf (get gestos_robot_pkg::Gesture :datatype-) "gestos_robot_pkg/Gesture")
(setf (get gestos_robot_pkg::Gesture :definition-)
      "string type       # Nombre del gesto detectado, ej: \"FICHA_ROJA\", \"GUIÑO\"
string source     # \"mano\" o \"rostro\"
int32 fingers     # Número de dedos detectados (-1 si no aplica)
bool long_blink   # Parpadeo largo

")



(provide :gestos_robot_pkg/Gesture "12e6b3f163de8d922be0c5c5e43c1a72")


