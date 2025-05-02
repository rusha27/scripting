#!/bin/bash

echo "Server Performance Statistics"
echo

# Stretch: OS Version
echo ">> OS Version:"
cat /etc/os-release | grep -E '^(NAME|VERSION)='
echo

# Stretch: Uptime and Load Average
echo ">> Uptime and Load Average:"
uptime
echo

# Stretch: Logged In Users
echo ">> Logged in Users:"
who
echo

# Stretch: Failed Login Attempts (last 10)
echo ">> Last 10 Failed Login Attempts:"
lastb -n 10 2>/dev/null || echo "Command 'lastb' requires root privileges or may not be available."
echo

# CPU Usage
echo ">> Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "Used: " 100 - $8 "%", "Idle: " $8 "%"}'
echo

# Memory Usage
echo ">> Memory Usage:"
free -h | awk '/^Mem:/ {print "Total: " $2 ", Used: " $3 ", Free: " $4}'
used=$(free | awk '/^Mem:/ {print $3}')
total=$(free | awk '/^Mem:/ {print $2}')
percent=$(awk "BEGIN {printf \"%.2f\", ($used/$total)*100}")
echo "Memory Usage: $percent%"
echo

# Disk Usage
echo ">> Disk Usage:"
df -h --total | grep 'total' | awk '{print "Total: " $2 ", Used: " $3 ", Free: " $4 ", Usage: " $5}'
echo

# Top 5 Processes by CPU usage
echo ">> Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo

# Top 5 Processes by Memory usage
echo ">> Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo

echo "End of Report"
