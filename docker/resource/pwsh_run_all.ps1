#!/usr/bin/pwsh

# Create node12
Set-Location Node_create
./pwsh_node.ps1 -version 12

# Create node14
./pwsh_node.ps1 -version 14

# Return create a 2-web node12 vs node14 with docker compose
Set-Location ..
docker-compose up --build --detach

# Check the server is exist
Write-Host "=========================================================="
Write-Host "=================Status Container Below==================="
Write-Host "=========================================================="
$connection = New-Object System.Net.Sockets.TcpClient("127.0.0.1", "3000")
if ($connection.Connected)
{
    Start-Sleep 2
    $result=curl -L 127.0.0.1:3000
    Write-Host "Server is running in port 3000, and return this message $result"
}
else
{
    Write-Host "Server is not running in port 3000"
}
$connection = New-Object System.Net.Sockets.TcpClient("127.0.0.1", "3001")
if ($connection.Connected)
{
    Start-Sleep 2
    $result=curl -L 127.0.0.1:3001
    Write-Host "Server is running in port 3001, and return this message $result"
}
else
{
    Write-Host "Server is not running in port 3001"
}