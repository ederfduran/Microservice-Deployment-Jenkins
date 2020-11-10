#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
dockerpath=ederd/flaskapp

# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker login --username ederd
docker tag flaskapp $dockerpath:v0.0.1

# Step 3:
# Push image to a docker repository
docker push $dockerpath:v0.0.1

