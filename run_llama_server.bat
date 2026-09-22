@echo off
echo ========================================================
echo Starting llama.cpp server for Qwen...
echo ========================================================

set LLAMA_BIN=C:\Users\Sp1r14ual\.docker\bin\inference\llama-server.exe
set MODEL_PATH=models\Qwen2.5-3B-Instruct-Q5_K_M.gguf
set NGL=18
set PORT=8080

if not exist "%LLAMA_BIN%" (
    echo [ERROR] llama-server.exe not found: %LLAMA_BIN%
    pause
    exit /b 1
)

if not exist "%MODEL_PATH%" (
    set MODEL_PATH=models\Qwen2.5-7B-Instruct-Q4_K_M.gguf
    set NGL=18
)

if not exist "%MODEL_PATH%" (
    echo [ERROR] Model not found in models\
    pause
    exit /b 1
)

echo Model: %MODEL_PATH%
echo Port: %PORT%
echo Offload GPU layers: %NGL%
echo.

"%LLAMA_BIN%" -m "%MODEL_PATH%" --host 127.0.0.1 --port %PORT% -c 8192 -ngl %NGL%
pause
