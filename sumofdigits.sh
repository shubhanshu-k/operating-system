#!/bin/bash

# Function to calculate the sum of digits
sum_of_digits() {
    num=$1
    sum=0

    # Extract each digit and add it to the sum
    while [ $num -gt 0 ]; do
        digit=$((num % 10))
        sum=$((sum + digit))
        num=$((num / 10))
    done

    echo $sum
}

# Prompt the user to enter a number
echo "Enter a number:"
read number

# Call the sum_of_digits function
result=$(sum_of_digits "$number")

# Output the sum of digits
echo "The sum of digits of $number is: $result"
