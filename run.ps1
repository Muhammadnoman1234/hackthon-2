# Todo Console App Launcher
# PowerShell script to find and run Python

Write-Host "========================================" -ForegroundColor Green
Write-Host "     TODO CONSOLE APPLICATION" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# List of possible Python executables
$pythonCommands = @("c:\Users\mn244\Desktop\hackthon 2\local_python\python.exe", "python", "python3", "py", "python3.14", "python3.13", "python3.12", "python3.11", "python3.10")

# Try each command
foreach ($cmd in $pythonCommands) {
    try {
        $result = Get-Command $cmd -ErrorAction SilentlyContinue
        if ($result) {
            Write-Host "Found Python: $cmd" -ForegroundColor Yellow
            & $cmd phase1/src/main.py
            exit 0
        }
    } catch {
        continue
    }
}

# Try common installation paths
$commonPaths = @(
    "C:\Python314\python.exe",
    "C:\Python313\python.exe", 
    "C:\Python312\python.exe",
    "C:\Python311\python.exe",
    "C:\Python310\python.exe"
)

foreach ($path in $commonPaths) {
    if (Test-Path $path) {
        Write-Host "Found Python: $path" -ForegroundColor Yellow
        & $path phase1/src/main.py
        exit 0
    }
}

# Try AppData installation
$appDataPath = "$env:LOCALAPPDATA\Programs\Python"
if (Test-Path $appDataPath) {
    $pythonDirs = Get-ChildItem $appDataPath -Directory | Where-Object { $_.Name -like "Python*" }
    foreach ($dir in $pythonDirs) {
        $pythonExe = Join-Path $dir.FullName "python.exe"
        if (Test-Path $pythonExe) {
            Write-Host "Found Python: $pythonExe" -ForegroundColor Yellow
            & $pythonExe phase1/src/main.py
            exit 0
        }
    }
}

# Try Chocolatey
$chocoPath = "C:\ProgramData\chocolatey\bin\python3.14.exe"
if (Test-Path $chocoPath) {
    Write-Host "Found Python: $chocoPath" -ForegroundColor Yellow
    & $chocoPath phase1/src/main.py
    exit 0
}

# If nothing found
Write-Host "Error: Python not found!" -ForegroundColor Red
Write-Host ""
Write-Host "Please install Python 3.7 or later from:" -ForegroundColor Yellow
Write-Host "https://www.python.org/downloads/" -ForegroundColor Cyan
Write-Host ""
Write-Host "Or add Python to your PATH environment variable" -ForegroundColor Yellow
Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")