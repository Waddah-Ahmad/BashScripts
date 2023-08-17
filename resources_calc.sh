#!/bin/bash

# Get CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# Get memory usage
memory_info=$(free -m | grep Mem)
total_memory=$(echo $memory_info | awk '{print $2}')
used_memory=$(echo $memory_info | awk '{print $3}')
memory_percentage=$(echo "scale=2; $used_memory / $total_memory * 100" | bc)

# Get disk usage
disk_info=$(df -h /)
total_disk=$(echo $disk_info | awk '{print $2}')
used_disk=$(echo $disk_info | awk '{print $3}')
disk_percentage=$(echo $disk_info | awk '{print $5}')

echo "CPU Usage: ${cpu_usage}%"
echo "Memory Usage: ${memory_percentage}% (${used_memory}MB used out of ${total_memory}MB)"
echo "Disk Usage: ${disk_percentage} used out of ${total_disk}"