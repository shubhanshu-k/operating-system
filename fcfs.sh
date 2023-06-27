#!/bin/bash

# Function to calculate average waiting time
calculate_waiting_time() {
    local -n burst_time=$1
    local -n waiting_time=$2

    waiting_time[0]=0  # First process has 0 waiting time

    for ((i=1; i<$num_processes; i++)); do
        waiting_time[$i]=$((waiting_time[$((i-1))]+burst_time[$((i-1))]))
    done
}

# Function to calculate average turnaround time
calculate_turnaround_time() {
    local -n burst_time=$1
    local -n waiting_time=$2
    local -n turnaround_time=$3

    for ((i=0; i<$num_processes; i++)); do
        turnaround_time[$i]=$((burst_time[$i]+waiting_time[$i]))
    done
}

# Function to calculate average response time
calculate_response_time() {
    local -n waiting_time=$1
    local -n response_time=$2

    response_time=("${waiting_time[@]}")
}

# Function to display the results
display_results() {
    local -n burst_time=$1
    local -n waiting_time=$2
    local -n turnaround_time=$3
    local -n response_time=$4

    echo "Process    Burst Time    Waiting Time    Turnaround Time    Response Time"
    echo "---------------------------------------------------------------------"

    for ((i=0; i<$num_processes; i++)); do
        echo "  P$i            ${burst_time[$i]}                  ${waiting_time[$i]}                 ${turnaround_time[$i]}                 ${response_time[$i]}"
    done

    echo "---------------------------------------------------------------------"

    # Calculate average waiting time
    local total_waiting_time=0
    for wt in "${waiting_time[@]}"; do
        total_waiting_time=$((total_waiting_time+wt))
    done
    local average_waiting_time=$(bc -l <<< "scale=2; $total_waiting_time/$num_processes")

    # Calculate average turnaround time
    local total_turnaround_time=0
    for tat in "${turnaround_time[@]}"; do
        total_turnaround_time=$((total_turnaround_time+tat))
    done
    local average_turnaround_time=$(bc -l <<< "scale=2; $total_turnaround_time/$num_processes")

    # Calculate average response time
    local total_response_time=0
    for rt in "${response_time[@]}"; do
        total_response_time=$((total_response_time+rt))
    done
    local average_response_time=$(bc -l <<< "scale=2; $total_response_time/$num_processes")

    echo "Average Waiting Time:    $average_waiting_time"
    echo "Average Turnaround Time: $average_turnaround_time"
    echo "Average Response Time:   $average_response_time"
}

# Main script starts here

# Array to hold burst time for each process
burst_time=(10 5 8 2)

num_processes=${#burst_time[@]}

# Array to hold waiting time for each process
declare -a waiting_time

# Array to hold turnaround time for each process
declare -a turnaround_time

# Array to hold response time for each process
declare -a response_time

# Calculate waiting time, turnaround time, and response time
calculate_waiting_time burst_time waiting_time
calculate_turnaround_time burst_time waiting_time turnaround_time
calculate_response_time waiting_time response_time

# Display the results
display_results burst_time waiting_time turnaround_time response_time
