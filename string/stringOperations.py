#!/usr/bin/env python3
#-----------------------------------------
# Script: stringOperations.py
# Author: Bharath
# Purpose: Python String Operations - Real Devops use
#-------------------------------------------------------

## Data

server = "k8s-master"
server_ip = "192.168.122.199"
image = "192.168.122.1:5000/campuscart-web:v1.0.0"
log_line = " 2026-06-17 ERROR k8s-master pod campuscart-backend crashlooped "
containers = "campuscart-nginx,campuscart-web,campuscart-db,registry"

print("==================================")
print("Python String Operations - Devops")
print("====================================")

# Basic operations
print("[1] Basic String Info")
print(f"Server name: {server}")
print(f"Length: {len(server)} characters")
print(f"Uppercase: {server.upper()}")
print(f"Lowercase: {server.lower()}")


# Slicing : extracting parts of the string

print("Slicing : extract parts")
date_str = "2026-06-26"
print(f"Full Date: {date_str}")
print(f"Year only: {date_str[:4]}")
print(f"Month only: {date_str[5:7]}")
print(f"Day only: {date_str[8:]}")

# Split: parse IP adress into parts
print("[3] Split - Parse IP Address")
ip_parts = server_ip.split(".")
print(f"Full IP: {server_ip}")
print(f"Parts: {ip_parts}")
print(f"Last Octet: {ip_parts[-1]}")
print(f"Network: {ip_parts[0]}.{ip_parts[1]}.{ip_parts[2]}.x")

## Replace - Generate worker from master
print("[4] Replace - Generate worker names")
print(f"Master: {server}")
print(f"worker1: {server.replace('master', 'worker1')}")
print(f"Wroker2: {server.replace('master','worker2')}")


## Strip : Clean Log lines
print("[5] Strip - Clean Log Lines")
print(f"Raw log: {log_line}")
clean_log = log_line.strip()
print(f"clean log: {clean_log}")

# 6. SPLIT + FILTER — find campuscart containers
print("\n[6] Real DevOps — Filter Project Containers")
all_containers = containers.split(",")
print(f" All containers : {all_containers}")
project_containers = [c for c in all_containers if c.startswith("campuscart")]
print(f" CampusCart : {project_containers}")

# 7. PARSE IMAGE TAG — extract version from Docker image
print("\n[7] Parse Docker Image Tag")
print(f" Full image : {image}")
tag = image.split(":")[-1] # split by : → take last part
image_name = image.split("/")[-1].split(":")[0]
print(f" Image name : {image_name}")
print(f" Tag/Version : {tag}")

# 8. ERROR DETECTION in log
print("\n[8] Log Error Detection")
if "ERROR" in clean_log:
  print(f" ERROR detected!")
  print(f" Count : {clean_log.count('ERROR')} occurrence(s)")
  affected = "campuscart-backend" if "campuscart-backend" in clean_log else "unknown"
  print(f" Service : {affected}")