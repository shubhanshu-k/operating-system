#!/bin/bash

# Function to check if a number is prime
is_prime() {
    number=$1

    # 0 and 1 are not prime numbers
    if [ $number -eq 0 ] || [ $number -eq 1 ]; then
        return 1
    fi

    # Check divisibility up to the square root of the number
    limit=$(echo "sqrt($number)" | bc)
    for ((i=2; i<=$limit; i++)); do
        if [ $((number%i)) -eq 0 ]; then
            return 1
        fi
    done

    return 0
}

# Prompt the user to enter a number
echo "Enter a number:"
read number

# Call the is_prime function
if is_prime "$number"; then
    echo "The number $number is prime."
else
    echo "The number $number is not prime."
fi
