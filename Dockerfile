FROM ubuntu:19.10
LABEL maintainer="russmist@gmail.com"

RUN dpkg --add-architecture i386
RUN apt-get update -y && apt-get install -y --no-install-recommends apt-utils

# Download specific Android Studio bundle (all packages).
RUN apt-get install -y curl unzip

# Install Java jdk 8
RUN apt-get install -y openjdk-8-jdk

# Install prerequisites
RUN apt-get install -y libz1 libncurses5 libbz2-1.0:i386 libstdc++6 libbz2-1.0 lib32stdc++6 lib32z1

# Install X11
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y xorg

RUN curl 'https://dl.google.com/dl/android/studio/ide-zips/3.6.0.19/android-studio-ide-192.6165589-linux.tar.gz' > /tmp/studio.tar.gz && tar -xzf /tmp/studio.tar.gz -C /opt && rm /tmp/studio.tar.gz
RUN curl 'https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip' > /tmp/android-sdk.zip && unzip -d /opt/android-sdk /tmp/android-sdk.zip && rm /tmp/android-sdk.zip
ENV ANDROID_STUDIO_PATH=/opt/android-studio
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH="${PATH}:${ANDROID_HOME}/tools/:${ANDROID_HOME}/platform-tools/"

# Install git
RUN apt-get install -y git

# Install other usefull utils
RUN apt-get install -y mc
RUN apt-get install -y software-properties-common
RUN apt-get install -y wget

# Instal opera browser
RUN wget -qO- https://deb.opera.com/archive.key | apt-key add -
RUN add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"
RUN apt install -y opera-stable

# Clean up
RUN apt-get clean -y
RUN apt-get purge -y

