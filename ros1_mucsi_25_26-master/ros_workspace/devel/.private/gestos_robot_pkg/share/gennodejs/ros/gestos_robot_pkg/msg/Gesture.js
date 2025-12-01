// Auto-generated. Do not edit!

// (in-package gestos_robot_pkg.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Gesture {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.type = null;
      this.source = null;
      this.fingers = null;
      this.long_blink = null;
    }
    else {
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = '';
      }
      if (initObj.hasOwnProperty('source')) {
        this.source = initObj.source
      }
      else {
        this.source = '';
      }
      if (initObj.hasOwnProperty('fingers')) {
        this.fingers = initObj.fingers
      }
      else {
        this.fingers = 0;
      }
      if (initObj.hasOwnProperty('long_blink')) {
        this.long_blink = initObj.long_blink
      }
      else {
        this.long_blink = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Gesture
    // Serialize message field [type]
    bufferOffset = _serializer.string(obj.type, buffer, bufferOffset);
    // Serialize message field [source]
    bufferOffset = _serializer.string(obj.source, buffer, bufferOffset);
    // Serialize message field [fingers]
    bufferOffset = _serializer.int32(obj.fingers, buffer, bufferOffset);
    // Serialize message field [long_blink]
    bufferOffset = _serializer.bool(obj.long_blink, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Gesture
    let len;
    let data = new Gesture(null);
    // Deserialize message field [type]
    data.type = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [source]
    data.source = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [fingers]
    data.fingers = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [long_blink]
    data.long_blink = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.type);
    length += _getByteLength(object.source);
    return length + 13;
  }

  static datatype() {
    // Returns string type for a message object
    return 'gestos_robot_pkg/Gesture';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '12e6b3f163de8d922be0c5c5e43c1a72';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string type       # Nombre del gesto detectado, ej: "FICHA_ROJA", "GUIÑO"
    string source     # "mano" o "rostro"
    int32 fingers     # Número de dedos detectados (-1 si no aplica)
    bool long_blink   # Parpadeo largo
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Gesture(null);
    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = ''
    }

    if (msg.source !== undefined) {
      resolved.source = msg.source;
    }
    else {
      resolved.source = ''
    }

    if (msg.fingers !== undefined) {
      resolved.fingers = msg.fingers;
    }
    else {
      resolved.fingers = 0
    }

    if (msg.long_blink !== undefined) {
      resolved.long_blink = msg.long_blink;
    }
    else {
      resolved.long_blink = false
    }

    return resolved;
    }
};

module.exports = Gesture;
