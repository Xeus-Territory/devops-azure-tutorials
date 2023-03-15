#!/usr/bin/env pwsh

#- Count “image” length
#- Print an image name in the image list if the resolution is square

$length_Image = ((Get-Content .\image.json | ConvertFrom-Json).Image).Length
Write-Host "Length of Image in json file is: $length_Image"

$Image_objects = (Get-Content .\image.json | ConvertFrom-Json).Image
($Image_objects | Where-Object {$_.hoffset -eq $_.woffset}).name