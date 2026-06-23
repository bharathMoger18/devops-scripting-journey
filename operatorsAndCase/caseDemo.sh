#!/bin/bash

#========================================
# Script: caseDemo.sh
# Author: Bharath
# Purpose: case statement - docker container status handler
#===========================================================

CONTAINERS=("campuscart-nginx" "campuscart-web" "campuscart-db" "campuscart_backend" "registry")

echo "================================================"
echo "Docker container status - campuscart project"
echo "================================================"


for container in "${CONTAINERS[@]}"; do
    #status
    status=$(docker inspect --format '{{.State.Status}}' $container 2> /dev/null)

    case "$status" in
     
      "running")
        echo "RUNNING: $container"
        ;;

      "restarting")
        echo "RESTARTING: $container - crash looping!"
        echo "docker start $container"
        ;;
      "paused")
        echo "PAUSED: $container - is this intentional?"
        echo "docker unpause $container"
        ;;

      "created")
        echo "CREATED: $container - never started"
        echo "docker start $container"
        ;;

      "")
        echo "NOT FOUND: $container"
        ;;

      *)
        echo "UNKNOWN: $container -> status='$status'"
        ;;

    esac
done

echo "================================="