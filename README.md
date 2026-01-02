# system-stats
https://github.com/klkkristof/system-stats

A lightweight Bash script to check CPU, RAM, disk, and top processes on any Linux server.


## Features


- Total CPU usage (w 1 second snapshot)
- Memory usage
- Disk usage (for root filesystem)
- Top 5 processes by CPU and memory
- No dependencies


## Usage


curl -L -O https://raw.githubusercontent.com/klkkristof/system-stats/main/server-stats.sh

chmod +x server-stats.sh

./server-stats.sh


## Expected output


##############--STATS--###############

CPU: 12.3% used

RAM: 8273MB / 15924MB (52.0% used)

Disk: 23G/50G (46% used) on /


##############--TOP PROCESSES--###############

By CPU:

  PID USER     %CPU %MEM COMMAND
  
 1234 user    45.2  2.3 node
 
...

By Memory:

  PID USER     %MEM %CPU COMMAND
  
 5678 user     8.4 12.1 chrome
 
...

######################################
