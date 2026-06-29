#!/usr/bin/env python3

#============================================
# Script: functions.py
# Author: Bharath
# Purpose: Understanding functions in python
#=============================================

import subprocess
import os
from datetime import datetime

## Function 1: Print a section header

def print_header(title, width=44):
    """Print a formatted section header"""
    line = "=" * width
    print(line)
    print(f" {title}")
    print(line)


### Function 2: Check if a node is reachable
## Returns: True if online , False if offline

def check_node(name, ip, timeout=2):
    """Ping a k8s-node, return True if reachable"""
    result = subprocess.run(
        ["ping", "-c", "1", "-W", str(timeout), ip], 
        stdout=subprocess.DEVNULL, 
        stderr=subprocess.DEVNULL
    )
    online = result.returncode == 0
    if online:
        print(f"Online: {name}({ip})")
    else:
        print(f"Offline: {name}({ip})")

    return online

# ════════════════════════════════
# FUNCTION 3: Get disk usage percentage
# Returns: integer percentage
# ════════════════════════════════
def get_disk_pct(mount="/"):
    """Get disk usage % for a mount point. Default: /"""
    try:
        out = subprocess.check_output(["df", mount]).decode().split()
        return int(out[11].replace("%", ""))
    except:
        return 0

# ════════════════════════════════
# FUNCTION 4: Check disk and alert
# Returns: "ok" / "warning" / "critical"
# ════════════════════════════════
def check_disk(server, warn=70, crit=85, mount="/"):
    """Check disk usage and return status string."""
    disk = get_disk_pct(mount) # call another function

    if disk >= crit:
        print(f" 🚨 CRITICAL : {server} disk at {disk}% (>={crit}%)")
        return "critical" # returns actual string!
    elif disk >= warn:
        print(f" ⚠️ WARNING : {server} disk at {disk}% (>={warn}%)")
        return "warning"
    else:
        print(f" ✅ OK : {server} disk at {disk}%")
        return "ok"

# ════════════════════════════════
# FUNCTION 5: Check Docker container
# Returns: status string
# ════════════════════════════════
def check_container(name):
    """Check Docker container status. Returns status string."""
    try:
        status = subprocess.check_output(
            ["docker", "inspect", "--format", "{{.State.Status}}", name],
            stderr=subprocess.DEVNULL
        ).decode().strip()
    except:
        status = "not_found"

    match status:
        case "running": print(f" ✅ RUNNING : {name}")
        case "restarting": print(f" ⚠️ RESTARTING : {name}")
        case "exited": print(f" 🚨 EXITED : {name}")
        case "not_found": print(f" ❓ NOT FOUND : {name}")
        case _: print(f" ❓ UNKNOWN : {name} ({status})")
    return status

# ════════════════════════════════
# MAIN — call functions
# ════════════════════════════════
print_header("K8s Node Connectivity")
check_node("k8s-master", "192.168.122.199")
check_node("k8s-worker1", "192.168.122.55")
check_node("k8s-worker2", "192.168.122.56")

print_header("Disk Usage")
disk_status = check_disk("bharath@linux", warn=70, crit=85)
print(f" Returned status: {disk_status}") # "ok", "warning", or "critical"

print_header("Docker Containers")
containers = ["campuscart-nginx", "campuscart-web", "campuscart_backend", "registry"]
for c in containers:
    check_container(c)