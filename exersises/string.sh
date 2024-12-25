#!/bin/bash

string1="Hello"
string2="Hello"

if [[ ${string1} < ${string2} ]]; then
    echo "The string is greater than"
else
    echo "The string is less than"
fi

if  [[ ${string1} == ${string2} ]]; then
    echo "The $string is equal"
else
    echo "The $string is not equal"
fi