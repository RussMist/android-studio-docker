#!/usr/bin/env bash
# X11 display path
export DISPLAY="host.docker.internal:0.0"

# supporting adb device via TCP with device ip and port 5555
# ANDROID_SDK_HOME - path for android sdk, should be defined by environment vars
$ANDROID_SDK_HOME/platform-tools/adb tcpip 5555

# uncomment this line for first launch.
# docker build -t androiid_studio_image .

docker run -it --net=host --env="DISPLAY" \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v "$HOME/.Xauthority:/root/.Xauthority:rw" \
  androiid_studio_image \
  /opt/android-studio/bin/studio.sh