#!/bin/bash

# 1. Write a Powershell function and a Shell Script function that:
# - Take a string input as a date (i.e. Thursday, July 21, 2022)
# - Check if the date is in the right format “dddd,MM dd,YYYY”
# (using regex)
# - Check if the year is a leap year
# - Check if it is a weekend

ChallengeName="P1 - Bash"

echo "Hey this is my first $ChallengeName"
read -p "Which day you want to check: " Daytoday

if [[ $Daytoday =~ ^[A-Za-z]{6,9},[[:space:]]*[A-Za-z]{3,9}[[:space:]]*[0-3]{1}[0-9]{1},[[:space:]]*[1-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}$ ]]
then
    echo "Right Format"
    Year=$(echo $Daytoday | cut -d "," -f 3 | tr -d " ")
    Day=$(echo $Daytoday | cut -d "," -f 1)
    if [[ ($(($Year % 4)) = 0 && $(($Year % 100)) != 0) || ($(($Year % 400)) = 0) ]]
    then
        echo "$Year is a leap year"
    else
        echo "$Year is not a leap year"
    fi
    if [ $Day == "Sunday" ] 
    then
        echo "$Daytoday is the weekend"
    else
        echo "$Daytoday is not the weekend"
    fi
else 
    echo "Not Right format"
fi