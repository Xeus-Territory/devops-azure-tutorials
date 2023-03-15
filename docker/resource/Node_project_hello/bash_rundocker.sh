#!/bin/bash

# Access to Dockerfile [Folder contain that] --> Path specify
read -p "where of docker file you want to executable: " dkfilepath

if [[ -d $dkfilepath ]]
then
    read -p "which name you want to apply in container: " namecontainer
    docker build -t nodejs:node_hello $dkfilepath
    docker run -d --name $namecontainer -p 3000:3000 nodejs:node_hello
    $(timeout 1 bash -c 'cat < /dev/null > /dev/tcp/127.0.0.1/3000')
    if [[ $? -eq 0 ]]
    then
        echo "Accesible into web docker"
    else
        echo "Not accesiable into web docker"
    fi
else
    echo "$dkfilepath is not a folder --> Make sure this it folder and contain Dockerfile you want to execute"
fi