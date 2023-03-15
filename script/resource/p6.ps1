#!/usr/bin/env pwsh

# 6. Delete everything in a folder, mute all outputs and continue if any error

$folder = Read-Host -prompt "What folder you want to delete"

$current_Dir = Get-Location
$location_file= [string]$current_Dir + "/" + [string]$folder
if (Test-Path -Path $location_file)
{
    Remove-Item $location_file -Force -Confirm:$false
}
else
{
    Write-Host "The folder is not exist "
}