#!/bin/bash
# ─────────────────────────────────────────────────────────
# Script : functions.sh
# Author : bharath
# Purpose: Functions — reusable DevOps tools
# ─────────────────────────────────────────────────────────

# ════════════════════════════════
# FUNCTION 1: Print a section header
# Arguments: $1 = title text
# ════════════════════════════════
print_header() {
  local title="$1"
  echo "════════════════════════════════════"
  echo " $title"
  echo "════════════════════════════════════"
}

# ════════════════════════════════
# FUNCTION 2: Check if a node is reachable
# Arguments: $1 = node name, $2 = IP address
# Returns : 0 = reachable, 1 = unreachable (exit codes)
# ════════════════════════════════
check_node() {
  local name="$1" # first argument
  local ip="$2" # second argument

  if ping -c 1 -W 2 "$ip" &>/dev/null; then
    echo " ✅ ONLINE : $name ($ip)"
    return 0 # success
  else
    echo " 🚨 OFFLINE : $name ($ip)"
    return 1 # failure
  fi
}

# ════════════════════════════════
# FUNCTION 3: Get disk usage as a number
# Arguments: $1 = mount point (default: /)
# Output : prints the usage percentage (capture with $())
# ════════════════════════════════
get_disk_pct() {
  local mount="${1:-/}" # default to / if no arg given
   # ${var:-default} = use default if var empty
  df "$mount" | awk 'NR==2{print $5}' | tr -d '%'
  # echo not needed — awk already prints the value
}

# ════════════════════════════════
# FUNCTION 4: Check disk and alert
# Arguments: $1 = server name, $2 = warn%, $3 = crit%
# ════════════════════════════════
check_disk() {
  local server="$1"
  local warn="${2:-70}" # default warn = 70%
  local crit="${3:-85}" # default crit = 85%
  local disk=$(get_disk_pct) # call another function!

  if [[ $disk -ge $crit ]]; then
    echo " 🚨 CRITICAL: $server disk at ${disk}% (>=${crit}%)"
  elif [[ $disk -ge $warn ]]; then
    echo " ⚠️ WARNING : $server disk at ${disk}% (>=${warn}%)"
  else
    echo " ✅ OK : $server disk at ${disk}%"
  fi
}

# ════════════════════════════════
# FUNCTION 5: Check Docker container status
# Arguments: $1 = container name
# ════════════════════════════════
check_container() {
  local name="$1"
  local status=$(docker inspect --format '{{.State.Status}}' "$name" 2>/dev/null)

  if [[ -z "$status" ]]; then
    echo " ❓ NOT FOUND : $name"
    return 2
  fi

  case "$status" in
    "running") echo " ✅ RUNNING : $name"; return 0 ;;
    "restarting") echo " ⚠️ RESTARTING : $name"; return 1 ;;
    "exited") echo " 🚨 EXITED : $name"; return 1 ;;
    *) echo " ❓ UNKNOWN : $name ($status)"; return 2 ;;
  esac
}

# ════════════════════════════════
# MAIN — now call the functions
# ════════════════════════════════
print_header "K8s Node Connectivity Check"
check_node "k8s-master" "192.168.122.199"
check_node "k8s-worker1" "192.168.122.55"
check_node "k8s-worker2" "192.168.122.56"

print_header "Disk Usage — bharath@linux"
check_disk "bharath@linux" 70 85

print_header "Docker Container Status"
for c in campuscart-nginx campuscart-web campuscart_backend campuscart-db registry; do
  check_container "$c"
done