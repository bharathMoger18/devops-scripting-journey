#!/bin/bash
#----------------------------
# Script: stringOps.sh
# Author: Bharath
# Purpose: String Operations - Real Devops Scenarios
#-----------------------------------------------------

# -- Server Names

SERVER="k8s-master"
# WORKER1="k8s-worker1"
IMAGE="192.168.122.1:5000/campuscart-web:v1.0.0"
LOG_LINE="2026-06-17 ERROR k8s-master pod campuscart-backend crashlooped"


echo "================================"
echo "Bash String Operation - Devops style"
echo "========================================"


# String Length
printf "\n[1] String Length"
echo "Server Name: $SERVER" 
echo "Length: ${#SERVER} characters"
echo "Image URL Length: ${#IMAGE} characters"

# Uppercase or Lowercase
printf "\n[2] Case Conversion"
echo "Original: $SERVER"
echo "Uppercase: ${SERVER^^}"
echo "Lowercase: ${SERVER,,}"


# Substring - Extract part of string

printf "\n[3] Substring extraction"
DATE_PART="2026-06-20"
echo "Full Date: $DATE_PART"
echo "Year only: ${DATE_PART:0:4}"
echo "Month only: ${DATE_PART:5:2}"
echo "Day only: ${DATE_PART:8:2}"


## Remove Prefix
printf "\n[4] Remove Prefix"
echo "Full Name: $SERVER"
echo "Without k8s- : ${SERVER#k8s-}"


## Replace - Generate worker names from master
printf "\n[5] String Replace"
echo "Master node : $SERVER"
WORKER_NAME="${SERVER/master/worker1}"
echo "Worker node : $WORKER_NAME"


## Build backup file name dynamically

printf "\n[6] Real Devops - Dynamic Filename Builder"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="backup-${SERVER,,}-${TIMESTAMP}.tar.gz"
echo "Backup file: $BACKUP_FILE"

## Check if the string contains a word
printf "\n[7] String Contains Check"
if [[ "$LOG_LINE" == *"ERROR"* ]]; then
  echo " Error found in log line..."
  echo "Log: $LOG_LINE"
fi