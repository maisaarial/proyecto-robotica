# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "detector_tablero: 8 messages, 0 services")

set(MSG_I_FLAGS "-Idetector_tablero:/home/laboratorio/ros_workspace/src/detector_tablero/msg;-Idetector_tablero:/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/noetic/share/actionlib_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(detector_tablero_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/laboratorio/ros_workspace/src/detector_tablero/msg/Tablero.msg" NAME_WE)
add_custom_target(_detector_tablero_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "detector_tablero" "/home/laboratorio/ros_workspace/src/detector_tablero/msg/Tablero.msg" "geometry_msgs/Pose:geometry_msgs/Quaternion:geometry_msgs/Point"
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasAction.msg" NAME_WE)
add_custom_target(_detector_tablero_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "detector_tablero" "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasAction.msg" "detector_tablero/CasillasActionResult:detector_tablero/CasillasActionFeedback:detector_tablero/CasillasResult:std_msgs/Header:detector_tablero/CasillasGoal:actionlib_msgs/GoalID:geometry_msgs/Quaternion:geometry_msgs/Pose:geometry_msgs/Point:detector_tablero/Cell:detector_tablero/CasillasFeedback:actionlib_msgs/GoalStatus:detector_tablero/CasillasActionGoal"
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionGoal.msg" NAME_WE)
add_custom_target(_detector_tablero_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "detector_tablero" "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionGoal.msg" "detector_tablero/CasillasGoal:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionResult.msg" NAME_WE)
add_custom_target(_detector_tablero_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "detector_tablero" "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionResult.msg" "detector_tablero/CasillasResult:std_msgs/Header:actionlib_msgs/GoalID:geometry_msgs/Quaternion:geometry_msgs/Pose:geometry_msgs/Point:detector_tablero/Cell:actionlib_msgs/GoalStatus"
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionFeedback.msg" NAME_WE)
add_custom_target(_detector_tablero_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "detector_tablero" "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionFeedback.msg" "detector_tablero/CasillasFeedback:actionlib_msgs/GoalID:actionlib_msgs/GoalStatus:std_msgs/Header"
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg" NAME_WE)
add_custom_target(_detector_tablero_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "detector_tablero" "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg" ""
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg" NAME_WE)
add_custom_target(_detector_tablero_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "detector_tablero" "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg" "geometry_msgs/Pose:geometry_msgs/Quaternion:geometry_msgs/Point:detector_tablero/Cell"
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg" NAME_WE)
add_custom_target(_detector_tablero_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "detector_tablero" "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(detector_tablero
  "/home/laboratorio/ros_workspace/src/detector_tablero/msg/Tablero.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/detector_tablero
)
_generate_msg_cpp(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasAction.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionResult.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionFeedback.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/laboratorio/ros_workspace/src/detector_tablero/msg/Cell.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/detector_tablero
)
_generate_msg_cpp(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/detector_tablero
)
_generate_msg_cpp(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/laboratorio/ros_workspace/src/detector_tablero/msg/Cell.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/detector_tablero
)
_generate_msg_cpp(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/detector_tablero
)
_generate_msg_cpp(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/detector_tablero
)
_generate_msg_cpp(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/laboratorio/ros_workspace/src/detector_tablero/msg/Cell.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/detector_tablero
)
_generate_msg_cpp(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/detector_tablero
)

### Generating Services

### Generating Module File
_generate_module_cpp(detector_tablero
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/detector_tablero
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(detector_tablero_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(detector_tablero_generate_messages detector_tablero_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/laboratorio/ros_workspace/src/detector_tablero/msg/Tablero.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_cpp _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasAction.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_cpp _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionGoal.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_cpp _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionResult.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_cpp _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionFeedback.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_cpp _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_cpp _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_cpp _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_cpp _detector_tablero_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(detector_tablero_gencpp)
add_dependencies(detector_tablero_gencpp detector_tablero_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS detector_tablero_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(detector_tablero
  "/home/laboratorio/ros_workspace/src/detector_tablero/msg/Tablero.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/detector_tablero
)
_generate_msg_eus(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasAction.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionResult.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionFeedback.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/laboratorio/ros_workspace/src/detector_tablero/msg/Cell.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/detector_tablero
)
_generate_msg_eus(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/detector_tablero
)
_generate_msg_eus(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/laboratorio/ros_workspace/src/detector_tablero/msg/Cell.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/detector_tablero
)
_generate_msg_eus(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/detector_tablero
)
_generate_msg_eus(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/detector_tablero
)
_generate_msg_eus(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/laboratorio/ros_workspace/src/detector_tablero/msg/Cell.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/detector_tablero
)
_generate_msg_eus(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/detector_tablero
)

### Generating Services

### Generating Module File
_generate_module_eus(detector_tablero
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/detector_tablero
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(detector_tablero_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(detector_tablero_generate_messages detector_tablero_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/laboratorio/ros_workspace/src/detector_tablero/msg/Tablero.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_eus _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasAction.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_eus _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionGoal.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_eus _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionResult.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_eus _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionFeedback.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_eus _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_eus _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_eus _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_eus _detector_tablero_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(detector_tablero_geneus)
add_dependencies(detector_tablero_geneus detector_tablero_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS detector_tablero_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(detector_tablero
  "/home/laboratorio/ros_workspace/src/detector_tablero/msg/Tablero.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/detector_tablero
)
_generate_msg_lisp(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasAction.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionResult.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionFeedback.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/laboratorio/ros_workspace/src/detector_tablero/msg/Cell.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/detector_tablero
)
_generate_msg_lisp(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/detector_tablero
)
_generate_msg_lisp(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/laboratorio/ros_workspace/src/detector_tablero/msg/Cell.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/detector_tablero
)
_generate_msg_lisp(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/detector_tablero
)
_generate_msg_lisp(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/detector_tablero
)
_generate_msg_lisp(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/laboratorio/ros_workspace/src/detector_tablero/msg/Cell.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/detector_tablero
)
_generate_msg_lisp(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/detector_tablero
)

### Generating Services

### Generating Module File
_generate_module_lisp(detector_tablero
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/detector_tablero
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(detector_tablero_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(detector_tablero_generate_messages detector_tablero_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/laboratorio/ros_workspace/src/detector_tablero/msg/Tablero.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_lisp _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasAction.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_lisp _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionGoal.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_lisp _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionResult.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_lisp _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionFeedback.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_lisp _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_lisp _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_lisp _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_lisp _detector_tablero_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(detector_tablero_genlisp)
add_dependencies(detector_tablero_genlisp detector_tablero_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS detector_tablero_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(detector_tablero
  "/home/laboratorio/ros_workspace/src/detector_tablero/msg/Tablero.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/detector_tablero
)
_generate_msg_nodejs(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasAction.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionResult.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionFeedback.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/laboratorio/ros_workspace/src/detector_tablero/msg/Cell.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/detector_tablero
)
_generate_msg_nodejs(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/detector_tablero
)
_generate_msg_nodejs(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/laboratorio/ros_workspace/src/detector_tablero/msg/Cell.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/detector_tablero
)
_generate_msg_nodejs(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/detector_tablero
)
_generate_msg_nodejs(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/detector_tablero
)
_generate_msg_nodejs(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/laboratorio/ros_workspace/src/detector_tablero/msg/Cell.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/detector_tablero
)
_generate_msg_nodejs(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/detector_tablero
)

### Generating Services

### Generating Module File
_generate_module_nodejs(detector_tablero
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/detector_tablero
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(detector_tablero_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(detector_tablero_generate_messages detector_tablero_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/laboratorio/ros_workspace/src/detector_tablero/msg/Tablero.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_nodejs _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasAction.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_nodejs _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionGoal.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_nodejs _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionResult.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_nodejs _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionFeedback.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_nodejs _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_nodejs _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_nodejs _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_nodejs _detector_tablero_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(detector_tablero_gennodejs)
add_dependencies(detector_tablero_gennodejs detector_tablero_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS detector_tablero_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(detector_tablero
  "/home/laboratorio/ros_workspace/src/detector_tablero/msg/Tablero.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/detector_tablero
)
_generate_msg_py(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasAction.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionResult.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionFeedback.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/laboratorio/ros_workspace/src/detector_tablero/msg/Cell.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/detector_tablero
)
_generate_msg_py(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/detector_tablero
)
_generate_msg_py(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/laboratorio/ros_workspace/src/detector_tablero/msg/Cell.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/detector_tablero
)
_generate_msg_py(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/detector_tablero
)
_generate_msg_py(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/detector_tablero
)
_generate_msg_py(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/home/laboratorio/ros_workspace/src/detector_tablero/msg/Cell.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/detector_tablero
)
_generate_msg_py(detector_tablero
  "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/detector_tablero
)

### Generating Services

### Generating Module File
_generate_module_py(detector_tablero
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/detector_tablero
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(detector_tablero_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(detector_tablero_generate_messages detector_tablero_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/laboratorio/ros_workspace/src/detector_tablero/msg/Tablero.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_py _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasAction.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_py _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionGoal.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_py _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionResult.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_py _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasActionFeedback.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_py _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasGoal.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_py _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasResult.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_py _detector_tablero_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/detector_tablero/share/detector_tablero/msg/CasillasFeedback.msg" NAME_WE)
add_dependencies(detector_tablero_generate_messages_py _detector_tablero_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(detector_tablero_genpy)
add_dependencies(detector_tablero_genpy detector_tablero_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS detector_tablero_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/detector_tablero)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/detector_tablero
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(detector_tablero_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET actionlib_msgs_generate_messages_cpp)
  add_dependencies(detector_tablero_generate_messages_cpp actionlib_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(detector_tablero_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/detector_tablero)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/detector_tablero
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(detector_tablero_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET actionlib_msgs_generate_messages_eus)
  add_dependencies(detector_tablero_generate_messages_eus actionlib_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(detector_tablero_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/detector_tablero)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/detector_tablero
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(detector_tablero_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET actionlib_msgs_generate_messages_lisp)
  add_dependencies(detector_tablero_generate_messages_lisp actionlib_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(detector_tablero_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/detector_tablero)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/detector_tablero
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(detector_tablero_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET actionlib_msgs_generate_messages_nodejs)
  add_dependencies(detector_tablero_generate_messages_nodejs actionlib_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(detector_tablero_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/detector_tablero)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/detector_tablero\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/detector_tablero
    DESTINATION ${genpy_INSTALL_DIR}
    # skip all init files
    PATTERN "__init__.py" EXCLUDE
    PATTERN "__init__.pyc" EXCLUDE
  )
  # install init files which are not in the root folder of the generated code
  string(REGEX REPLACE "([][+.*()^])" "\\\\\\1" ESCAPED_PATH "${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/detector_tablero")
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/detector_tablero
    DESTINATION ${genpy_INSTALL_DIR}
    FILES_MATCHING
    REGEX "${ESCAPED_PATH}/.+/__init__.pyc?$"
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(detector_tablero_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET actionlib_msgs_generate_messages_py)
  add_dependencies(detector_tablero_generate_messages_py actionlib_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(detector_tablero_generate_messages_py geometry_msgs_generate_messages_py)
endif()
