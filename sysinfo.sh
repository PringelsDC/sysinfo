#!/bin/bash

# Function to get CPU usage
get_cpu_usage() {
    mpstat_output=$(mpstat 1 1)
    if [[ $? -eq 0 ]]; then
        echo "$mpstat_output" | awk '/all/ { printf("%.2f%%\n", 100 - $NF) }'
    else
        echo "N/A"
    fi
}
# Function to get CPU temperature
get_cpu_temp() {
    sensors_output=$(sensors)
    if [[ $? -eq 0 ]]; then
        echo "$sensors_output" | awk '/Package id 0:/ { printf("%.1f°C\n", $4) }'
    else
        echo "N/A"
    fi
}

# Function to get RAM usage
get_ram_usage() {
    free_output=$(free -m)
    if [[ $? -eq 0 ]]; then
        echo "$free_output" | awk 'NR==2{printf "%.2f%% (%sMB/%sMB)\n", $3*100/$2, $3, $2}'
    else
        echo "N/A"
    fi
}

# Function to get disk usage
get_disk_usage() {
    df_output=$(df -h /)
    if [[ $? -eq 0 ]]; then
        echo "$df_output" | awk 'NR==2{printf "%.2f%% (%s/%s)\n", $5, $3, $2}'
    else
        echo "N/A"
    fi
}

# Check if required commands are available
for cmd in mpstat sensors free df; do
    if ! command -v $cmd &> /dev/null; then
        echo "$cmd is required but it's not installed. Aborting."
        exit 1
    fi
done

echo "System Information:"
echo "-------------------"
echo "CPU Usage: $(get_cpu_usage)"
echo "CPU Temp: $(get_cpu_temp)"
echo "RAM Usage: $(get_ram_usage)"
echo "Disk Usage: $(get_disk_usage)"
