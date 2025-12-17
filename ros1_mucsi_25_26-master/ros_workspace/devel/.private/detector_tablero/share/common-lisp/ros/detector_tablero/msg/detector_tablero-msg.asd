
(cl:in-package :asdf)

(defsystem "detector_tablero-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :actionlib_msgs-msg
               :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "CasillasAction" :depends-on ("_package_CasillasAction"))
    (:file "_package_CasillasAction" :depends-on ("_package"))
    (:file "CasillasActionFeedback" :depends-on ("_package_CasillasActionFeedback"))
    (:file "_package_CasillasActionFeedback" :depends-on ("_package"))
    (:file "CasillasActionGoal" :depends-on ("_package_CasillasActionGoal"))
    (:file "_package_CasillasActionGoal" :depends-on ("_package"))
    (:file "CasillasActionResult" :depends-on ("_package_CasillasActionResult"))
    (:file "_package_CasillasActionResult" :depends-on ("_package"))
    (:file "CasillasFeedback" :depends-on ("_package_CasillasFeedback"))
    (:file "_package_CasillasFeedback" :depends-on ("_package"))
    (:file "CasillasGoal" :depends-on ("_package_CasillasGoal"))
    (:file "_package_CasillasGoal" :depends-on ("_package"))
    (:file "CasillasResult" :depends-on ("_package_CasillasResult"))
    (:file "_package_CasillasResult" :depends-on ("_package"))
    (:file "Cell" :depends-on ("_package_Cell"))
    (:file "_package_Cell" :depends-on ("_package"))
    (:file "Ficha" :depends-on ("_package_Ficha"))
    (:file "_package_Ficha" :depends-on ("_package"))
  ))