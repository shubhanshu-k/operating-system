#!/bin/bash

# Function to calculate average waiting time
calculate_average_waiting_time() {
    local -n burst_times=$1
    local time_quantum=$2

    local n=${#burst_times[@]}
    local remaining_burst_times=("${burst_times[@]}")
    local current_time=0
    local total_waiting_time=0

    # Calculate waiting time for each process
    while true; do
        local all_processes_completed=true

        for ((i=0; i<n; i++)); do
            local burst_time=${remaining_burst_times[$i]}

            if [ $burst_time -gt 0 ]; then
                all_processes_completed=false

                if [ $burst_time -gt $time_quantum ]; then
                    current_time=$((current_time + time_quantum))
                    remaining_burst_times[$i]=$((burst_time - time_quantum))
                else
                    current_time=$((current_time + burst_time))
                    total_waiting_time=$((total_waiting_time + current_time - burst_times[$i]))
                    remaining_burst_times[$i]=0
                fi
            fi
        done

        if $all_processes_completed; then
            break
        fi
    done

    # Calculate average waiting time
    local average_waiting_time=$(bc <<< "scale=2; $total_waiting_time / $n")
    echo "$average_waiting_time"
}

# Prompt the user to enter the number of processes
echo "Enter the number of processes:"
read n

# Prompt the user to enter the time quantum
echo "Enter the time quantum:"
read time_quantum

# Array to store burst times
declare -a burst_times

# Prompt the user to enter burst times of processes
echo "Enter burst times for each process:"
for ((i=0; i<n; i++)); do
    echo "Burst time for process $((i+1)):"
    read burst_time
    burst_times[$i]=$burst_time
done

# Call the calculate_average_waiting_time function
average_waiting_time=$(calculate_average_waiting_time burst_times time_quantum)

# Output the average waiting time
echo "Average waiting time: $average_waiting_time"
