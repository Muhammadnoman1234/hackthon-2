@echo off
setlocal enabledelayedexpansion

echo ========================================
echo      TODO CONSOLE APP - FULL SETUP
echo ========================================
echo.

echo Checking for Python installation...
echo.

REM Check various Python installations
set found_python=
set python_cmd=

REM Try python command
where python >nul 2>&1
if !errorlevel! == 0 (
    set python_cmd=python
    set found_python=yes
    goto python_found
)

REM Try python3 command
where python3 >nul 2>&1
if !errorlevel! == 0 (
    set python_cmd=python3
    set found_python=yes
    goto python_found
)

REM Try py command
where py >nul 2>&1
if !errorlevel! == 0 (
    set python_cmd=py
    set found_python=yes
    goto python_found
)

REM Try specific versions
for %%v in (3.14 3.13 3.12 3.11 3.10) do (
    where python%%v >nul 2>&1
    if !errorlevel! == 0 (
        set python_cmd=python%%v
        set found_python=yes
        goto python_found
    )
)

echo ERROR: Python not found in PATH
echo.
echo Please install Python 3.7 or later from:
echo https://www.python.org/downloads/
echo.
echo During installation, make sure to check:
echo "Add Python to PATH"
echo.
echo After installing Python, run this script again.
echo.
pause
exit /b 1

:python_found
echo Found Python: !python_cmd!
echo Python version:
!python_cmd! --version
echo.

REM Check Python version
for /f "tokens=2" %%v in ('!python_cmd! --version 2^>^&1') do set python_version=%%v
echo Detected Python version: !python_version!

REM Check if Poetry is installed
echo.
echo Checking for Poetry...
where poetry >nul 2>&1
if !errorlevel! == 0 (
    echo Poetry found!
    set poetry_installed=yes
) else (
    echo Poetry not found.
    set poetry_installed=no
)

REM Ask user what to do
echo.
echo What would you like to do?
echo 1. Install Poetry and run with Poetry (recommended)
echo 2. Run directly with Python (standalone version)
echo 3. Just install Poetry
echo 4. Exit
echo.

choice /c 1234 /m "Enter your choice"

if errorlevel 4 goto end
if errorlevel 3 goto install_poetry_only
if errorlevel 2 goto run_standalone
if errorlevel 1 goto install_and_run

:install_poetry_only
if "!poetry_installed!"=="yes" (
    echo Poetry is already installed!
    goto end
)
echo Installing Poetry...
curl -sSL https://install.python-poetry.org | !python_cmd!
if !errorlevel! neq 0 (
    echo Failed to install Poetry
    pause
    exit /b 1
)
echo Poetry installed successfully!
goto end

:install_and_run
if "!poetry_installed!"=="no" (
    echo Installing Poetry...
    curl -sSL https://install.python-poetry.org | !python_cmd!
    if !errorlevel! neq 0 (
        echo Failed to install Poetry
        pause
        exit /b 1
    )
    echo Poetry installed successfully!
)

echo.
echo Installing project dependencies...
cd phase1
poetry install
if !errorlevel! neq 0 (
    echo Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo Starting Todo Console App with Poetry...
poetry run python src/main.py
goto end

:run_standalone
echo.
echo Starting Todo Console App directly...
cd ..
!python_cmd! main.py
goto end

:end
echo.
echo Setup complete!
pause