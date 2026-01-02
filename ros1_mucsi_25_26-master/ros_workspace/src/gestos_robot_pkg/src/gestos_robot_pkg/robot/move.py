#!/usr/bin/python3
import sys
import yaml
import copy
import rospy
import numpy as np
import time 
from moveit_commander import MoveGroupCommander, RobotCommander, roscpp_initialize, PlanningSceneInterface
import moveit_msgs.msg
from math import pi, tau, dist, fabs, cos
from std_msgs.msg import String
from moveit_commander.conversions import pose_to_list
from typing import List
from geometry_msgs.msg import Pose, PoseStamped, Point, Quaternion
from control_msgs.msg import GripperCommandAction, GripperCommandGoal, GripperCommandResult
from actionlib import SimpleActionClient
from gestos_robot_pkg.actions.request_tablero import TableroActionClient

class ControlRobot:
    def __init__(self) -> None:
        roscpp_initialize(sys.argv)
        rospy.init_node("control_robot", anonymous=True)#tener en cuenta
        #hay que comentar la linea anterior para poder utilizar robot_command.py
        self.robot = RobotCommander()
        self.scene = PlanningSceneInterface()
        self.group_name = "robot"
        self.move_group = MoveGroupCommander(self.group_name)
        self.gripper_action_client = SimpleActionClient("rg2_action_server", GripperCommandAction)
        self.añadir_suelo()
        
        self.robot_relative_x = -0.016
        self.robot_relative_y = 0.18

    def articulaciones_actuales(self) -> list:
        return self.move_group.get_current_joint_values()
    
    def mover_articulaciones(self, joint_goal: List[float], wait: bool= True) -> bool:
        return self.move_group.go(joint_goal, wait=wait)
    
    def pose_actual(self) -> Pose:
        return self.move_group.get_current_pose().pose
    
    def pose_from_yaml(self, path):
        yaml_file = path
        with open(yaml_file, "r") as f:
            yaml_pose = yaml.safe_load(f)
        pose = Pose()
        pose.position.x, pose.position.y, pose.position.z  = yaml_pose['position']['x'], yaml_pose['position']['y'], yaml_pose['position']['z']
        pose.orientation.x, pose.orientation.y, pose.orientation.z, pose.orientation.w = yaml_pose['orientation']['x'], yaml_pose['orientation']['y'], yaml_pose['orientation']['z'], yaml_pose['orientation']['w']
        return pose
    
    def pose_a_stamped(self, pose: Pose) -> PoseStamped:
        pose_stamped = PoseStamped()
        pose_stamped.header.frame_id = "base_link"
        pose_stamped.pose = pose
        return pose_stamped
    
    def mover_a_pose(self, pose_goal: Pose, wait: bool=True) -> bool:
        self.move_group.set_pose_target(pose_goal)
        return self.move_group.go(wait=wait)
    
    def añadir_caja_a_escena_de_planificacion(self, pose_caja: Pose, name: str,
                                  tamaño: tuple = (.1,.1,.1)) -> None:
        box_pose = PoseStamped()
        box_pose.header.frame_id = "base_link"
        box_pose.pose = pose_caja
        box_name = name
        self.scene.add_box(box_name, box_pose, size=tamaño)

    def mover_trayectoria(self, poses: List[Pose], wait: bool = True) -> bool:
        poses_aux = copy.deepcopy(poses)
        poses_aux.insert(0, self.pose_actual())
            
        (plan, fraction) = self.move_group.compute_cartesian_path(poses_aux, 0.01)

        if fraction != 1.0:
            return False
        
        return self.move_group.execute(plan, wait=wait)

    def añadir_suelo(self) -> None:
        pose_suelo = Pose()
        pose_suelo.position.z = -0.026
        self.añadir_caja_a_escena_de_planificacion(pose_suelo,"suelo",(2,2,.05))
        
    def mover_pinza(self, anchura_dedos: float, fuerza: float) -> bool:
        goal = GripperCommandGoal()
        goal.command.position = anchura_dedos
        goal.command.max_effort = fuerza
        self.gripper_action_client.send_goal(goal)
        self.gripper_action_client.wait_for_result()
        result = self.gripper_action_client.get_result()
        return result.reached_goal
    def move_to_home(self):
        with open("/home/laboratorio/ros_workspace/src/gestos_robot_pkg/src/gestos_robot_pkg/robot/poses/home_position2.yaml", "r") as f:
            home_joints = yaml.safe_load(f)
        self.mover_articulaciones(home_joints)
        self.mover_pinza(anchura_dedos=80, fuerza=30)

    def tirar_dado(self):
        with open("/home/laboratorio/ros_workspace/src/gestos_robot_pkg/src/gestos_robot_pkg/robot/poses/home_position2.yaml", "r") as f:
            home_joints = yaml.safe_load(f)
        self.mover_articulaciones(home_joints)
        home = self.pose_actual()
        
        dice_pose = self.pose_from_yaml("/home/laboratorio/ros_workspace/src/gestos_robot_pkg/src/gestos_robot_pkg/robot/poses/dice_pose2.yaml")
        p1 = np.array([home.position.x, home.position.y, home.position.z])
        p2 = np.array([dice_pose.position.x, dice_pose.position.y, dice_pose.position.z])
        
        puntos = np.linspace(p1, p2, 10)
        trayectoria= []
        for point in puntos:
            trayectoria.append(Pose(position=Point(x=point[0], y=point[1], z=point[2])))
        self.mover_trayectoria(trayectoria)
        self.mover_a_pose(dice_pose)
        
        self.mover_pinza(anchura_dedos=10, fuerza=30)
        time.sleep(1.5)
        dice_pose.position.z += 0.05
        self.mover_a_pose(dice_pose)
        dice_pose = self.pose_from_yaml("/home/laboratorio/ros_workspace/src/gestos_robot_pkg/src/gestos_robot_pkg/robot/poses/dice_pose3.yaml")
        self.mover_a_pose(dice_pose)
        self.mover_pinza(anchura_dedos=80, fuerza=20)
        time.sleep(1.5)
        
        
        p1 = np.array([dice_pose.position.x, dice_pose.position.y, dice_pose.position.z])
        p2 = np.array([home.position.x, home.position.y, home.position.z])
        
        puntos = np.linspace(p1, p2, 10)
        trayectoria= []
        for point in puntos:
            trayectoria.append(Pose(position=Point(x=point[0], y=point[1], z=point[2])))
        self.mover_trayectoria(trayectoria)
        self.mover_a_pose(home)

    def move_piece_to_cell(self, ficha, casillas, idx_cell):
        self.mover_pinza(anchura_dedos=80, fuerza=20)
        home = self.pose_actual()
        pose_1 = self.pose_actual()
        pose_2 = self.pose_actual()
        
        goal_piece = ficha.pose
        pose_1.position.x -= goal_piece.position.x - self.robot_relative_x
        pose_1.position.y -=  goal_piece.position.y - self.robot_relative_y
        
        p1 = np.array([home.position.x, home.position.y, home.position.z])
        p2 = np.array([pose_1.position.x, pose_1.position.y, pose_1.position.z])
        
        puntos = np.linspace(p1, p2, 10)
        trayectoria= []
        for point in puntos:
            trayectoria.append(Pose(position=Point(x=point[0], y=point[1], z=point[2])))
        self.mover_trayectoria(trayectoria)
        
        self.mover_a_pose(pose_1)
        pose_1.position.z -= 0.048
        self.mover_a_pose(pose_1)
        time.sleep(2)
        self.mover_pinza(anchura_dedos=10, fuerza=20)
        time.sleep(2)
        pose_1.position.z += 0.048
        self.mover_a_pose(pose_1)
        
        
        goal_cell = casillas[idx_cell].pose
        pose_2.position.x -= goal_cell.position.x - self.robot_relative_x
        pose_2.position.y -=  goal_cell.position.y - self.robot_relative_y
        
        p1 = np.array([pose_1.position.x, pose_1.position.y, pose_1.position.z])
        p2 = np.array([pose_2.position.x, pose_2.position.y, pose_2.position.z])
        
        puntos = np.linspace(p1, p2, 10)
        trayectoria= []
        for point in puntos:
            trayectoria.append(Pose(position=Point(x=point[0], y=point[1], z=point[2])))
        self.mover_trayectoria(trayectoria)
        
        self.mover_a_pose(pose_2)
        pose_2.position.z -= 0.048
        self.mover_a_pose(pose_2)
        time.sleep(2)
        self.mover_pinza(anchura_dedos=80, fuerza=20)
        pose_2.position.z += 0.048
        self.mover_a_pose(pose_2)
        
        
        p1 = np.array([pose_2.position.x, pose_2.position.y, pose_2.position.z])
        p1 = np.array([home.position.x, home.position.y, home.position.z])
        
        puntos = np.linspace(p1, p2, 10)
        trayectoria= []
        for point in puntos:
            trayectoria.append(Pose(position=Point(x=point[0], y=point[1], z=point[2])))
        self.mover_trayectoria(trayectoria)
        
        with open("/home/laboratorio/ros_workspace/src/gestos_robot_pkg/src/gestos_robot_pkg/robot/poses/home_position2.yaml", "r") as f:
            home_joints = yaml.safe_load(f)
        self.mover_articulaciones(home_joints)
        
        

if __name__ == '__main__':
    # Crear el objeto de tipo robot
    control = ControlRobot()

    # Mover el robot a articulaciones iniciales
    #pose_actual = control.pose_actual()
    
    '''
################################### test Tablero ##############################
    control = ControlRobot()
    pose = Pose(position=Point(0,0,0.5))
    #
    
    with open("/home/laboratorio/ros_workspace/src/gestos_robot_pkg/src/gestos_robot_pkg/robot/poses/home_position2.yaml", "r") as f:
        home_joints = yaml.safe_load(f)
    control.mover_articulaciones(home_joints)
    
    home_pose = control.pose_from_yaml("/home/laboratorio/ros_workspace/src/gestos_robot_pkg/src/gestos_robot_pkg/robot/poses/dice_pose2.yaml")
    control.mover_a_pose(home_pose)
    control.mover_pinza(anchura_dedos=10, fuerza=30)
    time.sleep(1.5)
    home_pose.position.z += 0.05
    control.mover_a_pose(home_pose)
    home_pose = control.pose_from_yaml("/home/laboratorio/ros_workspace/src/gestos_robot_pkg/src/gestos_robot_pkg/robot/poses/dice_pose3.yaml")
    control.mover_a_pose(home_pose)
    control.mover_pinza(anchura_dedos=80, fuerza=20)
    time.sleep(1.5)
    control.mover_articulaciones(home_joints)
    #control.añadir_caja_a_escena_de_planificacion(pose,"obstaculo",(2,2,.05))
    
    
    
    with open("/home/laboratorio/ros_workspace/src/gestos_robot_pkg/src/gestos_robot_pkg/robot/poses/home_position.yaml", "r") as f:
        home_joints = yaml.safe_load(f)
    control.mover_articulaciones(home_joints)
    
    tablero = TableroActionClient()
    casillas = tablero.request_tablero(0)
    pi_medios = pi/2
    control.mover_pinza(anchura_dedos=40, fuerza=20)
    if casillas is not None : 
        control.move_piece_to_cell(casillas[4], casillas, 19)'''
    
    
####################################### HOME ##################################
    # para coger pose home
    #home_joints = control.articulaciones_actuales()
    #print(home_joints)
    #home_pose = control.pose_actual()
    #print(home_pose)
    '''
    control.mover_pinza(anchura_dedos=0, fuerza=20)
    '''
    '''with open("/home/laboratorio/ros_workspace/src/gestos_robot_pkg/src/gestos_robot_pkg/robot/poses/pre_dice_position.yaml", "r") as f:
        fst_joints = yaml.safe_load(f)
    control.mover_articulaciones(fst_joints)
    with open("/home/laboratorio/ros_workspace/src/gestos_robot_pkg/src/gestos_robot_pkg/robot/poses/dice_position.yaml", "r") as f:
        scnd_joints = yaml.safe_load(f)
    control.mover_articulaciones(scnd_joints)'''
    '''
    home_pose = control.pose_actual()
    print(home_pose)
    yaml_file = "/home/laboratorio/ros_workspace/src/gestos_robot_pkg/src/gestos_robot_pkg/robot/poses/dice_pose.yaml"
    pose = control.pose_from_yaml(yaml_file)
    
    control.mover_a_pose(pose)
    control.mover_pinza(anchura_dedos=50, fuerza=20)
    control.mover_a_pose(home_pose)
    with open("/home/laboratorio/ros_workspace/src/gestos_robot_pkg/src/gestos_robot_pkg/robot/poses/home_position.yaml", "r") as f:
        home_joints = yaml.safe_load(f)
    control.mover_articulaciones(home_joints)'''
##############################################################################

####

    #pose_actual = control.articulaciones_actuales()
    #pose_actual.position.z -= 0.1
    # control.mover_a_pose(pose_actual)
    #control.mover_articulaciones([0,-pi_medios,-pi_medios,-pi_medios,pi_medios,0])
    '''
    # Mover el robot a una pose
    pose_actual = control.pose_actual()
    pose_actual.position.z -= 0.1
    control.mover_a_pose(pose_actual)
    
    # Mover el efector final del robot en línea recta a través de varias poses
    poses = [] # Lista de poses que va a recorrer
    
    # Pose 1
    pose_actual = control.pose_actual()
    pose_actual.position.z += 0.1
    poses.append(copy.deepcopy(pose_actual))
    
    # Pose 2
    pose_actual.position.y += 0.1
    poses.append(copy.deepcopy(pose_actual))
    
    # Pose 3
    pose_actual.position.x += 0.1
    poses.append(copy.deepcopy(pose_actual))
    
    # Pose 4
    pose_actual.position.x -= 0.1
    pose_actual.position.y -= 0.1
    pose_actual.position.z -= 0.1
    poses.append(copy.deepcopy(pose_actual))
    
    control.mover_trayectoria(poses)
    '''