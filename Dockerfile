FROM ubuntu:16.04

# Set env variables
ENV ANDROID_NDK_HOME /opt/android-ndk
ENV PATH ${PATH}:${ANDROID_NDK_HOME}

# Install deps
RUN apt-get update && apt-get install wget unzip > /dev/null

# Set ndk version
ENV ANDROID_NDK_VERSION r15c

# Download ndk to /opt/android-ndk
RUN wget -q https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip -O /opt/android-ndk.zip && \
  unzip -q /opt/android-ndk.zip -d /opt && \
  mv /opt/android-ndk-${ANDROID_NDK_VERSION} /opt/android-ndk
  
# for tesing only
CMD ls /opt 

