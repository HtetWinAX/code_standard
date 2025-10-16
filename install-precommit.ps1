# install-precommit.ps1
# Windows PowerShell script to install AND convert pre-commit hook

# Configuration
$SourceHook = "git_hooks/pre-commit"
$DestHook = ".git/hooks/pre-commit"

Write-Host "🚀 Installing Odoo pre-commit hook..." -ForegroundColor Cyan

# Step 1: Check if source hook exists
if (-not (Test-Path $SourceHook)) {
    Write-Host "❌ Source pre-commit hook not found: $SourceHook" -ForegroundColor Red
    Write-Host "💡 Create the git_hooks/pre-commit file first" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Source hook found: $SourceHook" -ForegroundColor Green

# Step 2: Ensure git hooks directory exists
$hooksDir = ".git/hooks"
if (-not (Test-Path $hooksDir)) {
    Write-Host "📁 Creating hooks directory..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $hooksDir | Out-Null
    Write-Host "✅ Hooks directory created" -ForegroundColor Green
}

# Step 3: Convert line endings to Windows format
Write-Host "🔧 Converting to Windows format..." -ForegroundColor Yellow

try {
    # Read the source file
    $content = Get-Content $SourceHook -Raw
    
    # Convert Unix line endings (LF) to Windows (CRLF)
    $content = $content -replace "`n", "`r`n"
    
    # Write the converted file
    Set-Content -Path $DestHook -Value $content -NoNewline -Encoding UTF8
    
    Write-Host "✅ Line endings converted (LF → CRLF)" -ForegroundColor Green
}
catch {
    Write-Host "❌ Conversion failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Step 4: Verify the installation
if (Test-Path $DestHook) {
    $fileInfo = Get-Item $DestHook
    $lineCount = (Get-Content $DestHook).Length
    
    Write-Host "✅ Pre-commit hook installed successfully!" -ForegroundColor Green
    Write-Host "📊 Details:" -ForegroundColor Cyan
    Write-Host "   📍 Location: $DestHook" -ForegroundColor White
    Write-Host "   📏 Size: $($fileInfo.Length) bytes" -ForegroundColor White
    Write-Host "   📄 Lines: $lineCount" -ForegroundColor White
    Write-Host "   🖥️  Format: Windows (CRLF)" -ForegroundColor White
}
else {
    Write-Host "❌ Installation failed - file not created" -ForegroundColor Red
    exit 1
}

# Step 5: Test if hook is executable
Write-Host "`n🔍 Testing hook execution..." -ForegroundColor Cyan

try {
    # Test if we can read the first line (shebang)
    $firstLine = Get-Content $DestHook -First 1
    if ($firstLine -match "^#!/") {
        Write-Host "✅ Shebang detected: $firstLine" -ForegroundColor Green
    }
    
    
    Write-Host "`n🎉 Pre-commit hook ready for use!" -ForegroundColor Green
    Write-Host "💡 Next: Run 'git commit' to test the hook" -ForegroundColor Yellow
}
catch {
    Write-Host "⚠️  Warning: Could not verify hook properly" -ForegroundColor Yellow
    Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n🎯 Installation completed!" -ForegroundColor Green
