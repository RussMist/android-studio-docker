#!/usr/bin/env bash
export DISPLAY="host.docker.internal:0.0"

# docker build -t androiid_studio_image .
docker run -it --net=host --env="DISPLAY" \
  --privileged -v /dev/bus/usb:/dev/bus/usb \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v "$HOME/.Xauthority:/root/.Xauthority:rw" \
  androiid_studio_image \
  /opt/android-studio/bin/studio.sh