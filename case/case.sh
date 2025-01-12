#!/bin/bash

day=""
day="Monday"
day="Friday"

case $day in 

    "Monday")
        echo "Start of the week!"
        ;;
    "Friday" | "Sathurday")
        echo "Almost weekend!"
        ;;
    *)
        echo "Just another day."
        ;;
esac

