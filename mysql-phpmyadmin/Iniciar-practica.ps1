$ErrorActionPreference = 'Stop'
$linuxDir = '/mnt/c/Users/alexisz/Documents/Codex/2026-10-26/tas3-vol-menes-para-persistir-base/outputs/mysql-phpmyadmin'
$pidPath = Join-Path $PSScriptRoot '.wsl-practica.pid'
$existing = if (Test-Path $pidPath) { Get-CimInstance Win32_Process -Filter ('ProcessId=' + [int](Get-Content $pidPath)) }
if (-not ($existing.Name -eq 'wsl.exe' -and $existing.CommandLine -match 'Ubuntu-24.04' -and $existing.CommandLine -match 'sleep.*infinity')) {
    $keepAlive = Start-Process -FilePath 'C:\Program Files\WSL\wsl.exe' -WindowStyle Hidden -ArgumentList @('-d','Ubuntu-24.04','-u','root','--exec','sleep','infinity') -PassThru
    $keepAlive.Id | Set-Content -LiteralPath $pidPath
}
& 'C:\Program Files\WSL\wsl.exe' -d Ubuntu-24.04 -u root --cd $linuxDir --exec env MYSQL_ROOT_PASSWORD=Tas3_Laboratorio_2026 docker compose up -d --wait --wait-timeout 240
if ($LASTEXITCODE -ne 0) { throw 'No se pudieron iniciar los contenedores.' }
Start-Process 'http://127.0.0.1:8080'