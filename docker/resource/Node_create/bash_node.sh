#!/bin/bash

# read -p "Which node image do you want to work: " version

if [[ $1 != "12" && $1 != "14" ]]
then
    echo "$1 is not supported"
    exit 1
else
    docker build -t nodejs:lastestv$1 --build-arg version=$1 .
fi