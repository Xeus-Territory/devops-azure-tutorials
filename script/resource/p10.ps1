#!/usr/bin/env pwsh 

# Write a Powershell script and a Bash script that generate a self-signed SSL certificate

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

$dns = Read-Host -prompt "What is the name of the domain u want to generate a self-signed SSL certificate"
$location = Read-Host -prompt "Where is the location to store the certificate"

New-SelfSignedCertificate -DnsName $dns -CertStoreLocation $location



