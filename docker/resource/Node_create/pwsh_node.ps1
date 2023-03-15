#!/usr/bin/pwsh 

param(
    [string]$version
)

# $version = Read-Host -prompt "What version of node you want to apply"

if ($version -eq "12" -or $version -eq "14")
{
    docker build -t nodejs:lastestv$version --build-arg version=$version .
}
else
{
    Write-Host "$version is not supported"
}

    

