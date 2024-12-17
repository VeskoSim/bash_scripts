#!/bin/bash

read -p "Please enter number " num

if [ -z "$num" ]; then
    echo "error! the user must enter number"
    exit 1111
fi

if [ "${num}" -gt 0 ]; then
    echo "$num is positive"

elif [ "${num}" -lt 0 ]; then
    echo "$num is negative"

else 
    echo "$num is neither positive or negative"

fi

