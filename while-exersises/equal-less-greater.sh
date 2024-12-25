#!/bin/bash

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
read -p "Enter the second number: " num2

# Call the function with user inputs
compare_numbers $num1 $num2
