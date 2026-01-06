#!/bin/bash

# Build and push the Jenkins StackGen runner Docker image
# This image contains pre-installed StackGen CLI and Terraform

set -e

PROJECT_ID="leander-test-471809"
IMAGE_NAME="jenkins-stackgen-runner"
IMAGE_TAG="latest"
REGISTRY="gcr.io"
FULL_IMAGE_NAME="${REGISTRY}/${PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG}"

echo "Building Docker image: ${FULL_IMAGE_NAME}"

# Build the image
docker build -t ${FULL_IMAGE_NAME} -f Dockerfile .

echo "Image built successfully"

# Configure Docker to use gcloud as a credential helper
echo "Configuring Docker for GCR..."
gcloud auth configure-docker ${REGISTRY} --quiet

# Push the image
echo "Pushing image to GCR..."
docker push ${FULL_IMAGE_NAME}

echo "Image pushed successfully: ${FULL_IMAGE_NAME}"
echo ""
echo "Update jenkins-agent.yaml to use: ${FULL_IMAGE_NAME}"

