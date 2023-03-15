#!/bin/bash

# 9. Write a Powershell script and a Bash script that enable/disable SSH on a Windows/Linux machine

read -p "which mode do you want to apply ssh: " ssh_mode

if [[ $ssh_mode = "enable" ]]
then
    command=$(sudo -i systemctl start ssh)
    echo "enable for ssh"
fi
if [[ $ssh_mode = "disable" ]]
then
    command=$(sudo -i systemctl stop ssh)
    echo "stop for ssh"
fi
