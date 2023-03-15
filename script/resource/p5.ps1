#!/usr/bin/env pwsh

# 5. Write a Powershell script and a Bash script that download a
# compressed file and then decompress it into a folder

$URL = Read-Host -prompt "URL you want to download"
$Path = $URL.split("/")[-1]
$Store_Path = $Path.split('.')[0]

Invoke-WebRequest -URI $URL -OutFile $Path

Expand-Archive -Path $Path -Destination $Store_Path

