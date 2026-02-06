@echo off
setlocal enabledelayedexpansion

echo ========================================
echo      TODO WEB APP - FIXED LOCAL SETUP
echo ========================================
echo.

REM Use the local Python installation
set "PYTHON_EXE=%~dp0local_python\python.exe"
set "SCRIPTS_DIR=%~dp0local_python\Scripts"

echo Using local Python: %PYTHON_EXE%
echo.

REM Check if Python exists
if not exist "%PYTHON_EXE%" (
    echo Error: Local Python not found
    echo Please run local_run.ps1 first to set up local Python
    pause
    exit /b 1
)

REM Verify Python works
echo Checking Python installation...
"%PYTHON_EXE%" --version
if !errorlevel! neq 0 (
    echo Error: Python not working properly
    pause
    exit /b 1
)

echo.
echo Setting up web environment...

REM Create Scripts directory if it doesn't exist
if not exist "%SCRIPTS_DIR%" mkdir "%SCRIPTS_DIR%"

REM Try to install pip if it doesn't exist
echo Checking for pip...
"%PYTHON_EXE%" -m pip --version >nul 2>&1
if !errorlevel! neq 0 (
    echo Installing pip...
    powershell -Command "Invoke-WebRequest -Uri 'https://bootstrap.pypa.io/get-pip.py' -OutFile '%~dp0get-pip.py'"
    "%PYTHON_EXE%" "%~dp0get-pip.py"
    del "%~dp0get-pip.py"
)

REM Install Flask
echo Installing Flask...
"%PYTHON_EXE%" -m pip install flask
if !errorlevel! neq 0 (
    echo Failed to install Flask
    echo Trying alternative method...
    
    REM Download Flask manually
    echo Downloading Flask dependencies...
    "%PYTHON_EXE%" -m pip install --user flask
    if !errorlevel! neq 0 (
        echo Could not install Flask automatically
        echo Please install Python from https://www.python.org/downloads/
        echo Make sure to check "Add Python to PATH"
        pause
        exit /b 1
    )
)

echo.
echo Flask installation complete!
echo.

REM Start the web application
echo Starting Todo Web Application...
echo.
echo The application will be available at: http://localhost:5000
echo.
echo Press Ctrl+C to stop the server
echo.

cd "%~dp0web_todo_app"
"%PYTHON_EXE%" app.py

echo.
echo Server stopped
pause