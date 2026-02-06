# Todo Web App - Fixed Local Version
# Properly installs Flask and runs web server

Write-Host "========================================" -ForegroundColor Green
Write-Host "     TODO WEB APP - FIXED LOCAL SETUP" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Set up paths
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$pythonExe = Join-Path $scriptDir "local_python\python.exe"
$webAppDir = Join-Path $scriptDir "web_todo_app"
$appPath = Join-Path $webAppDir "app.py"

Write-Host "Using local Python: $pythonExe" -ForegroundColor Yellow
Write-Host ""

# Check if Python exists
if (!(Test-Path $pythonExe)) {
    Write-Host "Error: Local Python not found" -ForegroundColor Red
    Write-Host "Please run local_run.ps1 first to set up local Python" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Press any key to exit..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Verify Python works
Write-Host "Checking Python installation..." -ForegroundColor Yellow
try {
    $pythonVersion = & $pythonExe --version 2>&1
    Write-Host "Python version: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: Python not working properly" -ForegroundColor Red
    Write-Host ""
    Write-Host "Press any key to exit..." -ForegroundColor Gray
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Host ""
Write-Host "Setting up web environment..." -ForegroundColor Yellow

# Try to install pip if it doesn't exist
Write-Host "Checking for pip..." -ForegroundColor Yellow
try {
    $pipCheck = & $pythonExe -m pip --version 2>$null
    Write-Host "Pip is already installed" -ForegroundColor Green
} catch {
    Write-Host "Installing pip..." -ForegroundColor Yellow
    try {
        $pipScript = Join-Path $scriptDir "get-pip.py"
        Invoke-WebRequest -Uri "https://bootstrap.pypa.io/get-pip.py" -OutFile $pipScript
        & $pythonExe $pipScript
        Remove-Item $pipScript -Force
        Write-Host "Pip installed successfully" -ForegroundColor Green
    } catch {
        Write-Host "Failed to install pip automatically" -ForegroundColor Red
        Write-Host "Please install Python from https://www.python.org/downloads/" -ForegroundColor Yellow
        Write-Host "Make sure to check 'Add Python to PATH'" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Press any key to exit..." -ForegroundColor Gray
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        exit 1
    }
}

# Install Flask
Write-Host "Installing Flask..." -ForegroundColor Yellow
try {
    & $pythonExe -m pip install flask --quiet
    Write-Host "Flask installed successfully" -ForegroundColor Green
} catch {
    Write-Host "Failed to install Flask with pip" -ForegroundColor Red
    Write-Host "Trying alternative installation method..." -ForegroundColor Yellow
    
    try {
        & $pythonExe -m pip install --user flask --quiet
        Write-Host "Flask installed with user flag" -ForegroundColor Green
    } catch {
        Write-Host "Could not install Flask automatically" -ForegroundColor Red
        Write-Host "Please install Python from https://www.python.org/downloads/" -ForegroundColor Yellow
        Write-Host "Make sure to check 'Add Python to PATH'" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Press any key to exit..." -ForegroundColor Gray
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        exit 1
    }
}

Write-Host ""
Write-Host "Flask installation complete!" -ForegroundColor Green
Write-Host ""

# Start the web application
Write-Host "Starting Todo Web Application..." -ForegroundColor Green
Write-Host ""
Write-Host "The application will be available at: http://localhost:5000" -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

# Change to web app directory and start server
if (Test-Path $appPath) {
    Set-Location $webAppDir
    try {
        Write-Host "Web server starting..." -ForegroundColor Yellow
        & $pythonExe "app.py"
    } catch {
        Write-Host "Error running web application: $($_.Exception.Message)" -ForegroundColor Red
    }
} else {
    Write-Host "Error: Could not find app.py at $appPath" -ForegroundColor Red
}

Write-Host ""
Write-Host "Server stopped" -ForegroundColor Yellow
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")