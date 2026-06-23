#!/bin/bash

#-------------------------------------------
# Script: variablesBasics.sh
# Author: Bharath
# Purpose: Learn variables - Devops Context


# CONFIG VARIABLES
DISK_THRESHOLD=80
SERVER_NAME="k8s-master"
SERVER_IP="192.168.122.199"
LOG_DIR="/mnt/linux-projects/devops-scripts/logs"


# LOCAL VARIABLES

engineer_name='bharath'
# today='Fridcay'


# using varibales
echo "Engineer: $engineer_name"
echo "Server: $SERVER_NAME ($SERVER_IP)"
echo "Threshold: ${DISK_THRESHOLD}%"
echo "Log Dir: $LOG_DIR"