@echo off
setlocal enabledelayedexpansion

echo ========================================
echo      TODO APP - LOCAL SETUP & RUN
echo ========================================
echo.

echo Setting up local environment...
echo.

REM Create local Python directory
set "LOCAL_PYTHON_DIR=%~dp0local_python"
if not exist "%LOCAL_PYTHON_DIR%" mkdir "%LOCAL_PYTHON_DIR%"

echo Checking for portable Python...
set "PORTABLE_PYTHON=%LOCAL_PYTHON_DIR%\python.exe"

if exist "%PORTABLE_PYTHON%" (
    echo Found local Python installation
    goto run_app
)

echo Portable Python not found. Installing...
echo This may take a few minutes...

REM Download and extract portable Python
powershell -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.11.0/python-3.11.0-embed-amd64.zip' -OutFile '%LOCAL_PYTHON_DIR%\python.zip'"
if !errorlevel! neq 0 (
    echo Failed to download Python
    echo Please install Python manually from https://www.python.org/downloads/
    pause
    exit /b 1
)

powershell -Command "Expand-Archive -Path '%LOCAL_PYTHON_DIR%\python.zip' -DestinationPath '%LOCAL_PYTHON_DIR%' -Force"
del "%LOCAL_PYTHON_DIR%\python.zip"

REM Rename python.exe if needed
if not exist "%PORTABLE_PYTHON%" (
    for %%f in ("%LOCAL_PYTHON_DIR%\*.exe") do (
        if /i "%%~nxf" neq "python.exe" (
            ren "%%f" "python.exe"
            goto found_python
        )
    )
)

:found_python
if not exist "%PORTABLE_PYTHON%" (
    echo Could not find Python executable
    pause
    exit /b 1
)

:run_app
echo.
echo Local Python found: %PORTABLE_PYTHON%
echo.

REM Check which app to run
echo Which version would you like to run?
echo 1. Console version (recommended)
echo 2. Web version
echo 3. Both
echo.

choice /c 123 /m "Enter your choice"

if errorlevel 3 goto run_both
if errorlevel 2 goto run_web
if errorlevel 1 goto run_console

:run_console
echo Starting Console Todo App...
cd "%~dp0phase1"
"%PORTABLE_PYTHON%" src/main.py
goto end

:run_web
echo Starting Web Todo App...
cd "%~dp0web_todo_app"
"%PORTABLE_PYTHON%" -m pip install flask
"%PORTABLE_PYTHON%" app.py
goto end

:run_both
echo Starting both versions...
start "" cmd /c "%~dp0local_run.bat console"
timeout /t 2 /nobreak >nul
start "" cmd /c "%~dp0local_run.bat web"
goto end

:end
echo.
echo Application finished
pause