@echo off
title PhishGuard v3 — Hybrid Scanner

echo ============================================
echo  PHISHGUARD v3.0 — Hybrid Threat Scanner
echo ============================================
echo.

:: Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not found. Please install Python 3.9+ from python.org
    pause
    exit /b 1
)

:: Create venv if needed
if not exist venv (
    echo [1/4] Creating virtual environment...
    python -m venv venv
)

:: Activate
echo [2/4] Activating virtual environment...
call venv\Scripts\activate

:: Install deps
echo [3/4] Installing dependencies...
pip install -r requirements.txt -q

:: Install Playwright browsers
echo [4/4] Installing Playwright Chromium...
python -m playwright install chromium

echo.
echo [READY] Starting backend on http://127.0.0.1:8000
echo [INFO]  Open phishing-detector.html in your browser
echo [INFO]  Press Ctrl+C to stop
echo.

uvicorn main:app --host 127.0.0.1 --port 8000 --reload
pause
