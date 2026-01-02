#!/usr/bin/env bash

# -- CPU STATS (FROM /proc/stat, 1 sec sample)
read _ user nice system idle iowait irq softirq steal guest < /proc/stat
prev_idle=$((idle + iowait))
prev_total=$((user + nice + system + idle + iowait + irq + softirq + steal))

sleep 1

read _ user nice system idle iowait irq softirq steal guest < /proc/stat
idle2=$((idle + iowait))
total2=$((user + nice + system + idle + iowait + irq + softirq + steal))

diff_idle=$((idle2 - prev_idle))
diff_total=$((total2 - prev_total))

cpu_usage=$(awk "BEGIN {printf \"%.1f\", (1 - $diff_idle / $diff_total) * 100}")
echo "##############--STATS--###############"
echo
echo "CPU: $cpu_usage% used"

# -- Memory

read _ total used free _ < <(free -m | awk '/^Mem:/ {print $2, $3, $4, $7}')
mem_used_percent=$(awk  "BEGIN {printf \"%.1f\", ($used / $total) * 100}")
echo "RAM: ${used}MB / ${total}MB (${mem_used_percent}% used)"

# -- Disk usage

read _ size used avail usep mount < <(df -h / | awk 'NR==2 {print $1,$2,$3,$4,$5,$6}')
echo "Disk: ${used}/${size} (${usep} used) on ${mount}"

echo

# -- Top processes
echo "##############--TOP PROCESSES--###############"

echo

echo "By CPU:"
ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -6
echo

echo "By Memory:"
ps -eo pid,user,%cpu,%mem,comm --sort=-%mem | head -6
echo

echo "######################################"