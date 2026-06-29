#!/usr/bin/env python3
# Usage: python3 scriptArgs.py <server> [threshold] [env]
# Example: python3 scriptArgs.py k8s-master 80 production

import sys

# ── Validate required arguments ──
if len(sys.argv) < 2: # len includes script name, so <2 means no args
    print(f"❌ Error: No arguments provided")
    print(f" Usage: {sys.argv[0]} <server> [threshold] [env]")
    print(f" Example: {sys.argv[0]} k8s-master 80 production")
    sys.exit(1) # exit with error code

# ── Capture arguments with defaults ──
server = sys.argv[1]
threshold = int(sys.argv[2]) if len(sys.argv) > 2 else 80
env = sys.argv[3] if len(sys.argv) > 3 else "staging"

print(f"Script : {sys.argv[0]}")
print(f"Args count: {len(sys.argv) - 1}") # -1 to exclude script name
print(f"All args : {sys.argv[1:]}") # slice off script name
print("─" * 26)
print(f"Server : {server}")
print(f"Threshold : {threshold}%")
print(f"Env : {env}")

# ── Loop over all arguments ──
print("\nAll arguments received:")
for idx, arg in enumerate(sys.argv[1:], start=1):
    print(f" Arg {idx}: {arg}")