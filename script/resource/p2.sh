#!/bin/bash

# 2. Write a Powershell script and a Bash script that:
# - List all files in the current directory, sorts the output, remove file
# extensions
# - List only show .txt files
# - List files and folders that have been created within 1 day

echo "List all files in the current directory, sorts the output, remove file
extensions"
ls | sort | cut -d "." -f 1
echo ""
echo ""


echo "Show only txt file"
echo "Method 1 using ls"
ls | egrep '\.txt'
echo "Method 2 using find"
find . -iregex '.*\.\(txt\)' -printf '%f\n'
echo ""
echo ""


echo "List files and folders that have been created within 1 day"
find . -maxdepth 1 -mtime -1


