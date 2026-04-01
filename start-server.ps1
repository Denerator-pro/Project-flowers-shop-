$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$phpExe = Join-Path $projectRoot ".tools\php\php.exe"
$port = 8080

if (-not (Test-Path $phpExe)) {
    Write-Error "PHP не найден: $phpExe"
}

$running = Get-CimInstance Win32_Process | Where-Object {
    $_.Name -eq "php.exe" -and $_.CommandLine -like "*127.0.0.1:$port*"
}

if ($running) {
    Write-Output "Сервер уже запущен (PID: $($running.ProcessId))"
    Write-Output "Откройте: http://127.0.0.1:$port"
    exit 0
}

$outLog = Join-Path $projectRoot ".tools\php-server.out.log"
$errLog = Join-Path $projectRoot ".tools\php-server.err.log"

$process = Start-Process -FilePath $phpExe `
    -ArgumentList "-S", "127.0.0.1:$port", "-t", "public" `
    -WorkingDirectory $projectRoot `
    -RedirectStandardOutput $outLog `
    -RedirectStandardError $errLog `
    -PassThru

Start-Sleep -Seconds 1
Write-Output "Сервер запущен (PID: $($process.Id))"
Write-Output "Откройте: http://127.0.0.1:$port"
