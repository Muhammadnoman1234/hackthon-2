# Todo App Direct Launcher - PowerShell
# Bypasses PATH issues by searching common Python locations

Write-Host "========================================" -ForegroundColor Green
Write-Host "     TODO CONSOLE APP - DIRECT LAUNCH" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

Write-Host "Searching for Python installations..." -ForegroundColor Yellow

# Common Python installation paths
$pythonPaths = @(
    "c:\Users\mn244\Desktop\hackthon 2\local_python\python.exe",
    "C:\Python314\python.exe",
    "C:\Python313\python.exe", 
    "C:\Python312\python.exe",
    "C:\Python311\python.exe",
    "C:\Python310\python.exe",
    "C:\Python314\Lib\python.exe",
    "$env:LOCALAPPDATA\Programs\Python\Python314\python.exe",
    "$env:LOCALAPPDATA\Programs\Python\Python313\python.exe",
    "$env:LOCALAPPDATA\Programs\Python\Python312\python.exe",
    "$env:LOCALAPPDATA\Programs\Python\Python311\python.exe"
)

$pythonFound = $false
$pythonPath = $null

# Check each path
foreach ($path in $pythonPaths) {
    if (Test-Path $path) {
        $pythonPath = $path
        $pythonFound = $true
        Write-Host "Found Python at: $path" -ForegroundColor Green
        break
    }
}

if (-not $pythonFound) {
    Write-Host "Python not found in common locations." -ForegroundColor Red
    Write-Host ""
    Write-Host "Please:" -ForegroundColor Yellow
    Write-Host "1. Install Python from https://www.python.org/downloads/" -ForegroundColor Cyan
    Write-Host "2. Make sure to check 'Add Python to PATH' during installation" -ForegroundColor Cyan
    Write-Host "3. Restart your computer after installation" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Then run this script again." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Press any key to exit..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Run the Todo application
Write-Host ""
Write-Host "Starting Todo Console Application..." -ForegroundColor Green
Write-Host ""

try {
    $mainPath = "C:\Users\$env:USERNAME\Desktop\hackthon 2\phase1\src\main.py"
    if (Test-Path $mainPath) {
        & $pythonPath $mainPath
    } else {
        Write-Host "Error: Could not find main.py at expected location" -ForegroundColor Red
        Write-Host "Expected path: $mainPath" -ForegroundColor Yellow
    }
} catch {
    Write-Host "Error running the application: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "Application finished. Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")