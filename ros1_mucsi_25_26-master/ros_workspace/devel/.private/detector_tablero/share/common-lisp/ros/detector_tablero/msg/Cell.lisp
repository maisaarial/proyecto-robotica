; Auto-generated. Do not edit!


(cl:in-package detector_tablero-msg)


;//! \htmlinclude Cell.msg.html

(cl:defclass <Cell> (roslisp-msg-protocol:ros-message)
  ((idx
    :reader idx
    :initarg :idx
    :type cl:string
    :initform "")
   (color
    :reader color
    :initarg :color
    :type cl:string
    :initform "")
   (pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose)))
)

(cl:defclass Cell (<Cell>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Cell>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Cell)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name detector_tablero-msg:<Cell> is deprecated: use detector_tablero-msg:Cell instead.")))

(cl:ensure-generic-function 'idx-val :lambda-list '(m))
(cl:defmethod idx-val ((m <Cell>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader detector_tablero-msg:idx-val is deprecated.  Use detector_tablero-msg:idx instead.")
  (idx m))

(cl:ensure-generic-function 'color-val :lambda-list '(m))
(cl:defmethod color-val ((m <Cell>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader detector_tablero-msg:color-val is deprecated.  Use detector_tablero-msg:color instead.")
  (color m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <Cell>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader detector_tablero-msg:pose-val is deprecated.  Use detector_tablero-msg:pose instead.")
  (pose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Cell>) ostream)
  "Serializes a message object of type '<Cell>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'idx))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'idx))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'color))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'color))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Cell>) istream)
  "Deserializes a message object of type '<Cell>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'idx) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'idx) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'color) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'color) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Cell>)))
  "Returns string type for a message object of type '<Cell>"
  "detector_tablero/Cell")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Cell)))
  "Returns string type for a message object of type 'Cell"
  "detector_tablero/Cell")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Cell>)))
  "Returns md5sum for a message object of type '<Cell>"
  "6ff0b5688a4dc590464614af933c2f7d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Cell)))
  "Returns md5sum for a message object of type 'Cell"
  "6ff0b5688a4dc590464614af933c2f7d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Cell>)))
  "Returns full string definition for message of type '<Cell>"
  (cl:format cl:nil "string idx~%string color~%geometry_msgs/Pose pose~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Cell)))
  "Returns full string definition for message of type 'Cell"
  (cl:format cl:nil "string idx~%string color~%geometry_msgs/Pose pose~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Cell>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'idx))
     4 (cl:length (cl:slot-value msg 'color))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Cell>))
  "Converts a ROS message object to a list"
  (cl:list 'Cell
    (cl:cons ':idx (idx msg))
    (cl:cons ':color (color msg))
    (cl:cons ':pose (pose msg))
))
