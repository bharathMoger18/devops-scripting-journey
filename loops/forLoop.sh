#!/bin/bash

#===================================================
# Script: foorLoop.sh
# Author: Bharath
# Purpose: for loops - check all k8s nodes and containers
# System: bharath@linux - KVM cluster + Docker
#===========================================================

K8S_NODES=(
    "k8s-master:192.168.122.199"
    "k8s-worker1:192.168.122.55"
    "k8s-worker2:192.168.122.56"
)

CAMPUSCART_CONTAINERS=(
  "campuscart-nginx"
  "campuscart-web"
  "campuscart-db"
  "campuscart_backend"
  "campuscart-redis"
  "registry"
)

TIMESTAMP=$(date "+%Y-%m-d %H:%M:%S")
PASS=0
FAIL=0

echo "====================================="
echo "Full Infrastructure Check - $TIMESTAMP"
echo "======================================="

#Loop 1: Check all k8s nodes

for node in "${K8S_NODES[@]}"; do
    # split "name:ip" into two seperate variable
    # IFS = Internal Field Seperator -  tells bash to split on :
    name=$(echo "$node" | cut -d: -f1)
    ip=$(echo "$node" | cut -d: -f2)

    # Ping the node, if it responds, it's up

    if ping -c 1 -W 2 "$ip" &>/dev/null; then
        echo "Online: $name ($ip)"
        PASS=$(( PASS + 1 ))
    else
        echo "Offline: $name ($ip) - run : virsh start $ip"
        FAIL=$(( FAIL + 1 ))
    fi
done


# Loop 2: Check all docker containers

for container in "${CAMPUSCART_CONTAINERS[@]}"; do
    status=$(docker inspect "$container" --format '{{.State.Status}}' 2>/dev/null)
    
    if [[ "$status" == "running" ]]; then
        echo "Running: $container"
        PASS=$(( PASS + 1 ))
    elif [[ "$status" == "restarting" ]]; then
        echo "Restarting: $container"
        FAIL=$(( FAIL + 1 ))
    elif [[ -z "$status" ]]; then
        echo "Not Found: $container"
    else
        echo "Problem: $container: $status"
        FAIL=$(( FAIL + 1 ))
    fi
done


# Loop 3: Loop over a range - retry example

for attempt in {1..3}; do
    echo "Attempting $attempt of 3.."
    if ping -c 1 -W 1 192.168.122.199 &>/dev/null; then
        echo "Connected on $attempt Attempt"
        break
    else
        echo "Failed, retrying..."
        sleep 1
    fi
done

# ── SUMMARY ──
echo "════════════════════════════════════════════════"
echo " Results: ✅ $PASS passed 🚨 $FAIL failed"
echo "════════════════════════════════════════════════"