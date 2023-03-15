#!/bin/bash

#8. Write a Powershell script and a Bash script that check open ports in `www.orientsoftware.com`

read -p "What port you want to check to open: " port

for i in $(echo $port | tr " " "\n")
do
  # process
    $(timeout 1 bash -c 'cat < /dev/null > /dev/tcp/www.orientsoftware.com/'$i'')
    if [[ $? -eq 0  ]]
    then
        echo "This port $i is open"
    else
        echo "This port $i is not established by the timeout"
    fi
done