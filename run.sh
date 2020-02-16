#!/usr/bin/env bash

# X11 display path
export DISPLAY="host.docker.internal:0.0"

# Adb device port
export DEVICE_PORT=5555

# prevent more than one adb connection via usb
$ANDROID_SDK_HOME/platform-tools/adb disconnect

# get device wifi ip
DEVICE_IP=$($ANDROID_SDK_HOME/platform-tools/adb shell ip addr show wlan0 | grep "inet\s" | awk '{print $2}' | awk -F'/' '{print $1}')
export DEVICE_ADDRESS=$DEVICE_IP:$DEVICE_PORT

# supporting adb device via TCP with device ip and port that defines at $DEVICE_PORT
# ANDROID_SDK_HOME - path for android sdk, should be defined by environment vars
$ANDROID_SDK_HOME/platform-tools/adb tcpip $DEVICE_PORT

# comment this line if image was builded (non first launch).
docker build -t android_studio_image .

# after android studio will be configured and all sdk will be installed, You should connect to device via $ANDROID_HOME/platform-tools/adb connect $DEVICE_ADDRESS
# where $ANDROID_HOME - is actual android sdk path in docker container
docker run -it --net=host --env="DISPLAY" --env="DEVICE_ADDRESS"\
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v "$HOME/.Xauthority:/root/.Xauthority:rw" \
  android_studio_image \
  /bin/bash -c "echo y | /opt/android-sdk/tools/bin/sdkmanager 'tools' 'platform-tools' 'platforms;android-29' 'build-tools;29.0.3' 'sources;android-29' && \
  /opt/android-sdk/platform-tools/adb connect $DEVICE_ADDRESS && \
  /opt/android-studio/bin/studio.sh"