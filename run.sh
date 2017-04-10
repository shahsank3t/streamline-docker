#!/bin/bash

source ./.env

echo "Starting Streamline Demo"
docker-compose up -d

echo "Sleeping 3 minutes to give Ambari-server time to boot up...."
sleep 180
echo "Posting Ambari blueprint for Streamline environment to Ambari-server"
curl --user admin:admin -H 'X-Requested-By:admin' -X POST $AMBARI_HOST/api/v1/blueprints/streamline-container --data-binary "@examples/blueprints/StreamingAnalyticsManager.json"
curl --user admin:admin -H 'X-Requested-By:admin' -X PUT $AMBARI_HOST/api/v1/stacks/HDP/versions/$HDP_VERSION/operating_systems/$OS/repositories/HDP-${HDP_VERSION} -d '{"Repositories":{"base_url":"'$BASE_URL'", "verify_base_url":true}}'
curl --user admin:admin -H 'X-Requested-By:admin' -X POST $AMBARI_HOST/api/v1/clusters/dev --data-binary "@examples/hostgroups/streamline-container.json"
echo "Ambari server is now setting up the desired resources. Sleeping until services are online ...."

echo "All blueprint services are now running."

echo "Bootstrapping services with desired data and configurations"
STREAMLINE_CONTAINER_ID=$(docker ps | grep jdye64/streamline-demo:streamline | awk '{ print $1 }')
docker exec -it $STREAMLINE_CONTAINER_ID /bootstrap.sh

# TODO: Now run a script to populate the environment with some initial information.
echo "Schema Registry running at public - http://localhost:9797 private - registry.dev:9797"
echo "Streamline running at http://localhost:8888 private - streamline.dev:8888"
