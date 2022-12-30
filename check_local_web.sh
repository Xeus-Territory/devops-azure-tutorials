#!/bin/bash

read -p "What version of nodejs image you want to build: " version

if [[ $version -eq 12 ]]
then 
    sudo docker pull mhart/alpine-node:12
    sudo docker build -t nodejs12:v12 ./Node_Hello_12/
    sudo docker run -d --name $version -p 3000:3000 nodejs12:v12
    sleep 3 
    test=$(curl -I localhost:3000 | awk '/HTTP\// {print $2}') 
    if [[ "$test" == "200" ]]
    then 
            echo "Local web server is running"
    else 
            echo "WARM: Local web server is not running"
    fi 
fi

if [[ $version -eq 14 ]]
then 
    sudo docker pull mhart/alpine-node:14
    sudo docker build -t nodejs14:v14 ./Node_Hello_14/
    sudo docker run -d --name $version -p 3001:3001 nodejs14:v14
    sleep 3 
    test=$(curl -I localhost:3001 | awk '/HTTP\// {print $2}') 
    if [[ "$test" == "200" ]]
    then 
            echo "Local web server is running"
    else 
            echo "WARM: Local web server is not running"
    fi 
fi

