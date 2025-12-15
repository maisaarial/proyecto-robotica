import yaml 

with open("/home/laboratorio/ros_workspace/src/gestos_robot_pkg/src/gestos_robot_pkg/robot/poses/home_position.yaml", "r") as f:
    joint_dict = yaml.safe_load(f)
    print (joint_dict)