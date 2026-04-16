# PhishGuard v3.0 — Hybrid URL Threat Intelligence System

> Final Year Project | Real-Time Phishing Detection with Static + Dynamic Analysis

---

## 🔬 What It Does

PhishGuard scans any URL using three detection modes:

| Mode | What runs |
|------|-----------|
| **Static** | DNS, WHOIS, SSL, syntax heuristics, blacklists, redirect chain |
| **Dynamic** | Headless Chromium visits the URL, captures screenshot, detects live threats |
| **Hybrid** | Both run in parallel — maximum accuracy |

---

## ⚡ Quick Start

### Windows
```
Double-click run.bat
```

### Mac / Linux
```bash
chmod +x run.sh
./run.sh
```

Then open `phishing-detector.html` in your browser.

---

## 🛠 Setup

### Requirements
- Python 3.9+
- Internet connection

### Manual setup
```bash
python -m venv venv
source venv/bin/activate          # or venv\Scripts\activate on Windows
pip install -r requirements.txt
python -m playwright install chromium
uvicorn main:app --host 127.0.0.1 --port 8000 --reload
```

### API Keys (optional but recommended)
Create a `.env` file (copy from `.env.example`):

```
GOOGLE_SAFE_BROWSING_KEY=your_key_here
URLSCAN_API_KEY=your_key_here
```

- **Google Safe Browsing** — free, get at https://console.cloud.google.com
- **Urlscan.io** — free, register at https://urlscan.io

---

## 🔎 Detection Checks

### Static (18 checks)
- DNS resolution (A, MX, NS, TXT records)
- SPF / DMARC email authentication
- SSL certificate validity, expiry, self-signing
- WHOIS domain age, registrar, privacy shield
- URL syntax heuristics (length, subdomains, dashes, @-tricks, punycode, suspicious keywords, suspicious TLDs)
- OpenPhish live feed lookup
- URLhaus/abuse.ch API
- Google Safe Browsing API
- Redirect chain analysis (cross-domain detection)

### Dynamic (9 checks via Playwright)
- Live screenshot of rendered page
- Brand impersonation detection
- Credential harvesting form detection
- JavaScript obfuscation scanning
- Urgency language NLP detection
- Suspicious data exfiltration request monitoring
- Popup / new tab behaviour
- Hidden iframe detection
- Cookie analysis

---

## 📡 API

**POST /scan**
```json
{
  "url": "https://example.com",
  "scan_mode": "hybrid"
}
```

**GET /health**

---

## 📂 Files

```
phishguard/
├── main.py                  ← FastAPI backend
├── phishing-detector.html   ← Frontend UI
├── requirements.txt
├── run.bat                  ← Windows launcher
├── run.sh                   ← Mac/Linux launcher
└── .env.example             ← API key template
```

---

## 📊 Risk Score

| Score | Verdict |
|-------|---------|
| 0–15 | SAFE |
| 16–35 | LOW RISK |
| 36–55 | SUSPICIOUS |
| 56–75 | HIGH RISK |
| 76–100 | CRITICAL THREAT |

---

*Built with FastAPI · Playwright · DNSPython · python-whois · aiohttp*
