#!/bin/bash

#=============================================
# Script: whileLoop.sh
# Author: Bharath
# Purpose: while loops - real Devops monitoring patterns
#=========================================================

# Patten 1: counter based while 

count=1
while [[ count -le 5 ]]; do
    echo "Iteration: $count"
    count=$(( count + 1))
done

# Pattern 2: Wait untill server comes online 
TARGET_IP=192.168.122.199
MAX_WAIT=30
elapsed=0

echo "Waiting for k8s-master to come online..."
while ! ping -c 1 -W 1 "$TARGET_IP" &>/dev/null; do
    if [[ elapsed -ge "$MAX_WAIT" ]]; then
        echo "Timeout: k8s-master didn't come up in ${MAX_WAIT}s"
        brek
    fi
    echo "Still waiting...(${elapsed}s elapsed)"
    sleep 2
    elapsed=$(( elapsed + 2 ))
done
echo "k8s-master is online"


## Pattern 3: Read file line by line 
while IFS=, read -r name ip role; do
    echo "Node: $name | IP: $ip | Role: $role"
done < /tmp/servers.txt


## Pattern 4: Continuos monitor ( Ctrl + c to stop )
cycles=0
while [[ $cycles -lt 3 ]]; do # use 'while true' in production
  disk=$(df / | awk 'NR==2{print $5}' | tr -d '%')
  mem=$(free | awk '/Mem:/{printf "%.0f", $3/$2*100}')
  echo " [$(date '+%H:%M:%S')] Disk: ${disk}% Mem: ${mem}%"
  cycles=$(( cycles + 1 ))
  sleep 2
done