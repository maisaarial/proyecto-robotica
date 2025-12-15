cmake_minimum_required(VERSION 3.0.2)

# EDIT: name of package
project(ros_python_pkg)

# EDIT: list all <build_depend> and <depend> package dependencies
find_package(catkin REQUIRED COMPONENTS
  rospy
  std_msgs
  geometry_msgs
  message_runtime
)

catkin_python_setup()

catkin_package(CATKIN_DEPENDS message_runtime)

include_directories(
  ${catkin_INCLUDE_DIRS}
)

# EDIT: list all executable python and shell scripts for installation
install(PROGRAMS
   scripts/*
   nodes/*
   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

## Mark other files for installation (e.g. launch and bag files, etc.)
# install(FILES
#   # myfile1
#   # myfile2
#   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
# )

## Add message files
#add_message_files(
#  FILES
#  Tablero.msg
#)

## Generate added messages
#generate_messages(
#  DEPENDENCIES
#  std_msgs
#  geometry_msgs
#  actionlib_msgs
#)