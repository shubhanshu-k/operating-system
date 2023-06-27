#!/bin/bash

# Prompt the user to enter a number
echo "Enter a number:"
read number

# Use modulo operator to check if the number is divisible by 2
if (( number % 2 == 0 )); then
    echo "The number $number is even."
else
    echo "The number $number is odd."
fi
