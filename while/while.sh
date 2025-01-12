#/bin/bash

read -p "What is your name: " vesko

while [[ -z ${name} ]]
do

    echo "Your name cannot be blank. Please enter valied name." 
    read -p "Enter your name again: " name
done

echo "Hello there, ${name} !" 