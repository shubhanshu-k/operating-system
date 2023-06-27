#!/bin/bash

# Function to calculate average waiting time
calculate_average_waiting_time() {
    local -n burst_times=$1
    local -n waiting_times=$2
    local -n priorities=$3

    local n=${#burst_times[@]}
    local total_waiting_time=0

    waiting_times[0]=0  # First process has 0 waiting time

    # Sort processes based on priority (in ascending order)
    sorted_indices=($(seq 0 $((n-1)) | sort -k"${priorities[*]}"n))

    # Calculate waiting time for each process
    for ((i=1; i<n; i++)); do
        local current_index=${sorted_indices[i]}
        local previous_index=${sorted_indices[i-1]}
        waiting_times[current_index]=$((burst_times[previous_index] + waiting_times[previous_index]))
        total_waiting_time=$((total_waiting_time + waiting_times[current_index]))
    done

    # Calculate average waiting time
    local average_waiting_time=$(bc <<< "scale=2; $total_waiting_time / $n")
    echo "$average_waiting_time"
}

# Prompt the user to enter the number of processes
echo "Enter the number of processes:"
read n

# Arrays to store burst times, waiting times, and priorities
declare -a burst_times
declare -a waiting_times
declare -a priorities

# Prompt the user to enter burst times and priorities for each process
echo "Enter burst times and priorities for each process:"
for ((i=0; i<n; i++)); do
    echo "Process $((i+1)):"

    echo "Burst time:"
    read burst_time
    burst_times[$i]=$burst_time

    echo "Priority:"
    read priority
    priorities[$i]=$priority
done

# Call the calculate_average_waiting_time function
average_waiting_time=$(calculate_average_waiting_time burst_times waiting_times priorities)

# Output the average waiting time
echo "Average waiting time: $average_waiting_time"
