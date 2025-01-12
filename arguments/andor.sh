#!/bin/bash

#Check if two numbers are equal
read -p "Enter the first value: " val1
read -p "Enter the second value: " val2

if [[ $val1 == "yes" ]] || [[ $val2 == "yes" ]]; then
    echo "At least one value is 'yes' ."
else
    echo "Neither value is 'yes' ."
fi