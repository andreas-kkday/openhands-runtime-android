# Use the official OpenHands runtime as the base
FROM ghcr.io/openhands/agent-server:latest

USER root

ARG DEBIAN_FRONTEND=noninteractive

# 1. Install Java (OpenJDK 17 is standard for modern Android)
RUN apt update && apt install -y wget apt-transport-https gnupg unzip

# Add Adoptium GPG key and repository
RUN wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
RUN echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list

RUN apt update && apt install -y temurin-17-jdk


# 2. Set up Android SDK paths
RUN apt install -y adb android-sdk-platform-tools sdkmanager

# 4. Accept licenses and install platform tools
RUN yes "" | sdkmanager --licenses && \
    sdkmanager "platforms;android-36.1" "build-tools;36.1.0"
