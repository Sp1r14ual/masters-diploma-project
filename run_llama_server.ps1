$ErrorActionPreference = "Stop"
$LlamaBin = "C:\Users\Sp1r14ual\.docker\bin\inference\llama-server.exe"

if (-not (Test-Path $LlamaBin)) {
    Write-Host "[ERROR] llama-server.exe not found at $LlamaBin" -ForegroundColor Red
    pause
    exit 1
}

# Auto-detect downloaded model
$ModelPath = "models\Qwen2.5-3B-Instruct-Q5_K_M.gguf"
$NGL = 99

if (-not (Test-Path $ModelPath)) {
    $ModelPath = "models\Qwen2.5-7B-Instruct-Q4_K_M.gguf"
    $NGL = 18
}

if (-not (Test-Path $ModelPath)) {
    $found = Get-ChildItem "models\*.gguf" | Select-Object -First 1
    if ($found) {
        $ModelPath = $found.FullName
        $NGL = 99
    } else {
        Write-Host "[ERROR] No GGUF model found in models\ folder." -ForegroundColor Red
        pause
        exit 1
    }
}

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host " Starting llama-server for Qwen" -ForegroundColor Green
Write-Host " Model: $ModelPath" -ForegroundColor Yellow
Write-Host " GPU layers (-ngl): $NGL" -ForegroundColor Yellow
Write-Host " Endpoint: http://127.0.0.1:8080" -ForegroundColor Cyan
Write-Host " Press Ctrl+C to stop" -ForegroundColor Gray
Write-Host "========================================================" -ForegroundColor Cyan

& $LlamaBin -m $ModelPath --host 127.0.0.1 --port 8080 -c 8192 -ngl $NGL

