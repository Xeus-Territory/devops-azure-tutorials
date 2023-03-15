#!/bin/bash

# 3. Write a Powershell script and a Bash script that:
# - Take your input
# - Check if the input is empty
# - Create a new script (Check if the file exists) that prints out your
# input and the new script name/full path
# - Execute that new script

read -p "Type your input: " input

if [[ $input == "" ]]
then 
    echo "Your input is empty | Ending here"
else
    read -p "What script you want to excute, Remember give it to a file: " newscript
    name_newfile=$(echo $newscript | cut -d ">" -f 2 | tr -d " ")
    script=$(echo $newscript | cut -d ">" -f 1)
    if [[ -f $name_newfile ]]
    then
        echo "file really exist !! Ending here"
        exit 1
    else
        echo "The input is : $input"
        pathoffile="$PWD/$name_newfile"
        echo "Name: $name_newfile"
        echo "Fullpath: $pathoffile"
        echo "Script:" > $name_newfile
        echo "$script" >> $name_newfile
        echo "Result: " >> $name_newfile
<<<<<<< HEAD
=======
        # $(<blockcommand>) --> Execuatable 
>>>>>>> main
        command=$($script >> $name_newfile)
        cat $name_newfile
    fi
fi