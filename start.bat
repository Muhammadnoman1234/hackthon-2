@echo off
echo ========================================
echo   TASKFLOW AI - FULL STACK STARTUP
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

REM Check if Python is installed
set PYTHON_CMD=
where python >nul 2>&1
if %errorlevel% == 0 (
    set PYTHON_CMD=python
) else (
    where py >nul 2>&1
    if %errorlevel% == 0 (
        set PYTHON_CMD=py
    ) else (
        where python3 >nul 2>&1
        if %errorlevel% == 0 (
            set PYTHON_CMD=python3
        ) else (
            echo [ERROR] Python is not installed!
            echo Please install Python from https://www.python.org/
            pause
            exit /b 1
        )
    )
)

echo [OK] Node.js found: 
node --version
echo [OK] Python found: 
%PYTHON_CMD% --version
echo.

REM Install frontend dependencies if needed
echo ========================================
echo   STEP 1: Frontend Setup
echo ========================================
cd frontend
if not exist "node_modules\" (
    echo Installing frontend dependencies...
    call npm install
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to install frontend dependencies
        pause
        exit /b 1
    )
) else (
    echo Frontend dependencies already installed
)
echo.

REM Install backend dependencies if needed
echo ========================================
echo   STEP 2: Backend Setup
echo ========================================
cd ..\backend
if not exist "venv\" (
    echo Creating Python virtual environment...
    %PYTHON_CMD% -m venv venv
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to create virtual environment
        pause
        exit /b 1
    )
)

echo Activating virtual environment...
call venv\Scripts\activate.bat

echo Installing backend dependencies...
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install backend dependencies
    pause
    exit /b 1
)
echo.

REM Start both servers
echo ========================================
echo   STEP 3: Starting Servers
echo ========================================
echo.
echo Starting Backend Server (Port 8000)...
cd ..
start "TaskFlow Backend" cmd /k "cd backend && venv\Scripts\activate.bat && uvicorn main:app --reload --host 0.0.0.0 --port 8000"

timeout /t 3 /nobreak >nul

echo Starting Frontend Server (Port 3000)...
start "TaskFlow Frontend" cmd /k "cd frontend && npm run dev"

echo.
echo ========================================
echo   SERVERS STARTED!
echo ========================================
echo.
echo Frontend: http://localhost:3000
echo Backend:  http://localhost:8000
echo API Docs: http://localhost:8000/docs
echo.
echo Press any key to stop all servers...
pause >nul

REM Kill the servers
taskkill /FI "WindowTitle eq TaskFlow Backend*" /T /F >nul 2>&1
taskkill /FI "WindowTitle eq TaskFlow Frontend*" /T /F >nul 2>&1

echo.
echo All servers stopped.
pause
