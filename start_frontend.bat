@echo off
echo ========================================
echo      TODO FRONTEND APPLICATION
echo ========================================
echo.
echo Installing dependencies and starting frontend...
cd frontend
call npm install
call npm run dev
pause
