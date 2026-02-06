@echo off
setlocal enabledelayedexpansion

echo ========================================
echo      TODO CONSOLE APPLICATION
echo ========================================
echo.

REM Array of possible Python commands
set python_commands=python python3 py python3.14 python3.13 python3.12 python3.11 python3.10

REM Try each Python command
for %%c in (%python_commands%) do (
    where %%c >nul 2>&1
    if !errorlevel! == 0 (
        echo Found Python: %%c
        %%c main.py
        goto :end
    )
)

REM Try common installation paths
set "common_paths=C:\Python314\python.exe C:\Python313\python.exe C:\Python312\python.exe C:\Python311\python.exe C:\Python310\python.exe"
for %%p in (%common_paths%) do (
    if exist "%%p" (
        echo Found Python: %%p
        "%%p" main.py
        goto :end
    )
)

REM Try AppData local installation
if exist "%LOCALAPPDATA%\Programs\Python" (
    for /D %%d in ("%LOCALAPPDATA%\Programs\Python\*") do (
        if exist "%%d\python.exe" (
            echo Found Python: %%d\python.exe
            "%%d\python.exe" main.py
            goto :end
        )
    )
)

REM Try Chocolatey installation
if exist "C:\ProgramData\chocolatey\bin\python3.14.exe" (
    echo Found Python: C:\ProgramData\chocolatey\bin\python3.14.exe
    "C:\ProgramData\chocolatey\bin\python3.14.exe" main.py
    goto :end
)

echo Error: Python not found
echo.
echo Please install Python 3.7 or later from:
echo https://www.python.org/downloads/
echo.
echo Or add Python to your PATH environment variable
echo.
pause

:end
endlocal