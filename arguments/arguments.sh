#!/bin/bash

echo
read -p "Please enter the first number: " arg1
read -p "Please enter the second number: " arg2

if [[ ${arg1} -ge ${arg2} ]]; then
    echo "$arg1 is greater than  $arg2"
else
    echo "$arg1 is less than or equal to $arg2"
fi
