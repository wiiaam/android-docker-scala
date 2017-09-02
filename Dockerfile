FROM ubuntu:16.04

# Set env variables
ENV ANDROID_NDK_HOME /opt/android-ndk
ENV ANDROID_HOME /opt/android-sdk
ENV PATH ${PATH}:${ANDROID_NDK_HOME}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}

# Install deps
RUN apt-get update >/dev/null
RUN apt-get -y install wget unzip openjdk-8-jdk apt-transport-https >/dev/null

# install sbt
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
RUN apt-get update && apt-get install -y sbt >/dev/null

# Set ndk version
ENV ANDROID_NDK_VERSION r15c

# Download ndk to /opt/android-ndk
RUN wget -q https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip -O /opt/android-ndk.zip && \
  unzip -q /opt/android-ndk.zip -d /opt && \
  mv /opt/android-ndk-${ANDROID_NDK_VERSION} /opt/android-ndk
  
# Download sdk to /opt/android-sdk
RUN wget -q https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip -O /opt/android-sdk.zip && \
  unzip -q /opt/android-sdk.zip -d /opt && \
  mkdir /opt/android-sdk && \
  mv /opt/tools /opt/android-sdk/tools
  
# install sdk stuff
RUN echo y | sdkmanager "platform-tools" "build-tools;26.0.1" "platforms;android-25" "extras;android;m2repository"
  


