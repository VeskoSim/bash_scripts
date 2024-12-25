#!/bin/bash

# Function to validate if input is a number
is_number() {
    [[ "$1" =~ ^-?[0-9]+$ ]]
}

# Function to compare two numbers
compare_numbers() {
    if [ "$1" -gt "$2" ]; then
        echo "$1 is greater than $2"
    elif [ "$1" -lt "$2" ]; then
        echo "$1 is less than $2"
    else
        echo "$1 is equal to $2"
    fi
}

# Prompt user for input
read -p "Enter the first number: " num1
if [ -z "$num1" ]; then
    echo "error! the user must enter number"
    exit 1111
fi

read -p "Enter the second number: " num2
if [ -z "$num2" ]; then
    echo "error! the user must enter number"
    exit 1111
fi

# Validate inputs
if ! is_number "$num1" || ! is_number "$num2"; then
    echo "Invalid input. Please enter valid integers."
    exit 1
fi

# Check positivity/negativity of the first number
if [ "$num1" -gt 0 ]; then
    echo "$num1 is positive"
elif [ "$num1" -lt 0 ]; then
    echo "$num1 is negative"
else
    echo "$num1 is neither positive or negative"
fi

# Check positivity/negativity of the second number
if [ "$num2" -gt 0 ]; then
    echo "$num2 is positive"
elif [ "$num2" -lt 0 ]; then
    echo "$num2 is negative"
else
    echo "$num2 is neither positive or negative"
fi

# Special case for "hi"
if [ "$num1" == "hi" ] || [ "$num2" == "hi" ]; then
    echo "hi is neither positive or negative"
fi

# Call the function with user inputs
compare_numbers $num1 $num2
