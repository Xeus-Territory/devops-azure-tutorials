#!/usr/bin/env pwsh

#8. Write a Powershell script and a Bash script that check open ports in `www.orientsoftware.com`

$port = Read-Host "What port you want to check in www.orientsoftware.com"
for ($i = 0; $i -lt $port.Split(" ").Length; $i++)
{
    if ((Test-NetConnection -ComputerName www.orientsoftware.com -Port $port.Split(" ")[$i]).TcpTestSucceeded -eq "True")
    {
        Write-Host $port.Split(" ")[$i] "is Open" 
    }
}