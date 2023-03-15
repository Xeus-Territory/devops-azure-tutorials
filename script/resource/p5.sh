#!/bin/bash

# 5. Write a Powershell script and a Bash script that download a
# compressed file and then decompress it into a folder

sudo apt install -y unzip

read -p "URL you want to download : " URL

command=$(wget $URL)
file=$(ls | egrep '\.zip')
namefolder=$(echo $file | cut -d "." -f 1)
mkdir $namefolder
command_unzip=$(unzip $file -d $namefolder)
echo $command_unzip