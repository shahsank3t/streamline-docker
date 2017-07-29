#!/bin/bash

source ./.env

echo "Starting Dockerized Streamline Application"
docker-compose up -d

# echo "Bootstrapping services with desired data and configurations"
# STREAMLINE_CONTAINER_ID=$(docker ps | grep jdye64/streamline-demo:streamline | awk '{ print $1 }')
# docker exec -it $STREAMLINE_CONTAINER_ID /bootstrap.sh

# # TODO: Now run a script to populate the environment with some initial information.
# echo "Schema Registry running at public - http://localhost:9797 private - registry.dev:9797"
# echo "Streamline running at http://localhost:8888 private - streamline.dev:8888"
