$ErrorActionPreference = 'Stop'
$linuxDir = '/mnt/c/Users/alexisz/Documents/Codex/2026-10-26/tas3-vol-menes-para-persistir-base/outputs/mysql-phpmyadmin'
& 'C:\Program Files\WSL\wsl.exe' -d Ubuntu-24.04 -u root --cd $linuxDir --exec env MYSQL_ROOT_PASSWORD=Tas3_Laboratorio_2026 docker compose stop
if ($LASTEXITCODE -ne 0) { throw 'No se pudieron detener los contenedores.' }
$pidPath = Join-Path $PSScriptRoot '.wsl-practica.pid'
if (Test-Path $pidPath) {
    $keeperId = [int](Get-Content $pidPath)
    $keeper = Get-CimInstance Win32_Process -Filter "ProcessId=$keeperId"
    if ($keeper.Name -eq 'wsl.exe' -and $keeper.CommandLine -match 'Ubuntu-24.04' -and $keeper.CommandLine -match 'sleep.*infinity') {
        Stop-Process -Id $keeperId
    }
}
Write-Host 'Contenedores detenidos. La base de datos permanece almacenada.'