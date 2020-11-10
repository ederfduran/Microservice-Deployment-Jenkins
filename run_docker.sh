#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a x descriptive tag
docker build -t flaskapp .
# Step 2: 
# List docker images
docker image ls

# Step 3: 
# Run flask app
docker container run -it -p 8000:80 flaskapp

# show docker container running
#docker ps
