$ErrorActionPreference = "stop"


$versionArray =  $args[0].Split("+")
if($versionArray.Count -gt 1) {
    $build = $versionArray[1]
    }
else {
    $build = "build0"
}

$global:fullVersion = $args[0]
$global:pythonVersion = $versionArray[0]
$global:build = $build

function Get-Python
{
    if(-not (Test-Path ".\download\Python.zip"))
    {
        New-Item -Name ".\download" -ItemType "directory" -Force
        $url = "https://www.python.org/ftp/python/$pythonVersion/python-$pythonVersion-embed-amd64.zip"
        $output = ".\download\Python.zip"
        Invoke-WebRequest -Uri $url -OutFile $output
        Expand-Archive -LiteralPath '.\download\Python.zip' -DestinationPath ".\dist\Python-$pythonVersion"
    }
}

function Get-Pip
{
    if(-not (Test-Path ".\dist\Python-$pythonVersion\get-pip.py")) {
        $url = "https://bootstrap.pypa.io/get-pip.py"
        $output = "dist\Python-$pythonVersion\get-pip.py"
        Invoke-WebRequest -Uri $url -OutFile $output
    }
    & dist\Python-$pythonVersion\Python.exe dist\Python-$pythonVersion\get-pip.py
}

function Invoke-Python-Import-Patch
{
    $file = ".\dist\Python-$pythonVersion\python38._pth"
    (Get-Content $file) -replace "#import site", 'import site' | Set-Content $file
    Copy-Item ".\windows\sitecustomize.py" -Destination .\dist\Python-$pythonVersion
}

Get-Python
Get-Pip
Invoke-Python-Import-Patch
New-Item -Name ".\out" -ItemType "directory" -Force
Compress-Archive -Path dist\Python-$pythonVersion\* -DestinationPath out\PPython-$pythonVersion-windows-amd64.zip -Force



