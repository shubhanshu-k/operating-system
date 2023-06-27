#!/bin/bash

# Prompt the user to enter the count of numbers
echo "Enter the count of numbers:"
read count

# Initialize variables
sum=0

# Read the numbers and calculate the sum
echo "Enter $count numbers:"
for ((i=1; i<=count; i++)); do
    read number
    sum=$((sum + number))
done

# Calculate the average
average=$(bc <<< "scale=2; $sum / $count")

# Output the average
echo "The average is: $average"
