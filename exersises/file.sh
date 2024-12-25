#!/bin/bash

file="~Documents/VeselinSimeonov/DevOps/bash_scripts/dev.sh"

if [[ -r ${file} ]]; then
    echo "The file exists and is readable."
else
    echo "The file does not exist or is not readable."
fi