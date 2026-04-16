#!/usr/bin/env bash
set -e

echo "============================================"
echo " PHISHGUARD v3.0 — Hybrid Threat Scanner"
echo "============================================"
echo ""

# Check Python
if ! command -v python3 &>/dev/null; then
    echo "[ERROR] Python 3 not found. Install from python.org"
    exit 1
fi

# Create venv
if [ ! -d "venv" ]; then
    echo "[1/4] Creating virtual environment..."
    python3 -m venv venv
fi

# Activate
echo "[2/4] Activating virtual environment..."
source venv/bin/activate

# Install deps
echo "[3/4] Installing dependencies..."
pip install -r requirements.txt -q

# Playwright
echo "[4/4] Installing Playwright Chromium..."
python -m playwright install chromium

echo ""
echo "[READY] Starting backend on http://127.0.0.1:8000"
echo "[INFO]  Open phishing-detector.html in your browser"
echo "[INFO]  Press Ctrl+C to stop"
echo ""

uvicorn main:app --host 127.0.0.1 --port 8000 --reload
