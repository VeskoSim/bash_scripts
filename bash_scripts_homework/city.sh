#!/bin/bash

REQUIRED_VARS=( "town1" "town2" "town3" "town4" )
town1=sofia
town2=amsterdam
town3=london

for var in "${REQUIRED_VARS[@]}"; do
    if [ -z "${!var:-}" ]; then
        echo "$var is not favourite town"
    else
        echo "$var is favourite town"
    fi
done