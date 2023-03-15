#!/bin/bash

read -p "name container of web page: " namecontainer

result=$(docker exec -it $namecontainer curl 127.0.0.1:3000 || set -e)

if [[ $result ]]
then
    echo "The container can accesible inside --> Return from container $result"
fi

