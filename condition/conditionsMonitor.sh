#!/bin/bash

#-------------------------------------------
# Script: conditionsMonitor.sh
# Author: Bharath
# Purpose: system health check using if/elif/else
# System: bharath@linux - Dell Vostro, Ubuntu 22.04
#--------------------------------------------------

# -- Threshold : change these as needed

DISK_WARN=70
DISK_CRIT=85
MEM_WARN=70
MEM_CRIT=90
LOG_FILE="/home/bharath/devopsScripting/health.log"


# Get real system values

DISK_USE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

MEM_USE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2*100}')

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")



# HEADER
echo "======================================="
echo "System Health Check linux@bharath"
echo "Time: $TIMESTAMP"
echo "======================================="

# =====================
# CHECK 1: Disk Usage
#=======================

if [[ $DISK_USE -ge $DISK_CRIT ]]; then
  echo "Critical: Disk at ${DISK_USE}% - Immediate Action needed"
  echo "[$TIMESTAMP] CRITICAL disk=${DISK_USE}%" >> $LOG_FILE
elif [[ $DISK_USE -ge $DISK_WARN ]]; then
  echo "Warning: Disk at ${DISK_USE}% - Monitor Closely"
  echo "[$TIMESTAMP] WARNING disk-${DISK_USE}%" >> $LOG_FILE
else
  echo "OK: Disk at ${DISK_USE}% - All good"
fi


#======================
# CHECK 2: Memory Usage
#======================

echo "Memory Usage: ${MEM_USE}%"


if [[ $MEM_USE -ge $MEM_CRIT ]]; then
    echo "CRITICAL: Memory usage at ${MEM_USE}%"
    echo "[$TIMESTAMP] CRITICAL memory=${MEM_USE}%" >> $LOG_FILE
elif [[ $MEM_USE -ge $MEM_WARN ]]; then
    echo "WARNING: Memory at ${MEM_USE}%"
    echo "[$TIMESTAMP] WARNING memory=${MEM_USE}%" >> $LOG_FILE
else    
    echo "OK: Memory at ${MEM_USE}% - ALL Good "
fi


# ════════════════════════════════
# CHECK 3: DOCKER CONTAINER STATUS
# ════════════════════════════════
echo "Docker Container Check"

# Check your campuscart_backend — the one that was restarting!
CONTAINER="campuscart_backend"
STATUS=$(docker inspect --format '{{.State.Status}}' $CONTAINER 2>/dev/null)
# ↑ 2>/dev/null → suppress error if container doesn't exist

if [[ -z "$STATUS" ]]; then
  # -z means "string is empty" → container not found
  echo "NOT FOUND : $CONTAINER does not exist"
elif [[ "$STATUS" == "running" ]]; then
  echo "RUNNING : $CONTAINER is healthy"
elif [[ "$STATUS" == "restarting" ]]; then
  echo "RESTARTING: $CONTAINER is crash-looping!"
  echo " Run: docker logs $CONTAINER --tail 50"
elif [[ "$STATUS" == "exited" ]]; then
  echo "EXITED : $CONTAINER has stopped!"
else
  echo "UNKNOWN : $CONTAINER status = $STATUS"
fi

# ════════════════════════════════
# CHECK 4: K8S-MASTER SSH REACHABLE?
# ════════════════════════════════
echo "K8s Master Reachability"
K8S_MASTER="192.168.122.199"

if ping -c 1 -W 2 $K8S_MASTER &>/dev/null; then
# ping -c 1 → send 1 packet
# -W 2 → wait max 2 seconds
# &>/dev/null → hide all output (we only care if it succeeds)
# No [[ ]] here — we test the EXIT CODE of ping directly
  echo "REACHABLE : k8s-master ($K8S_MASTER) is online"
else
  echo "UNREACHABLE: k8s-master ($K8S_MASTER) is DOWN!"
  echo "Run: virsh start k8s-master"
fi

echo "════════════════════════════════════════════"
echo " Check complete. Time: $(date '+%H:%M:%S')"
echo "════════════════════════════════════════════"