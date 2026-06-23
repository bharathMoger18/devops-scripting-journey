#!/bin/bash

#===========================================
# FORM 1: Loop over a list of values
#============================================

for color in red green blue yellow; do
    echo "Color: $color"
done


#===============================================
# Form 2: Loop over an array ( list stored in variable)
#===========================================================

NODES=("k8s-master" "k8s-worker1" "k8s-worker2")

for node in "${NODES[@]}"; do
    echo "Node: $node"
done


#============================================
# Form 3: Loop over a number range
#============================================

for i in {1..5}; do
    echo "Attempt $i of 5"
done


#=================================================
# Form 4: C-style for loop
# for ((init; condition; increment))
#===================================================

for (( i=1; i<=5; i++)); do
    echo "i = $i"
done


#=========================================================
# Form 5: Loop over command output
#=========================================================

FILES=$(ls ~/devopsScripting/)
for file in $FILES; do
    echo "Found: $file"
done


