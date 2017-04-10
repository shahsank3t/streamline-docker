#!/bin/bash

# Sleep to give postgres time to startup
sleep 45
ambari-server start

while true; do
  sleep 3
  tail -f /var/log/ambari-server/ambari-server.log
done
