#!/usr/bin/pwsh

$nameContainer = Read-Host -prompt "What name of container"

$result = docker exec -it $nameContainer curl 127.0.0.1:3000
if ($result -ne "")
{
    Write-Host "Docker can accesible inside and it return for us is $result"
}
