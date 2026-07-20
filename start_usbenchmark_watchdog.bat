@echo off
title USBenchmark A.I. Watchdog - Port 5024
cd /d C:\Users\abc\Desktop\USBenchmarkAI
start /min "USBenchmark A.I. Engine" cmd /c C:\Users\abc\AppData\Local\Programs\Python\Python313\python.exe watchdog_usbenchmark.py
