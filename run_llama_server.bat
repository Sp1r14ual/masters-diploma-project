@echo off
chcp 65001 >nul
echo ========================================================
echo  Запуск локального сервера llama.cpp для Qwen
echo ========================================================

set LLAMA_BIN=C:\Users\Sp1r14ual\.docker\bin\inference\llama-server.exe
set MODEL_PATH=models\Qwen_Qwen3.6-35B-A3B-Q4_K_M.gguf
set PORT=8080

if not exist "%LLAMA_BIN%" (
    echo [ERROR] Файл llama-server.exe не найден по пути: %LLAMA_BIN%
    pause
    exit /b 1
)

if not exist "%MODEL_PATH%" (
    echo [ERROR] Модель не найдена: %MODEL_PATH%
    pause
    exit /b 1
)

echo Запуск сервера на http://127.0.0.1:%PORT%...
echo Контекст: 8192 токенов, частичный оффлоад на GPU.
echo Для остановки нажмите Ctrl+C.
echo.

"%LLAMA_BIN%" -m "%MODEL_PATH%" --host 127.0.0.1 --port %PORT% -c 8192 -ngl 10 -t 6

pause

