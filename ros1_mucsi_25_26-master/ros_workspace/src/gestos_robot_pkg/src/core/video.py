# src/core/video.py
#Video.py editado para conectarse con ros
import cv2
import yaml
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import rospy
from copy import deepcopy
from numpy import ndarray
import threading
from typing import Optional

class Video:
    def __init__(self, topic_name, config_path: str, section: str = "camera", wait_timeout: Optional[float] = 5.0)->None:
        """
        topic_name: topic ROS a suscribir
        config_path: ruta a yaml
        section: nombre del bloque en el YAML (por defecto 'camera').
                 Para la camara del dado usaremos 'dice_camera'.
        wait_timeout: segundos para esperar el primer mensaje (None = esperar indefinidamente)
        """
        #Abrir el archivo yaml
        with open(config_path, "r", encoding="utf-8") as f:
            cfg = yaml.safe_load(f)

        #lee y define variables extraidas de yaml
        cam_cfg = cfg.get(section, {})
        self.index = cam_cfg.get("index", 0)
        self.width = cam_cfg.get("width", 640)
        self.height = cam_cfg.get("height", 480)
        self.fps = cam_cfg.get("fps", 30)

        self.bridge = CvBridge() #conversion entre ros y opencv
        self.frame = None 
        self._lock = threading.RLock()
         
        # Subscriber (queue_size para evitar backlog)
        #Suscriptor que llamara a img_callback cada vez que llegue un Image
        self._sub = rospy.Subscriber(topic_name, Image, self._img_callback, queue_size=1, buff_size=2**24)

        # Esperar el primer mensaje (opcional timeout)
        try:
            if wait_timeout is None:
                rospy.wait_for_message(topic_name, Image)
            else:
                rospy.wait_for_message(topic_name, Image, timeout=wait_timeout)
        except rospy.ROSException:
            rospy.logwarn("Video: timeout esperando primer mensaje en %s", topic_name)

    #convierte msg (Ros Image) a numpy (bgr) y lo guarda en self.frame
    def __img_callback(self, msg: Image) -> None:
        # Callback rápido: convierto y guardo con lock
        frame = self.bridge.imgmsg_to_cv2(msg, desired_encoding='bgr8')
        with self._lock:
            self._frame = frame
    
    #Devuelve deepcopy 
    def read(self) -> ndarray:
        return deepcopy(self.frame)

    #Muesta el frame 
    def show(self, winname: str, frame):
        cv2.imshow(winname, frame)

    #lee la tecla presionada 
    def key_pressed(self, delay: int = 1) -> int:
        return cv2.waitKey(delay) & 0xFF

    def release(self):
        if self.cap is not None and self.cap.isOpened():
            self.cap.release()
        cv2.destroyAllWindows()
