# setup-wsl.ps1 - Automates WSL Ubuntu install and tool setup on Windows 11

# Check if running as Admin
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run this script as Administrator." -ForegroundColor Red
    exit
}

# Enable WSL if not already
wsl --install -d Ubuntu
Write-Host "WSL and Ubuntu installed. Restart if prompted, then re-run this script." -ForegroundColor Yellow

# Wait for WSL to be ready (manual restart may be needed)
Start-Sleep -Seconds 10

# Set WSL2 as default
wsl --set-default-version 2

# Launch Ubuntu and run the bash script (assumes install-tools.sh is in the same directory)
$scriptPath = Join-Path $PSScriptRoot "install-tools.sh"
wsl -d Ubuntu -u root bash -c "apt update && apt install -y curl"  # Ensure curl is available
wsl -d Ubuntu bash $scriptPath

Write-Host "Setup complete! Open Ubuntu from Start menu and verify with version commands." -ForegroundColor Green
