#!/bin/bash

# Prompt the user to enter the file name
echo "Enter the file name:"
read filename

# Check if the file exists
if [ ! -f "$filename" ]; then
    echo "File '$filename' does not exist."
    exit 1
fi

# Read the file line by line
while IFS= read -r line; do
    # Compute the number of characters in the line
    num_chars=${#line}

    # Compute the number of words in the line
    words=($line)
    num_words=${#words[@]}

    # Output the line information
    echo "Line: $line"
    echo "Number of characters: $num_chars"
    echo "Number of words: $num_words"
    echo "--------------------"
done < "$filename"
