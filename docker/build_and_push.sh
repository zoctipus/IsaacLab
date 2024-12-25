#!/bin/bash

# build_and_push_isaaclab_base.sh
# -------------------------------
# This script builds and pushes the "octipus/isaac-lab-base:latest" Docker image
# using variables defined in .env.base.

# Exit immediately if a command exits with a non-zero status.
set -e

# 1. Locate the script directory and source environment variables from .env.base
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/.env.base"

echo "=================================================="
echo "Building Docker image 'octipus/isaac-lab-base:latest' with build arguments:"
echo "  ISAACSIM_BASE_IMAGE_ARG=${ISAACSIM_BASE_IMAGE}"
echo "  ISAACSIM_VERSION_ARG=${ISAACSIM_VERSION}"
echo "  ISAACSIM_ROOT_PATH_ARG=${DOCKER_ISAACSIM_ROOT_PATH}"
echo "  ISAACLAB_PATH_ARG=${DOCKER_ISAACLAB_PATH}"
echo "  DOCKER_USER_HOME_ARG=${DOCKER_USER_HOME}"
echo "=================================================="

# 2. Build the Docker image
docker build \
  --no-cache \
  -f docker/Dockerfile.base \
  -t octipus/isaac-lab-base:latest \
  --build-arg ISAACSIM_BASE_IMAGE_ARG="${ISAACSIM_BASE_IMAGE}" \
  --build-arg ISAACSIM_VERSION_ARG="${ISAACSIM_VERSION}" \
  --build-arg ISAACSIM_ROOT_PATH_ARG="${DOCKER_ISAACSIM_ROOT_PATH}" \
  --build-arg ISAACLAB_PATH_ARG="${DOCKER_ISAACLAB_PATH}" \
  --build-arg DOCKER_USER_HOME_ARG="${DOCKER_USER_HOME}" \
  .

echo "=================================================="
echo "Build completed successfully!"
echo "=================================================="

# 4. Push the image to Docker Hub
echo "=================================================="
echo "Pushing Docker image 'octipus/isaac-lab-base:latest' to Docker Hub..."
docker push octipus/isaac-lab-base:latest
echo "Push completed!"
echo "=================================================="
