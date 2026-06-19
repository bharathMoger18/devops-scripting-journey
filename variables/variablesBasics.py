#!/usr/bin/env python3
# ----------------------------
# Script: variablesBasics.py
# Author: Bharath
# Purpose: Learn python variable - Devops Context
# --------------------------------

# string variables

engineer_name = "bharath"
server_name = 'k8s-master'
server_ip = '192.168.122.199'
log_dir = "/mnt/linux_projects/devops-scripts/logs"


# Number varibales

disk_threshold = 80
cpu_usage = 73.5
memory_total_gb = 16
worker_count = 2

# Boolean Variables
is_cluster_healthy = True
alert_sent = False


# Printing Variables

print(f"Engineer : {engineer_name}")
print(f"Server: {server_name} ({server_ip})")
print(f"Disk Alert : Above {disk_threshold}%")
print(f"CPU Now : {cpu_usage}%")
print(f"RAM Total : {memory_total_gb}GB")
print(f"Workers : {worker_count} nodes")
print(f"Cluster OK : {is_cluster_healthy}")

# ── CHECKING TYPES ──
print(f"\nVariable Types:")
print(f"engineer_name → {type(engineer_name)}")
print(f"disk_threshold → {type(disk_threshold)}")
print(f"cpu_usage → {type(cpu_usage)}")
print(f"is_healthy → {type(is_cluster_healthy)}")