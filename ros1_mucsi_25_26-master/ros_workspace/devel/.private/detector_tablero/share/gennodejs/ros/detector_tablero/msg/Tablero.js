// Auto-generated. Do not edit!

// (in-package detector_tablero.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class Tablero {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.colores = null;
      this.casillas = null;
    }
    else {
      if (initObj.hasOwnProperty('colores')) {
        this.colores = initObj.colores
      }
      else {
        this.colores = [];
      }
      if (initObj.hasOwnProperty('casillas')) {
        this.casillas = initObj.casillas
      }
      else {
        this.casillas = new geometry_msgs.msg.Pose();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Tablero
    // Serialize message field [colores]
    bufferOffset = _arraySerializer.string(obj.colores, buffer, bufferOffset, null);
    // Serialize message field [casillas]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.casillas, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Tablero
    let len;
    let data = new Tablero(null);
    // Deserialize message field [colores]
    data.colores = _arrayDeserializer.string(buffer, bufferOffset, null)
    // Deserialize message field [casillas]
    data.casillas = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.colores.forEach((val) => {
      length += 4 + _getByteLength(val);
    });
    return length + 60;
  }

  static datatype() {
    // Returns string type for a message object
    return 'detector_tablero/Tablero';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '71151b07a522e59996993ee37495dfc2';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string[] colores
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Tablero(null);
    if (msg.colores !== undefined) {
      resolved.colores = msg.colores;
    }
    else {
      resolved.colores = []
    }

    if (msg.casillas !== undefined) {
      resolved.casillas = geometry_msgs.msg.Pose.Resolve(msg.casillas)
    }
    else {
      resolved.casillas = new geometry_msgs.msg.Pose()
    }

    return resolved;
    }
};

module.exports = Tablero;
