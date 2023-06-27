#!/bin/bash

# Prompt the user to enter three numbers
echo "Enter the first number:"
read num1
echo "Enter the second number:"
read num2
echo "Enter the third number:"
read num3

# Check if num1 is the greatest
if [ $num1 -gt $num2 ] && [ $num1 -gt $num3 ]; then
    echo "The greatest number is $num1"
# Check if num2 is the greatest
elif [ $num2 -gt $num1 ] && [ $num2 -gt $num3 ]; then
    echo "The greatest number is $num2"
# Check if num3 is the greatest
elif [ $num3 -gt $num1 ] && [ $num3 -gt $num2 ]; then
    echo "The greatest number is $num3"
# If none of the conditions are met, all numbers are equal
else
    echo "All numbers are equal"
fi
