; Auto-generated. Do not edit!


(cl:in-package detector_tablero-msg)


;//! \htmlinclude Tablero.msg.html

(cl:defclass <Tablero> (roslisp-msg-protocol:ros-message)
  ((colores
    :reader colores
    :initarg :colores
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (casillas
    :reader casillas
    :initarg :casillas
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose)))
)

(cl:defclass Tablero (<Tablero>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Tablero>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Tablero)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name detector_tablero-msg:<Tablero> is deprecated: use detector_tablero-msg:Tablero instead.")))

(cl:ensure-generic-function 'colores-val :lambda-list '(m))
(cl:defmethod colores-val ((m <Tablero>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader detector_tablero-msg:colores-val is deprecated.  Use detector_tablero-msg:colores instead.")
  (colores m))

(cl:ensure-generic-function 'casillas-val :lambda-list '(m))
(cl:defmethod casillas-val ((m <Tablero>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader detector_tablero-msg:casillas-val is deprecated.  Use detector_tablero-msg:casillas instead.")
  (casillas m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Tablero>) ostream)
  "Serializes a message object of type '<Tablero>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'colores))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'colores))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'casillas) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Tablero>) istream)
  "Deserializes a message object of type '<Tablero>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'colores) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'colores)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'casillas) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Tablero>)))
  "Returns string type for a message object of type '<Tablero>"
  "detector_tablero/Tablero")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Tablero)))
  "Returns string type for a message object of type 'Tablero"
  "detector_tablero/Tablero")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Tablero>)))
  "Returns md5sum for a message object of type '<Tablero>"
  "71151b07a522e59996993ee37495dfc2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Tablero)))
  "Returns md5sum for a message object of type 'Tablero"
  "71151b07a522e59996993ee37495dfc2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Tablero>)))
  "Returns full string definition for message of type '<Tablero>"
  (cl:format cl:nil "string[] colores~%geometry_msgs/Pose casillas~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Tablero)))
  "Returns full string definition for message of type 'Tablero"
  (cl:format cl:nil "string[] colores~%geometry_msgs/Pose casillas~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Tablero>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'colores) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'casillas))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Tablero>))
  "Converts a ROS message object to a list"
  (cl:list 'Tablero
    (cl:cons ':colores (colores msg))
    (cl:cons ':casillas (casillas msg))
))
