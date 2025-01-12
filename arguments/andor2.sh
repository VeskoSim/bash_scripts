#!/bin/bash

read -p "Enter a number: " num

if [[ $num -ge 1 ]] && [[ $num -le 100 ]]; then
    echo "The number $num is between 1 and 100."
else
    echo "The number $num is outside the range of 1 to 100."
fi
