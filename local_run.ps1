# Todo App Local Runner - PowerShell Version
# Creates local Python environment and runs the application

param(
    [Parameter(Position=0)]
    [ValidateSet("console", "web", "both")]
    [string]$Mode = "console"
)

Write-Host "========================================" -ForegroundColor Green
Write-Host "     TODO APP - LOCAL SETUP & RUN" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Set up local environment
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$localPythonDir = Join-Path $scriptDir "local_python"
$pythonExe = Join-Path $localPythonDir "python.exe"

Write-Host "Setting up local environment..." -ForegroundColor Yellow

# Create local Python directory if it doesn't exist
if (!(Test-Path $localPythonDir)) {
    New-Item -ItemType Directory -Path $localPythonDir -Force | Out-Null
    Write-Host "Created local Python directory: $localPythonDir" -ForegroundColor Green
}

# Check if Python exists locally
if (Test-Path $pythonExe) {
    Write-Host "Found local Python installation" -ForegroundColor Green
} else {
    Write-Host "Downloading portable Python..." -ForegroundColor Yellow
    
    try {
        # Download Python embeddable package
        $pythonUrl = "https://www.python.org/ftp/python/3.11.0/python-3.11.0-embed-amd64.zip"
        $zipFile = Join-Path $localPythonDir "python.zip"
        
        Write-Host "Downloading Python 3.11.0..." -ForegroundColor Yellow
        Invoke-WebRequest -Uri $pythonUrl -OutFile $zipFile -ErrorAction Stop
        
        Write-Host "Extracting Python..." -ForegroundColor Yellow
        Expand-Archive -Path $zipFile -DestinationPath $localPythonDir -Force
        Remove-Item $zipFile -Force
        
        # Find and rename python executable
        $pythonFiles = Get-ChildItem $localPythonDir -Filter "*.exe" -Recurse
        if ($pythonFiles.Count -gt 0) {
            $pythonFile = $pythonFiles[0]
            if ($pythonFile.Name -ne "python.exe") {
                Rename-Item $pythonFile.FullName "python.exe" -Force
            }
        }
        
        Write-Host "Python installation complete!" -ForegroundColor Green
    } catch {
        Write-Host "Failed to download/install Python: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "Please install Python manually from https://www.python.org/downloads/" -ForegroundColor Yellow
        Write-Host "Make sure to check 'Add Python to PATH' during installation" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Press any key to exit..." -ForegroundColor Gray
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        exit 1
    }
}

# Verify Python works
try {
    $pythonVersion = & $pythonExe --version 2>&1
    Write-Host "Python version: $pythonVersion" -ForegroundColor Yellow
} catch {
    Write-Host "Python installation verification failed" -ForegroundColor Red
    exit 1
}

# Run the application based on mode
switch ($Mode) {
    "console" {
        Write-Host ""
        Write-Host "Starting Console Todo App..." -ForegroundColor Green
        Write-Host ""
        
        $mainPath = Join-Path $scriptDir "phase1/src/main.py"
        if (Test-Path $mainPath) {
            Set-Location (Join-Path $scriptDir "phase1")
            & $pythonExe "src/main.py"
        } else {
            Write-Host "Error: Could not find main.py at $mainPath" -ForegroundColor Red
        }
    }
    
    "web" {
        Write-Host ""
        Write-Host "Starting Web Todo App..." -ForegroundColor Green
        Write-Host "Installing Flask..." -ForegroundColor Yellow
        
        # Install Flask
        & $pythonExe -m pip install flask
        
        Write-Host "Starting Flask server..." -ForegroundColor Yellow
        Write-Host "Access the web app at: http://localhost:5000" -ForegroundColor Cyan
        Write-Host ""
        
        $appPath = Join-Path $scriptDir "web_todo_app/app.py"
        if (Test-Path $appPath) {
            Set-Location (Join-Path $scriptDir "web_todo_app")
            & $pythonExe "app.py"
        } else {
            Write-Host "Error: Could not find app.py at $appPath" -ForegroundColor Red
        }
    }
    
    "both" {
        Write-Host ""
        Write-Host "Starting both versions..." -ForegroundColor Green
        Write-Host ""
        
        # Start console version in new window
        Start-Process powershell -ArgumentList "-File", $MyInvocation.MyCommand.Path, "console"
        
        Start-Sleep -Seconds 2
        
        # Start web version in new window
        Start-Process powershell -ArgumentList "-File", $MyInvocation.MyCommand.Path, "web"
    }
}

Write-Host ""
Write-Host "Application finished. Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")