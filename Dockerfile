FROM ubuntu:19.10
LABEL maintainer="russmist@gmail.com"

RUN dpkg --add-architecture i386
RUN apt-get update -y && apt-get install -y --no-install-recommends apt-utils

# Download specific Android Studio bundle (all packages).
RUN apt-get install -y curl unzip

# Install Java jdk 8
RUN apt-get install -y openjdk-8-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

# Install prerequisites
RUN apt-get install -y libz1 libncurses5 libbz2-1.0:i386 libstdc++6 libbz2-1.0 lib32stdc++6 lib32z1

# Install X11
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y xorg

# Install android studio & sdk
RUN curl -L 'https://redirector.gvt1.com/edgedl/android/studio/ide-zips/4.0.0.13/android-studio-ide-193.6348893-linux.tar.gz' -o /tmp/studio.tar.gz && tar -xzf /tmp/studio.tar.gz -C /opt && rm /tmp/studio.tar.gz
RUN curl -L 'https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip' -o /tmp/android-sdk.zip && unzip -d /opt/android-sdk /tmp/android-sdk.zip && rm /tmp/android-sdk.zip
ENV ANDROID_STUDIO_PATH=/opt/android-studio
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH="${PATH}:${ANDROID_HOME}/tools/:${ANDROID_HOME}/platform-tools/"

# Install git
RUN apt-get install -y git

# Install other usefull utils
RUN apt-get install -y mc software-properties-common wget

# Install npm
RUN apt-get install -y npm

# Install VSCode
RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
RUN apt-get update && apt-get install -y code

# Install yandex direct downloader
RUN apt-get install -y python3-pip
RUN pip3 install wldhx.yadisk-direct
RUN echo "ya_download() { curl -L \$(yadisk-direct \$1) -o \$2; }" >> /root/.bashrc

# Clean up
RUN apt-get clean -y && apt-get purge -y

# Copy git helper script
COPY ./init_repo.sh /root/init_repo.sh