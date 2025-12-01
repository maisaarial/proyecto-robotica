; Auto-generated. Do not edit!


(cl:in-package gestos_robot_pkg-msg)


;//! \htmlinclude GestoResult.msg.html

(cl:defclass <GestoResult> (roslisp-msg-protocol:ros-message)
  ((type
    :reader type
    :initarg :type
    :type cl:string
    :initform "")
   (source
    :reader source
    :initarg :source
    :type cl:string
    :initform "")
   (fingers
    :reader fingers
    :initarg :fingers
    :type cl:integer
    :initform 0)
   (rock
    :reader rock
    :initarg :rock
    :type cl:boolean
    :initform cl:nil)
   (wink
    :reader wink
    :initarg :wink
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass GestoResult (<GestoResult>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GestoResult>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GestoResult)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name gestos_robot_pkg-msg:<GestoResult> is deprecated: use gestos_robot_pkg-msg:GestoResult instead.")))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <GestoResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gestos_robot_pkg-msg:type-val is deprecated.  Use gestos_robot_pkg-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'source-val :lambda-list '(m))
(cl:defmethod source-val ((m <GestoResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gestos_robot_pkg-msg:source-val is deprecated.  Use gestos_robot_pkg-msg:source instead.")
  (source m))

(cl:ensure-generic-function 'fingers-val :lambda-list '(m))
(cl:defmethod fingers-val ((m <GestoResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gestos_robot_pkg-msg:fingers-val is deprecated.  Use gestos_robot_pkg-msg:fingers instead.")
  (fingers m))

(cl:ensure-generic-function 'rock-val :lambda-list '(m))
(cl:defmethod rock-val ((m <GestoResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gestos_robot_pkg-msg:rock-val is deprecated.  Use gestos_robot_pkg-msg:rock instead.")
  (rock m))

(cl:ensure-generic-function 'wink-val :lambda-list '(m))
(cl:defmethod wink-val ((m <GestoResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gestos_robot_pkg-msg:wink-val is deprecated.  Use gestos_robot_pkg-msg:wink instead.")
  (wink m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GestoResult>) ostream)
  "Serializes a message object of type '<GestoResult>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'type))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'type))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'source))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'source))
  (cl:let* ((signed (cl:slot-value msg 'fingers)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'rock) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'wink) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GestoResult>) istream)
  "Deserializes a message object of type '<GestoResult>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'type) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'source) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'source) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'fingers) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'rock) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'wink) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GestoResult>)))
  "Returns string type for a message object of type '<GestoResult>"
  "gestos_robot_pkg/GestoResult")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GestoResult)))
  "Returns string type for a message object of type 'GestoResult"
  "gestos_robot_pkg/GestoResult")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GestoResult>)))
  "Returns md5sum for a message object of type '<GestoResult>"
  "6fccb3d0fa481c3a1e9649a7effb88e9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GestoResult)))
  "Returns md5sum for a message object of type 'GestoResult"
  "6fccb3d0fa481c3a1e9649a7effb88e9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GestoResult>)))
  "Returns full string definition for message of type '<GestoResult>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%~%# Result~%string type       # Nombre del gesto detectado, ej: \"FICHA_ROJA\", \"GUIÑO\"~%string source     # \"mano\" o \"rostro\"~%int32 fingers     # Número de dedos detectados (-1 si no aplica)~%bool rock         # Gesto rock (🤘)~%bool wink         # Guiño~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GestoResult)))
  "Returns full string definition for message of type 'GestoResult"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%~%# Result~%string type       # Nombre del gesto detectado, ej: \"FICHA_ROJA\", \"GUIÑO\"~%string source     # \"mano\" o \"rostro\"~%int32 fingers     # Número de dedos detectados (-1 si no aplica)~%bool rock         # Gesto rock (🤘)~%bool wink         # Guiño~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GestoResult>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'type))
     4 (cl:length (cl:slot-value msg 'source))
     4
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GestoResult>))
  "Converts a ROS message object to a list"
  (cl:list 'GestoResult
    (cl:cons ':type (type msg))
    (cl:cons ':source (source msg))
    (cl:cons ':fingers (fingers msg))
    (cl:cons ':rock (rock msg))
    (cl:cons ':wink (wink msg))
))
