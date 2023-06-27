#!/bin/bash

# Function to calculate average waiting time
calculate_average_waiting_time() {
    local -n burst_times=$1
    local -n waiting_times=$2

    local n=${#burst_times[@]}
    local total_waiting_time=0

    waiting_times[0]=0  # First process has 0 waiting time

    # Sort burst times in ascending order
    sorted_burst_times=($(echo "${burst_times[@]}" | tr ' ' '\n' | sort -n))

    # Calculate waiting time for each process
    for ((i=1; i<n; i++)); do
        waiting_times[i]=$((sorted_burst_times[i-1] + waiting_times[i-1]))
        total_waiting_time=$((total_waiting_time + waiting_times[i]))
    done

    # Calculate average waiting time
    local average_waiting_time=$(bc <<< "scale=2; $total_waiting_time / $n")
    echo "$average_waiting_time"
}

# Prompt the user to enter the number of processes
echo "Enter the number of processes:"
read n

# Arrays to store burst times and waiting times
declare -a burst_times
declare -a waiting_times

# Prompt the user to enter burst times of processes
echo "Enter burst times for each process:"
for ((i=0; i<n; i++)); do
    echo "Burst time for process $((i+1)):"
    read burst_time
    burst_times[$i]=$burst_time
done

# Call the calculate_average_waiting_time function
average_waiting_time=$(calculate_average_waiting_time burst_times waiting_times)

# Output the average waiting time
echo "Average waiting time: $average_waiting_time"
