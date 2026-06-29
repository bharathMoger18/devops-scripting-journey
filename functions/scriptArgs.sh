#!/bin/bash

#=========================================================
# Script: scriptArgs.sh
# Author: Bharath
# Purpose: Understanding arguments for funtions
#=========================================================


## Validate required arguments

if [[ $# -lt 1 ]]; then
    echo "Error: No arguments provided..."
    echo "Usage: $0 <server_name> [threshold] [environment]"
    echo "Example: $0 k8s-master 80 production"
    exit 1
fi

## Capture arguments with defaults

SERVER=$1
THRESHOLD=${2:-80}
ENVIRONMENT=${3:-staging}

## Print what was recieved

echo "Script: $0"
echo "Args Count: $#"
echo "All args : $@"

echo "Server: $SERVER"
echo "Threshold: $THRESHOLD"
echo "Environment: $ENVIRONMENT"

## loop over all arguments recieved

echo "All Arguments recieved: "
count=1

for arg in "$@"; do
    echo "Arg $count: $arg"
    count=$(( count + 1 ))
done