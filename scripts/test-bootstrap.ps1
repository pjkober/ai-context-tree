# test-bootstrap.ps1
# Integration test for create_minimal_structure.ps1
# Usage: pwsh ./scripts/test-bootstrap.ps1

$ErrorActionPreference = "Stop"

# Get absolute path of standard project root
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
if (-not $ScriptDir) { $ScriptDir = Get-Location }
$RootDir = Split-Path -Parent $ScriptDir

$Script = Join-Path $RootDir "create_minimal_structure.ps1"
$TestDir = Join-Path $RootDir "tmp/test-bootstrap-temp-ps"
if (Test-Path $TestDir) { Remove-Item -Path $TestDir -Recurse -Force | Out-Null }
New-Item -ItemType Directory -Path $TestDir | Out-Null
$Failures = 0

Write-Host "=== Bootstrap Integration Test (PowerShell) ==="
Write-Host "Test directory: $TestDir"
Write-Host ""

# Copy script and templates to test directory (simulating user setup)
Write-Host "[1/4] Copying script and templates to test directory..."
Copy-Item -Path $Script -Destination $TestDir\ | Out-Null
Copy-Item -Path (Join-Path $RootDir "VERSION") -Destination $TestDir\ | Out-Null
Copy-Item -Path (Join-Path $RootDir "templates") -Destination $TestDir\ -Recurse -Force | Out-Null

# Run the script in non-interactive mode inside the test directory
Write-Host "[2/4] Running bootstrap script in non-interactive mode..."
$oldLocation = Get-Location
Set-Location $TestDir
try {
    pwsh -File ./create_minimal_structure.ps1 -NonInteractive > $null 2>&1
} catch {
    # Ignore script exit error during execution
}
Set-Location $oldLocation
Write-Host "      EXIT CODE: $LASTEXITCODE (expected: 0)"

# Check required files exist
Write-Host "[3/4] Checking required files and directories..."

$Required = @(
    "AGENTS.md",
    "MANIFEST.md",
    "SECURITY.md",
    "VERSION",
    "ai/context/project.md",
    "ai/context/structure-map.md",
    "ai/rules/coding.md",
    "ai/rules/security.md",
    "ai/rules/testing.md",
    "ai/workflows/new-feature.md",
    "tasks.md",
    "tmp/.gitkeep"
)

foreach ($item in $Required) {
    $filePath = Join-Path $TestDir $item
    if (Test-Path $filePath) {
        Write-Host "      OK:      $item"
    } else {
        Write-Host "      MISSING: $item"
        $Failures++
    }
}

# Check no placeholder tokens remain
Write-Host "[4/4] Checking for leftover __PLACEHOLDER__ tokens..."
$placeholdersFound = 0
Get-ChildItem -Path $TestDir -Filter "*.md" -Recurse | ForEach-Object {
    $matches = Select-String -Path $_.FullName -Pattern "__[A-Z_]+__"
    if ($matches) {
        Write-Host "      FAIL: $($_.Name) contains unsubstituted placeholders:"
        $matches | ForEach-Object { Write-Host "            $($_.Line)" }
        $placeholdersFound++
    }
}

if ($placeholdersFound -eq 0) {
    Write-Host "      OK: No placeholder tokens found."
} else {
    $Failures++
}

# Summary
Write-Host ""
Write-Host "=== Results ==="
if (Test-Path $TestDir) { Remove-Item -Path $TestDir -Recurse -Force | Out-Null }

if ($Failures -eq 0) {
    Write-Host "PASSED: All checks passed."
    exit 0
} else {
    Write-Host "FAILED: $Failures check(s) failed."
    exit 1
}
