#!/bin/bash

# Create node12
cd Node_create || exit
./bash_node.sh 12

# Create node14
./bash_node.sh 14

# Return create a 2-web node12 vs node14 with docker compose
cd .. || exit
docker-compose up --build --detach

# Check the server is exist
echo "=========================================================="
echo "=================Status Container Below==================="
echo "=========================================================="
$(timeout 1 bash -c 'cat < /dev/null > /dev/tcp/127.0.0.1/3000')
if [[ $? -eq 0 ]]
then
    sleep 2
    result=$(curl -L 127.0.0.1:3000)
    echo "Server is running in port 3000, and return this message $result"
else
    echo "Server is not running in port 3000"
fi
$(timeout 1 bash -c 'cat < /dev/null > /dev/tcp/127.0.0.1/3001')
if [[ $? -eq 0 ]]
then
    sleep 2
    result=$(curl -L 127.0.0.1:3001)
    echo "Server is running in port 3001, and return this message $result"
else
    echo "Server is not running in port 3001"
fi
