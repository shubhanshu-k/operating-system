#!/bin/bash

# Function to calculate factorial
factorial() {
    num=$1
    result=1

    # Calculate factorial
    for ((i=2; i<=num; i++)); do
        result=$((result * i))
    done

    echo $result
}

# Prompt the user to enter a number
echo "Enter a number:"
read number

# Check if the number is non-negative
if [ $number -lt 0 ]; then
    echo "Error: Factorial is not defined for negative numbers."
    exit 1
fi

# Call the factorial function
result=$(factorial "$number")

# Output the factorial
echo "The factorial of $number is: $result"
