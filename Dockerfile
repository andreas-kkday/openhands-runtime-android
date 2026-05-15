# Use the official OpenHands runtime as the base
FROM ghcr.io/all-hands-ai/runtime:latest-nikolaik

USER root

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y android-sdk-platform-tools adb
