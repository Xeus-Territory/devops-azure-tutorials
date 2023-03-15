#!/usr/bin/env pwsh

# 2. Write a Powershell script and a Bash script that:
# - List all files in the current directory, sorts the output, remove file
# extensions
# - List only show .txt files
# - List files and folders that have been created within 1 day

Write-Host "List all files in the current directory, sorts the output, remove file extensions"
$list = (Get-Item *).Basename | Sort-Object
Write-Host $list
Write-Host ""
Write-Host ""

Write-Host "List only show .txt files"
$txtList = (Get-ChildItem -Path $dir -Filter *.txt | Select-Object -First 1).Name
Write-Host $txtList
Write-Host ""
Write-Host ""

Write-Host "List files and folders that have been created within 1 day"
$day_today = (Get-Date).AddDays(-1)
$1_day_create = Get-ChildItem -Path $dir -Force -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -gt $day_today } | 
Sort-Object -Descending
Write-Host $1_day_create