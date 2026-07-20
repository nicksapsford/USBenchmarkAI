@echo off
title USBenchmark A.I. Dashboard - Port 5024
cd /d C:\Users\abc\Desktop\USBenchmarkAI
start /min "USBenchmark A.I. Dashboard" cmd /c C:\Users\abc\AppData\Local\Programs\Python\Python313\python.exe dashboard_usbenchmark.py
timeout /t 5 /nobreak >nul
start http://localhost:5024
