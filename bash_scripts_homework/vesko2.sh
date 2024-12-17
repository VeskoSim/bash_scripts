#!/bin/bash

read -p "Say number:" number

if [ $number -gt 1000 ]; then

        echo "The number is high"

else
        echo "The number is low"

fi