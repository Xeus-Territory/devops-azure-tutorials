#/usr/bin/pwsh

$pthdkfile = Read-Host -p "Which path contain dockerfile"
if (Test-Path -Path $pthdkfile)
{
    $containername = Read-Host -p "Which name you want to apply for container"
    docker build -t nodejs:node_hello $pthdkfile
    docker run -d --name $containername -p 3000:3000 nodejs:node_hello
    $connection = New-Object System.Net.Sockets.TcpClient("127.0.0.1", "3000")
    if ($connection.Connected)
    {
        Write-Host "Accesible into web docker"
    }
    else {
        Write-Host "Not accesiable into web docker"
    }
}
else
{
    Write-Host "$pthdkfile is not a folder --> Make sure this it folder and contain Dockerfile you want to execute"
}