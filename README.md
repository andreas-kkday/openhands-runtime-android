OpenHands V1 Architecture uses ghcr.io/openhands/agent-server as sandbox runtime.

# Split your custom image into repository and tag definitions
export AGENT_SERVER_IMAGE_REPOSITORY="your-registry/your-custom-sandbox"
export AGENT_SERVER_IMAGE_TAG="latest"
export WORKSPACE_MOUNT_PATH="$PWD"

openhands serve

