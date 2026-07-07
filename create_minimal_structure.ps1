# Script to create minimal project structure as defined in ai-context-tree
# ------------------------------------------------------------
$ErrorActionPreference = "Stop"

# Determine the directory where this script lives
$BaseDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
if (-not $BaseDir) { $BaseDir = Get-Location }
$TemplatesDir = Join-Path $BaseDir "file-templates"

# Helper to create a directory if it does not exist
function New-DirectoryIfNotExists {
    param([string]$Path)
    if (-not (Test-Path $Path -PathType Container)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-Host "Created directory: $Path"
    } else {
        Write-Host "Directory already exists: $Path"
    }
}

# Helper to copy template file if it does not exist in target location
function Copy-TemplateFile {
    param([string]$RelPath)
    $SrcFile = Join-Path $TemplatesDir $RelPath
    $DestFile = Join-Path $BaseDir $RelPath

    # Ensure destination directory exists
    $DestParent = Split-Path -Parent $DestFile
    New-DirectoryIfNotExists $DestParent

    if (-not (Test-Path $DestFile -PathType Leaf)) {
        if (Test-Path $SrcFile -PathType Leaf) {
            Copy-Item -Path $SrcFile -Destination $DestFile -Force
            Write-Host "Copied template to: $DestFile"
        } else {
            Write-Warning "Template source file missing: $SrcFile"
        }
    } else {
        Write-Host "File already exists, skipping: $DestFile"
    }
}

# Check if templates directory is present
if (-not (Test-Path $TemplatesDir -PathType Container)) {
    Write-Error "Error: 'file-templates/' directory not found at $TemplatesDir."
    Write-Error "This script must be run inside the cloned repository context containing file-templates."
    exit 1
}

# Create minimal directories
New-DirectoryIfNotExists (Join-Path $BaseDir "docs")
New-DirectoryIfNotExists (Join-Path $BaseDir "src")
New-DirectoryIfNotExists (Join-Path $BaseDir "tests")

# Copy minimal files from templates
Copy-TemplateFile "AGENTS.md"
Copy-TemplateFile "README.md"
Copy-TemplateFile ".gitignore"
Copy-TemplateFile "MANIFEST.md"
Copy-TemplateFile "ai/context/project.md"
Copy-TemplateFile "ai/context/structure-map.md"
Copy-TemplateFile "ai/rules/coding.md"
Copy-TemplateFile "ai/workflows/new-feature.md"

Write-Host "Minimal project structure created successfully."
