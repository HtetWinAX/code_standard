# install-precommit.ps1
# Windows PowerShell script to install pre-commit hook

# Ensure git hooks directory exists
$hooksDir = ".git/hooks"
if (-not (Test-Path $hooksDir)) {
    New-Item -ItemType Directory -Path $hooksDir | Out-Null
}

# Copy pre-commit hook
Copy-Item -Path "git_hooks/pre-commit" -Destination "$hooksDir/pre-commit" -Force

# On Windows, chmod is not needed; Git for Windows recognizes hooks if file exists
Write-Host "✅ Pre-commit hook installed!"

