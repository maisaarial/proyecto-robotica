cmake_minimum_required(VERSION 3.0.2)
project(detector_tablero)

###################################
## Find catkin and dependencies
###################################
find_package(catkin REQUIRED COMPONENTS
  rospy
  std_msgs
  message_generation
  actionlib_msgs
  geometry_msgs
  genmsg
)

catkin_python_setup()

###################################
## Declare messages and actions
###################################
add_message_files(
  DIRECTORY msg
  FILES
    Tablero.msg
)

add_action_files(
  DIRECTORY action
  FILES
    Casillas.action
)

generate_messages(
  DEPENDENCIES
    std_msgs
    actionlib_msgs
    geometry_msgs
)

###################################
## Catkin package
###################################
catkin_package(
  CATKIN_DEPENDS
    message_runtime
    std_msgs
    actionlib_msgs
    geometry_msgs
)

###################################
## Include directories
###################################
include_directories(
  ${catkin_INCLUDE_DIRS}
)

###################################
## Install scripts
###################################
install(PROGRAMS
  scripts/*
  nodes/*
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
