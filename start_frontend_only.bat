@echo off
echo ========================================
echo   TASKFLOW AI - FRONTEND ONLY
echo ========================================
echo.

REM Check if Node.js is installed
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Node.js is not installed!
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

echo [OK] Node.js found: 
node --version
echo.

cd frontend

REM Install dependencies if needed
if not exist "node_modules\" (
    echo Installing dependencies...
    call npm install
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to install dependencies
        pause
        exit /b 1
    )
) else (
    echo Dependencies already installed
)
echo.

echo ========================================
echo   Starting Frontend Server...
echo ========================================
echo.
echo Frontend will be available at: http://localhost:3000
echo.

npm run dev

pause
