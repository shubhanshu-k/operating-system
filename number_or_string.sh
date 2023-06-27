#!/bin/bash

# Prompt the user to enter an input
echo "Enter an input:"
read input

# Check if the input is a number
if [[ "$input" =~ ^[0-9]+$ ]]; then
    echo "The input '$input' is a number."
else
    echo "The input '$input' is a string."
fi
