#!/usr/bin/env pwsh

# 3. Write a Powershell script and a Bash script that:
# - Take your input
# - Check if the input is empty
# - Create a new script (Check if the file exists) that prints out your
# input and the new script name/full path
# - Execute that new script

$input = Read-Host -Prompt "Put your input here"
if ($input -eq "")
{
    Write-Host "This is empty !! Do type right again"
}
else
{
    $newscript = Read-Host -Prompt "What is your new script"
    $script, $namefile = ($newscript -split " | ")[0,-1]
    $current_Dir = Get-Location
    $namefile = $namefile.replace(".\", "/")
    $location_file = [string]$current_Dir + [string]$namefile
    if (Test-Path -Path $location_file -PathType Leaf)
    {
        Write-Host "This is existed file | Do type right again"
    }
    else
    {
        Write-Host "Input: " $input
        Write-Host "Name: " $namefile
        Write-Host "FullPath: " $location_file
        #Invoke-Command -ScriptBlock { <blockcommand> }--> Executable ? Really work on terminal but not with script
        #Anotherway: iex $command alias for Invoke-Expression --> It work with source powershell script
        iex $newscript
        Get-Content $location_file
    }
}