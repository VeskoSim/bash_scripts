#!/bin/bash

admin="vesko"

read -p "Enter your user name: " username

if [[ "${username}" == "${admin}" ]] ; then
    echo "This is admin"
else
    echo "This is not admin"
fi
