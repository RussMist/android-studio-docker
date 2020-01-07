FROM ubuntu:19.10
LABEL maintainer="russmist@gmail.com"

ENV NO_AT_BRIDGE 1

RUN dpkg --add-architecture i386
RUN apt-get update

# Download specific Android Studio bundle (all packages).
RUN apt-get install -y curl unzip

RUN curl 'https://dl.google.com/dl/android/studio/ide-zips/3.5.3.0/android-studio-ide-191.6010548-linux.tar.gz' > /tmp/studio.tar.gz && tar -xzf /tmp/studio.tar.gz -C /opt && rm /tmp/studio.tar.gz

# Install X11
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y xorg

# Install other useful tools
RUN apt-get install -y vim ant

# install Java
RUN apt-get install -y default-jdk

# Install prerequisites
RUN apt-get install -y libz1 libncurses5 libbz2-1.0:i386 libstdc++6 libbz2-1.0 lib32stdc++6 lib32z1

# Install git
RUN apt-get install -y git

# Install adb
RUN apt-get install -y usbutils android-tools-adb

# Clean up
RUN apt-get clean
RUN apt-get purge

