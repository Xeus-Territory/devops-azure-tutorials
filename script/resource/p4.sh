#!/bin/bash

# 4. Create a text file, and open it by an app. Write a Powershell script
# and a Bash script that checks which process is opening that file then
# kill that process

read -p "what find you want to kill: " filename

command=$(ps -aux | grep nano | grep $filename | cut -d " " -f 3)

echo $command
kill $command