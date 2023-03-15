#!/usr/bin/env pwsh

# 9. Write a Powershell script and a Bash script that enable/disable SSH on a Windows/Linux machine

param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
        exit 1
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

$mode = Read-Host -prompt "Enable/Disable SSH"
if ($mode -eq "Enable" -or $mode -eq "enable")
{
    Start-Service -name SSDPSRV -force
    Set-Service -name SSDPSRV -StartupType Manual
    Get-Service SSDPSRV
}
if ($mode -eq "Disable" -or $mode -eq "disable")
{
    Stop-Service -name SSDPSRV -force
    Set-Service -name SSDPSRV -StartupType Disabled
    Get-Service SSDPSRV
}