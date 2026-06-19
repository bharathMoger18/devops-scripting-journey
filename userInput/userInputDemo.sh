#!/bin/bash
#-------------------------------
# Script: userInputDemo.sh
# Learns: read command, user input, variables
#--------------------------------

echo "============================================="
echo " Devops Server Check Tool "
echo "============================================="

# Ask user for input

read -p "Enter your name: " engineer
read -p "Enter server to check: " server
read -p "Enter server IP: " ip
read -p "Enter Disk Threshold %: " threshold

# Show summary
echo 
echo "====================================="
echo "Summary"
echo "====================================="
echo "Engineer: $engineer"
echo "Server: $server ($ip)"
echo "Alert at : ${threshold}% disk usage"
echo "====================================="
echo "Script by: $engineer - $(date)"