#!/usr/bin/env python3
#----------------------------------
# Script: userInputDemo.py
# Learns: input(), type-conversion, f-string"
#----------------------------------------------

print("=================================")
print("Devops server check tool")
print("=================================")


# Ask user for input 

engineer = input("Enter your name: ")
server = input("Enter server to check: ")
ip = input("Enter server IP: ")
threshold = int(input("Enter disk threshold: "))

# calculate warning level
warning_level = threshold - 10


# Show summary
print()
print("_________________________________")
print("Summary")
print("__________________________________")
print(f"Engineer: {engineer}")
print(f"Server: {server} ({ip})")
print(f"Alert at : {threshold}% disk usage")
print(f"Warning at : {warning_level}% disk usage")
print("───────────────────────────────────")