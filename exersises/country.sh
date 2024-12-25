#!/bin/bash

REQUIRED_VARS=( "country1" "country2" "country3" "country4" )
country1=bulgaria
country2=greece
country3=italy
for var in "${REQUIRED_VARS[@]}";do
       if [ -z ${!var} ]; then
                echo "$var is not  set"
        else
                echo "$var is set"
       fi
done
