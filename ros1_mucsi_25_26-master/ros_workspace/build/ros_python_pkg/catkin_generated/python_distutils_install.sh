#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/laboratorio/ros_workspace/src/ros_python_pkg-main"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/laboratorio/ros_workspace/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/laboratorio/ros_workspace/install/lib/python3/dist-packages:/home/laboratorio/ros_workspace/build/ros_python_pkg/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/laboratorio/ros_workspace/build/ros_python_pkg" \
    "/usr/bin/python3" \
    "/home/laboratorio/ros_workspace/src/ros_python_pkg-main/setup.py" \
     \
    build --build-base "/home/laboratorio/ros_workspace/build/ros_python_pkg" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/laboratorio/ros_workspace/install" --install-scripts="/home/laboratorio/ros_workspace/install/bin"
