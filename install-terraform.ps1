# Terraform Installation Script for Windows
# This script automates the extraction and PATH setup

Write-Host "Terraform Installation Script" -ForegroundColor Cyan
Write-Host "================================`n" -ForegroundColor Cyan

# Define paths
$downloadPath = "$env:USERPROFILE\Downloads\terraform_1.14.3_windows_amd64.zip"
$installPath = "C:\terraform"
$executablePath = "$installPath\terraform.exe"

# Check if ZIP file exists
if (-not (Test-Path $downloadPath)) {
    Write-Host "ERROR: Terraform ZIP file not found in Downloads folder." -ForegroundColor Red
    Write-Host "Expected: $downloadPath" -ForegroundColor Yellow
    Write-Host "`nPlease ensure the file is downloaded first." -ForegroundColor Yellow
    exit 1
}

Write-Host "✓ Found Terraform ZIP file" -ForegroundColor Green

# Create installation directory
if (-not (Test-Path $installPath)) {
    Write-Host "Creating installation directory: $installPath" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $installPath -Force | Out-Null
    Write-Host "✓ Created installation directory" -ForegroundColor Green
} else {
    Write-Host "✓ Installation directory already exists" -ForegroundColor Green
}

# Extract ZIP file
Write-Host "`nExtracting Terraform..." -ForegroundColor Yellow
try {
    Expand-Archive -Path $downloadPath -DestinationPath $installPath -Force
    Write-Host "✓ Extraction complete" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Failed to extract ZIP file" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}

# Verify terraform.exe exists
if (Test-Path $executablePath) {
    Write-Host "✓ terraform.exe found at $executablePath" -ForegroundColor Green
} else {
    Write-Host "ERROR: terraform.exe not found after extraction" -ForegroundColor Red
    exit 1
}

# Add to PATH
Write-Host "`nAdding Terraform to system PATH..." -ForegroundColor Yellow

$currentPath = [Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)

if ($currentPath -like "*$installPath*") {
    Write-Host "✓ Terraform is already in system PATH" -ForegroundColor Green
} else {
    try {
        # Requires administrator privileges
        $newPath = "$currentPath;$installPath"
        [Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::Machine)
        Write-Host "✓ Added to system PATH" -ForegroundColor Green
        Write-Host "  Note: Restart your terminal for PATH changes to take effect" -ForegroundColor Yellow
    } catch {
        Write-Host "WARNING: Could not modify system PATH (requires admin privileges)" -ForegroundColor Yellow
        Write-Host "You can add manually: Go to System Properties → Environment Variables → Path → Add: $installPath" -ForegroundColor Yellow
    }
}

# Update current session PATH
$env:Path = "$env:Path;$installPath"

# Test installation
Write-Host "`nTesting Terraform installation..." -ForegroundColor Yellow
try {
    $version = & "$executablePath" --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Terraform is working!" -ForegroundColor Green
        Write-Host "`n$version" -ForegroundColor Cyan
    } else {
        Write-Host "ERROR: Terraform execution failed" -ForegroundColor Red
    }
} catch {
    Write-Host "ERROR: Could not execute Terraform" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
}

Write-Host "`n================================" -ForegroundColor Cyan
Write-Host "Installation Complete!" -ForegroundColor Green
Write-Host "================================`n" -ForegroundColor Cyan

Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Close and reopen your terminal (to refresh PATH)" -ForegroundColor White
Write-Host "2. Run: terraform --version" -ForegroundColor White
Write-Host "3. Start building infrastructure as code!`n" -ForegroundColor White
