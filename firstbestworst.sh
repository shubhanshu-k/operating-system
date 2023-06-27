#!/bin/bash

# Function to simulate First Fit memory allocation
first_fit() {
    local -n memory_blocks=$1
    local -n process_sizes=$2

    local m=${#memory_blocks[@]}
    local n=${#process_sizes[@]}
    local -a allocated_blocks=()

    # Initialize allocation array with -1
    for ((i=0; i<n; i++)); do
        allocated_blocks[i]=-1
    done

    # Simulate First Fit memory allocation
    for ((i=0; i<n; i++)); do
        local process_size=${process_sizes[i]}
        local allocated=false

        for ((j=0; j<m; j++)); do
            if [[ ${memory_blocks[j]} -ge $process_size ]]; then
                allocated_blocks[i]=$j
                memory_blocks[j]=$((memory_blocks[j] - process_size))
                allocated=true
                break
            fi
        done

        if ! $allocated; then
            allocated_blocks[i]=-1
        fi
    done

    echo "First Fit Allocation:"
    for ((i=0; i<n; i++)); do
        local process_size=${process_sizes[i]}
        local block_index=${allocated_blocks[i]}

        if [[ $block_index -ne -1 ]]; then
            echo "Process $((i+1)) of size $process_size allocated to block $((block_index+1))"
        else
            echo "Process $((i+1)) of size $process_size could not be allocated"
        fi
    done
}

# Function to simulate Best Fit memory allocation
best_fit() {
    local -n memory_blocks=$1
    local -n process_sizes=$2

    local m=${#memory_blocks[@]}
    local n=${#process_sizes[@]}
    local -a allocated_blocks=()

    # Initialize allocation array with -1
    for ((i=0; i<n; i++)); do
        allocated_blocks[i]=-1
    done

    # Simulate Best Fit memory allocation
    for ((i=0; i<n; i++)); do
        local process_size=${process_sizes[i]}
        local best_fit_index=-1

        for ((j=0; j<m; j++)); do
            if [[ ${memory_blocks[j]} -ge $process_size ]]; then
                if [[ $best_fit_index -eq -1 ]]; then
                    best_fit_index=$j
                elif [[ ${memory_blocks[j]} -lt ${memory_blocks[best_fit_index]} ]]; then
                    best_fit_index=$j
                fi
            fi
        done

        if [[ $best_fit_index -ne -1 ]]; then
            allocated_blocks[i]=$best_fit_index
            memory_blocks[best_fit_index]=$((memory_blocks[best_fit_index] - process_size))
        fi
    done

    echo "Best Fit Allocation:"
    for ((i=0; i<n; i++)); do
        local process_size=${process_sizes[i]}
        local block_index=${allocated_blocks[i]}

        if [[ $block_index -ne -1 ]]; then
            echo "Process $((i+1)) of size $process_size allocated to block $((block_index+1))"
        else
            echo "Process $((i+1)) of size $process_size could not be allocated"
        fi
    done
}

# Function to simulate Worst Fit memory allocation
worst_fit() {
    local -n memory_blocks=$1
    local -n process_sizes=$2

    local m=${#memory_blocks[@]}
    local n=${#process_sizes[@]}
    local -a allocated_blocks=()

    # Initialize allocation array with -1
    for ((i=0; i<n; i++)); do
        allocated_blocks[i]=-1
    done

    # Simulate Worst Fit memory allocation
    for ((i=0; i<n; i++)); do
        local process_size=${process_sizes[i]}
        local worst_fit_index=-1

        for ((j=0; j<m; j++)); do
            if [[ ${memory_blocks[j]} -ge $process_size ]]; then
                if [[ $worst_fit_index -eq -1 ]]; then
                    worst_fit_index=$j
                elif [[ ${memory_blocks[j]} -gt ${memory_blocks[worst_fit_index]} ]]; then
                    worst_fit_index=$j
                fi
            fi
        done

        if [[ $worst_fit_index -ne -1 ]]; then
            allocated_blocks[i]=$worst_fit_index
            memory_blocks[worst_fit_index]=$((memory_blocks[worst_fit_index] - process_size))
        fi
    done

    echo "Worst Fit Allocation:"
    for ((i=0; i<n; i++)); do
        local process_size=${process_sizes[i]}
        local block_index=${allocated_blocks[i]}

        if [[ $block_index -ne -1 ]]; then
            echo "Process $((i+1)) of size $process_size allocated to block $((block_index+1))"
        else
            echo "Process $((i+1)) of size $process_size could not be allocated"
        fi
    done
}

# Prompt the user to enter the number of memory blocks
echo "Enter the number of memory blocks:"
read m

# Prompt the user to enter the memory block sizes
echo "Enter the sizes of memory blocks (separated by spaces):"
read -a memory_blocks

# Prompt the user to enter the number of processes
echo "Enter the number of processes:"
read n

# Prompt the user to enter the process sizes
echo "Enter the sizes of processes (separated by spaces):"
read -a process_sizes

# Call the memory allocation functions
first_fit memory_blocks process_sizes
best_fit memory_blocks process_sizes
worst_fit memory_blocks process_sizes
