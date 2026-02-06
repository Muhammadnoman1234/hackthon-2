@echo off
echo ========================================
echo      TODO CONSOLE APPLICATION
echo ========================================
echo.

REM Try different Python commands
where python >nul 2>&1
if %errorlevel% == 0 (
    python phase1/src/main.py
    goto :end
)

if exist "local_python\python.exe" (
    local_python\python.exe phase1/src/main.py
    goto :end
)

where py >nul 2>&1
if %errorlevel% == 0 (
    py phase1/src/main.py
    goto :end
)

where python3 >nul 2>&1
if %errorlevel% == 0 (
    python3 phase1/src/main.py
    goto :end
)

where python3.14 >nul 2>&1
if %errorlevel% == 0 (
    python3.14 phase1/src/main.py
    goto :end
)

echo Error: Python not found in PATH
echo Please install Python 3.7 or later and add it to your PATH
echo Download from: https://www.python.org/downloads/
echo.
pause

:end