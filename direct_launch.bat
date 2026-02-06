@echo off
echo ========================================
echo      TODO CONSOLE APP - DIRECT LAUNCH
echo ========================================
echo.

echo Starting Todo Application...
echo.

REM Try multiple Python locations
set "PYTHON_PATHS=C:\Python314\python.exe C:\Python313\python.exe C:\Python312\python.exe C:\Python311\python.exe C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python314\python.exe C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python313\python.exe"

for %%p in (%PYTHON_PATHS%) do (
    if exist "%%p" (
        echo Found Python at: %%p
        "%%p" "C:\Users\%USERNAME%\Desktop\hackthon 2\phase1\src\main.py"
        goto :eof
    )
)

echo Python not found in common locations.
echo.
echo Please:
echo 1. Install Python from https://www.python.org/downloads/
echo 2. Make sure to check "Add Python to PATH" during installation
echo 3. Restart your computer after installation
echo.
echo Then run this script again.
echo.
pause