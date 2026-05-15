# Use the official OpenHands runtime as the base
FROM ghcr.io/all-hands-ai/runtime:latest-nikolaik

USER root

# 1. Install Java (OpenJDK 17 is standard for modern Android)
RUN apt update && apt install -y wget apt-transport-https gnupg wget unzip
RUN wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
RUN echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list

RUN apt update && apt install -y temurin-17-jdk

# 2. Set up Android SDK paths
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools
# 3. Download Android Command Line Tools
RUN mkdir -p $ANDROID_HOME/cmdline-tools && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-14742923_latest.zip -O /tmp/tools.zip && \
    unzip /tmp/tools.zip -d $ANDROID_HOME/cmdline-tools && \
    mv $ANDROID_HOME/cmdline-tools/cmdline-tools $ANDROID_HOME/cmdline-tools/latest && \
    rm /tmp/tools.zip

# 4. Accept licenses and install platform tools
RUN yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" "platforms;android-36" "build-tools;36.0.0"
