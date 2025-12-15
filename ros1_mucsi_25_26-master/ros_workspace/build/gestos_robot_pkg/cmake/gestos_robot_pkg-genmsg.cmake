# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "gestos_robot_pkg: 15 messages, 0 services")

set(MSG_I_FLAGS "-Igestos_robot_pkg:/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg;-Igestos_robot_pkg:/home/laboratorio/ros_workspace/src/gestos_robot_pkg/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/noetic/share/actionlib_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(gestos_robot_pkg_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadAction.msg" NAME_WE)
add_custom_target(_gestos_robot_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gestos_robot_pkg" "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadAction.msg" "gestos_robot_pkg/DiceReadFeedback:actionlib_msgs/GoalID:actionlib_msgs/GoalStatus:std_msgs/Header:gestos_robot_pkg/DiceReadActionResult:gestos_robot_pkg/DiceReadActionFeedback:gestos_robot_pkg/DiceReadGoal:gestos_robot_pkg/DiceReadActionGoal:gestos_robot_pkg/DiceReadResult"
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionGoal.msg" NAME_WE)
add_custom_target(_gestos_robot_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gestos_robot_pkg" "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionGoal.msg" "gestos_robot_pkg/DiceReadGoal:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionResult.msg" NAME_WE)
add_custom_target(_gestos_robot_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gestos_robot_pkg" "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionResult.msg" "actionlib_msgs/GoalStatus:gestos_robot_pkg/DiceReadResult:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionFeedback.msg" NAME_WE)
add_custom_target(_gestos_robot_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gestos_robot_pkg" "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionFeedback.msg" "actionlib_msgs/GoalStatus:gestos_robot_pkg/DiceReadFeedback:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg" NAME_WE)
add_custom_target(_gestos_robot_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gestos_robot_pkg" "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg" ""
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg" NAME_WE)
add_custom_target(_gestos_robot_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gestos_robot_pkg" "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg" ""
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg" NAME_WE)
add_custom_target(_gestos_robot_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gestos_robot_pkg" "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg" ""
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoAction.msg" NAME_WE)
add_custom_target(_gestos_robot_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gestos_robot_pkg" "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoAction.msg" "gestos_robot_pkg/GestoActionGoal:gestos_robot_pkg/GestoFeedback:actionlib_msgs/GoalID:actionlib_msgs/GoalStatus:gestos_robot_pkg/GestoActionFeedback:gestos_robot_pkg/GestoResult:std_msgs/Header:gestos_robot_pkg/GestoActionResult:gestos_robot_pkg/GestoGoal"
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionGoal.msg" NAME_WE)
add_custom_target(_gestos_robot_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gestos_robot_pkg" "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionGoal.msg" "gestos_robot_pkg/GestoGoal:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionResult.msg" NAME_WE)
add_custom_target(_gestos_robot_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gestos_robot_pkg" "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionResult.msg" "actionlib_msgs/GoalStatus:gestos_robot_pkg/GestoResult:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionFeedback.msg" NAME_WE)
add_custom_target(_gestos_robot_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gestos_robot_pkg" "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionFeedback.msg" "actionlib_msgs/GoalStatus:gestos_robot_pkg/GestoFeedback:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg" NAME_WE)
add_custom_target(_gestos_robot_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gestos_robot_pkg" "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg" ""
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg" NAME_WE)
add_custom_target(_gestos_robot_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gestos_robot_pkg" "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg" ""
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg" NAME_WE)
add_custom_target(_gestos_robot_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gestos_robot_pkg" "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg" ""
)

get_filename_component(_filename "/home/laboratorio/ros_workspace/src/gestos_robot_pkg/msg/Gesture.msg" NAME_WE)
add_custom_target(_gestos_robot_pkg_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gestos_robot_pkg" "/home/laboratorio/ros_workspace/src/gestos_robot_pkg/msg/Gesture.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadAction.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionResult.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionFeedback.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionGoal.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_cpp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_cpp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_cpp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_cpp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_cpp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_cpp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_cpp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoAction.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionGoal.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionFeedback.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionResult.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_cpp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_cpp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_cpp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_cpp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_cpp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_cpp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_cpp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/src/gestos_robot_pkg/msg/Gesture.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg
)

### Generating Services

### Generating Module File
_generate_module_cpp(gestos_robot_pkg
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(gestos_robot_pkg_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(gestos_robot_pkg_generate_messages gestos_robot_pkg_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadAction.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_cpp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_cpp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_cpp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_cpp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_cpp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_cpp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_cpp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoAction.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_cpp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_cpp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_cpp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_cpp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_cpp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_cpp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_cpp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/src/gestos_robot_pkg/msg/Gesture.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_cpp _gestos_robot_pkg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gestos_robot_pkg_gencpp)
add_dependencies(gestos_robot_pkg_gencpp gestos_robot_pkg_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gestos_robot_pkg_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadAction.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionResult.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionFeedback.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionGoal.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_eus(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_eus(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_eus(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_eus(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_eus(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_eus(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_eus(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoAction.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionGoal.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionFeedback.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionResult.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_eus(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_eus(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_eus(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_eus(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_eus(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_eus(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_eus(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/src/gestos_robot_pkg/msg/Gesture.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg
)

### Generating Services

### Generating Module File
_generate_module_eus(gestos_robot_pkg
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(gestos_robot_pkg_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(gestos_robot_pkg_generate_messages gestos_robot_pkg_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadAction.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_eus _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_eus _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_eus _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_eus _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_eus _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_eus _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_eus _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoAction.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_eus _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_eus _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_eus _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_eus _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_eus _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_eus _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_eus _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/src/gestos_robot_pkg/msg/Gesture.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_eus _gestos_robot_pkg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gestos_robot_pkg_geneus)
add_dependencies(gestos_robot_pkg_geneus gestos_robot_pkg_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gestos_robot_pkg_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadAction.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionResult.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionFeedback.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionGoal.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_lisp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_lisp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_lisp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_lisp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_lisp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_lisp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_lisp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoAction.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionGoal.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionFeedback.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionResult.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_lisp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_lisp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_lisp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_lisp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_lisp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_lisp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_lisp(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/src/gestos_robot_pkg/msg/Gesture.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg
)

### Generating Services

### Generating Module File
_generate_module_lisp(gestos_robot_pkg
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(gestos_robot_pkg_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(gestos_robot_pkg_generate_messages gestos_robot_pkg_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadAction.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_lisp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_lisp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_lisp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_lisp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_lisp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_lisp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_lisp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoAction.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_lisp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_lisp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_lisp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_lisp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_lisp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_lisp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_lisp _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/src/gestos_robot_pkg/msg/Gesture.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_lisp _gestos_robot_pkg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gestos_robot_pkg_genlisp)
add_dependencies(gestos_robot_pkg_genlisp gestos_robot_pkg_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gestos_robot_pkg_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadAction.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionResult.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionFeedback.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionGoal.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_nodejs(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_nodejs(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_nodejs(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_nodejs(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_nodejs(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_nodejs(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_nodejs(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoAction.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionGoal.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionFeedback.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionResult.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_nodejs(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_nodejs(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_nodejs(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_nodejs(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_nodejs(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_nodejs(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_nodejs(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/src/gestos_robot_pkg/msg/Gesture.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg
)

### Generating Services

### Generating Module File
_generate_module_nodejs(gestos_robot_pkg
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(gestos_robot_pkg_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(gestos_robot_pkg_generate_messages gestos_robot_pkg_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadAction.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_nodejs _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_nodejs _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_nodejs _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_nodejs _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_nodejs _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_nodejs _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_nodejs _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoAction.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_nodejs _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_nodejs _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_nodejs _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_nodejs _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_nodejs _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_nodejs _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_nodejs _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/src/gestos_robot_pkg/msg/Gesture.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_nodejs _gestos_robot_pkg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gestos_robot_pkg_gennodejs)
add_dependencies(gestos_robot_pkg_gennodejs gestos_robot_pkg_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gestos_robot_pkg_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadAction.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionResult.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionFeedback.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionGoal.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_py(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_py(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_py(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_py(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_py(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_py(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_py(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoAction.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionGoal.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionFeedback.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionResult.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_py(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_py(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionResult.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_py(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_py(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_py(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_py(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
)
_generate_msg_py(gestos_robot_pkg
  "/home/laboratorio/ros_workspace/src/gestos_robot_pkg/msg/Gesture.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
)

### Generating Services

### Generating Module File
_generate_module_py(gestos_robot_pkg
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(gestos_robot_pkg_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(gestos_robot_pkg_generate_messages gestos_robot_pkg_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadAction.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_py _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_py _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_py _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadActionFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_py _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_py _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_py _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/DiceReadFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_py _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoAction.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_py _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_py _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_py _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoActionFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_py _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoGoal.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_py _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoResult.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_py _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/devel/.private/gestos_robot_pkg/share/gestos_robot_pkg/msg/GestoFeedback.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_py _gestos_robot_pkg_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/laboratorio/ros_workspace/src/gestos_robot_pkg/msg/Gesture.msg" NAME_WE)
add_dependencies(gestos_robot_pkg_generate_messages_py _gestos_robot_pkg_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gestos_robot_pkg_genpy)
add_dependencies(gestos_robot_pkg_genpy gestos_robot_pkg_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gestos_robot_pkg_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gestos_robot_pkg
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(gestos_robot_pkg_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET actionlib_msgs_generate_messages_cpp)
  add_dependencies(gestos_robot_pkg_generate_messages_cpp actionlib_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gestos_robot_pkg
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(gestos_robot_pkg_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET actionlib_msgs_generate_messages_eus)
  add_dependencies(gestos_robot_pkg_generate_messages_eus actionlib_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gestos_robot_pkg
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(gestos_robot_pkg_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET actionlib_msgs_generate_messages_lisp)
  add_dependencies(gestos_robot_pkg_generate_messages_lisp actionlib_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gestos_robot_pkg
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(gestos_robot_pkg_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET actionlib_msgs_generate_messages_nodejs)
  add_dependencies(gestos_robot_pkg_generate_messages_nodejs actionlib_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
    DESTINATION ${genpy_INSTALL_DIR}
    # skip all init files
    PATTERN "__init__.py" EXCLUDE
    PATTERN "__init__.pyc" EXCLUDE
  )
  # install init files which are not in the root folder of the generated code
  string(REGEX REPLACE "([][+.*()^])" "\\\\\\1" ESCAPED_PATH "${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg")
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gestos_robot_pkg
    DESTINATION ${genpy_INSTALL_DIR}
    FILES_MATCHING
    REGEX "${ESCAPED_PATH}/.+/__init__.pyc?$"
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(gestos_robot_pkg_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET actionlib_msgs_generate_messages_py)
  add_dependencies(gestos_robot_pkg_generate_messages_py actionlib_msgs_generate_messages_py)
endif()
