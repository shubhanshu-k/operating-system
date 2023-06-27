#!/bin/bash

# Function to check if a string is a palindrome
is_palindrome() {
    str=$1
    reversed_str=$(echo "$str" | rev)

    if [ "$str" == "$reversed_str" ]; then
        return 0
    else
        return 1
    fi
}

# Prompt the user to enter a string
echo "Enter a string:"
read string

# Call the is_palindrome function
if is_palindrome "$string"; then
    echo "The string '$string' is a palindrome."
else
    echo "The string '$string' is not a palindrome."
fi
