#!/usr/bin/env pwsh

# 4. Create a text file, and open it by an app. Write a Powershell script
# and a Bash script that checks which process is opening that file then
# kill that process

$namefile = Read-Host -Prompt "What name of file you want to kill"

$ID = (Get-Process | Select-Object ID,CommandLine | Where-Object CommandLine -EQ "/usr/bin/nano./$namefile").Id
echo $ID
Stop-Process -ID $ID -Force