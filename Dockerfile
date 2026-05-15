# Use the official OpenHands runtime as the base
FROM ghcr.io/openhands/agent-server:016c060-eclipse-temurin_tag_17-jdk

USER root

ARG DEBIAN_FRONTEND=noninteractive

# 1. Install Java (OpenJDK 17 is standard for modern Android)
RUN apt update && apt install -y wget apt-transport-https gnupg unzip

# 2. Set up Android SDK paths
RUN apt install -y adb android-sdk-platform-tools sdkmanager

# 4. Accept licenses and install platform tools
RUN yes "" | sdkmanager --licenses && \
    sdkmanager "platforms;android-36.1" "build-tools;36.1.0"
