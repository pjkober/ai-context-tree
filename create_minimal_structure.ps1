[CmdletBinding()]
param(
    [switch]$NonInteractive
)

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

# Default values for AI-First rules configuration
$AutonomyModeVal = "- **Consultative Mode:** If you don't know something, see multiple solutions, or encounter ambiguity, STOP and ask the user. Do not make assumptions."
$DependencyPolicyVal = "- **Strict Dependency Policy:** Never add new libraries or dependencies without explicit user permission. Prefer standard/existing project tools."
$RefactoringPolicyVal = "- **Strict Scope:** Modify only lines and files directly related to the requested task. Do not clean up unrelated code or formatting."
$TestingCoverageVal = "- **Testing Coverage:** Write tests only for the key/critical codebase functionality. Do not waste time on 100% coverage of minor helper functions."
$TestingApproachVal = "- **Testing Approach:** Write tests post-implementation (after coding features)."
$TestExecutionScopeVal = "- **Test Execution Scope:** Run only relevant unit tests related to modified or new code files during local iterations."
$TechStackVal = "- Stack: General / To be defined later.`n- Adhere to the existing coding style of any file you edit."

# Check if interactive
if (-not $NonInteractive) {
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host "   AI-First Project Rule Configuration Wizard" -ForegroundColor Cyan
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host ""
    
    # --- SECTION 1: Autonomy & Decisions ---
    Write-Host "--- SECTION 1: Autonomy & Decisions ---" -ForegroundColor Yellow
    Write-Host "1.1) Choose AI Autonomy Mode:"
    Write-Host "  [1] Consultative / Ask-First (AI stops and asks if unsure) [Default]"
    Write-Host "  [2] Autonomous / Proactive (AI decides and implements, explains later)"
    Write-Host "  [3] Plan-First (AI writes a plan for approval first)"
    $opt = Read-Host "Select option [1-3]"
    if ($opt -eq "2") {
        $AutonomyModeVal = "- **Autonomous Mode:** If you encounter ambiguity, decide what is best based on your senior expertise, implement it, and explain your choice in the summary. Ask only when blocked."
    } elseif ($opt -eq "3") {
        $AutonomyModeVal = "- **Plan-First Mode:** For any non-trivial changes, write an implementation plan first, present it to the user for approval, and wait for confirmation before writing code."
    }
    Write-Host ""

    Write-Host "1.2) Choose Dependency Policy:"
    Write-Host "  [1] Strict / Ask-First (AI must ask before installing packages) [Default]"
    Write-Host "  [2] Proactive (AI can install standard packages if needed)"
    $opt = Read-Host "Select option [1-2]"
    if ($opt -eq "2") {
        $DependencyPolicyVal = "- **Proactive Dependency Policy:** You can install standard, widely-used packages if they are necessary for the implementation, but inform the user in the summary."
    }
    Write-Host ""

    # --- SECTION 2: Coding & Refactoring ---
    Write-Host "--- SECTION 2: Coding & Refactoring ---" -ForegroundColor Yellow
    Write-Host "2.1) Choose Refactoring Policy:"
    Write-Host "  [1] Strict Scope (AI only touches what's requested) [Default]"
    Write-Host "  [2] Boy Scout Rule (AI cleans up minor smells in edited files)"
    $opt = Read-Host "Select option [1-2]"
    if ($opt -eq "2") {
        $RefactoringPolicyVal = "- **Boy Scout Rule:** Proactively clean up minor code smells, formatting issues, or type safety gaps in files you are already modifying, as long as it does not expand the scope excessively."
    }
    Write-Host ""

    # --- SECTION 3: Testing Strategy ---
    Write-Host "--- SECTION 3: Testing Strategy ---" -ForegroundColor Yellow
    Write-Host "3.1) Choose Testing Coverage Policy:"
    Write-Host "  [1] Critical Path only (Write tests only for key logic/critical paths) [Default]"
    Write-Host "  [2] None (Skip tests for maximum speed)"
    Write-Host "  [3] Full Coverage (Task is complete only when fully covered and tests pass)"
    $opt = Read-Host "Select option [1-3]"
    if ($opt -eq "2") {
        $TestingCoverageVal = "- **Testing Coverage:** No tests are required for this project. Focus entirely on speed and coding."
    } elseif ($opt -eq "3") {
        $TestingCoverageVal = "- **Testing Coverage:** Full test coverage is required. A task or feature is only complete when it has thorough unit/integration tests covering all new paths, and all tests pass."
    }
    Write-Host ""

    Write-Host "3.2) Choose Testing Approach:"
    Write-Host "  [1] Write-After / Post-Implementation (Write tests after implementation) [Default]"
    Write-Host "  [2] TDD / Test-First (Write tests before implementation)"
    $opt = Read-Host "Select option [1-2]"
    if ($opt -eq "2") {
        $TestingApproachVal = "- **Testing Approach:** Follow Test-Driven Development (TDD) principles. Write failing tests before writing the implementation."
    }
    Write-Host ""

    Write-Host "3.3) Choose Test Execution Scope:"
    Write-Host "  [1] Unit Tests only (Run single unit tests related to changed code) [Default]"
    Write-Host "  [2] Module / Integration Tests (Run unit and integration tests for the module)"
    Write-Host "  [3] Full Suite (Run the entire test suite on every change)"
    $opt = Read-Host "Select option [1-3]"
    if ($opt -eq "2") {
        $TestExecutionScopeVal = "- **Test Execution Scope:** Run unit and module integration tests for the current feature scope during iterations."
    } elseif ($opt -eq "3") {
        $TestExecutionScopeVal = "- **Test Execution Scope:** Run the entire test suite of the repository to ensure no regressions on every meaningful code change."
    }
    Write-Host ""

    # --- SECTION 4: Tech Stack ---
    Write-Host "--- SECTION 4: Tech Stack ---" -ForegroundColor Yellow
    Write-Host "4.1) Select Tech Stack / Framework:"
    Write-Host "  [1] Node.js / TypeScript"
    Write-Host "  [2] Python"
    Write-Host "  [3] Go"
    Write-Host "  [4] React / Next.js"
    Write-Host "  [5] Decide later / I'll customize it later [Default]"
    $opt = Read-Host "Select option [1-5]"
    switch ($opt) {
        "1" {
            $TechStackVal = "- Stack: Node.js / TypeScript.`n- Use strict TypeScript configurations.`n- Prefer async/await over raw Promises.`n- Avoid using ``any`` type annotations; define interfaces or types."
        }
        "2" {
            $TechStackVal = "- Stack: Python.`n- Adhere to PEP 8 standards.`n- Use type hints for all public function signatures.`n- Prefer list comprehensions and generator expressions where readable."
        }
        "3" {
            $TechStackVal = "- Stack: Go.`n- Use standard Go conventions (``gofmt``, ``go lint``).`n- Explicitly handle all errors; do not ignore them.`n- Keep packages cohesive and API surfaces clean."
        }
        "4" {
            $TechStackVal = "- Stack: React / Next.js.`n- Use functional components with hooks.`n- Keep components small, reusable, and state localized.`n- Follow Next.js directory and routing conventions."
        }
    }
    Write-Host ""
}

# Helper to generate file with user preferences replaced
function Generate-FromTemplate {
    param(
        [string]$TemplatePath,
        [string]$DestPath
    )
    $Content = Get-Content $TemplatePath -Raw
    $Content = $Content -replace "__AUTONOMY_MODE__", $AutonomyModeVal
    $Content = $Content -replace "__DEPENDENCY_POLICY__", $DependencyPolicyVal
    $Content = $Content -replace "__REFACTORING_POLICY__", $RefactoringPolicyVal
    $Content = $Content -replace "__TESTING_COVERAGE__", $TestingCoverageVal
    $Content = $Content -replace "__TESTING_APPROACH__", $TestingApproachVal
    $Content = $Content -replace "__TEST_EXECUTION_SCOPE__", $TestExecutionScopeVal
    $Content = $Content -replace "__TECH_STACK__", $TechStackVal
    $Content | Set-Content $DestPath -NoNewline
}

function Generate-RulesFile {
    param([string]$RelPath)
    $SrcFile = Join-Path $TemplatesDir $RelPath
    $DestFile = Join-Path $BaseDir $RelPath

    $DestParent = Split-Path -Parent $DestFile
    New-DirectoryIfNotExists $DestParent

    if (-not (Test-Path $DestFile -PathType Leaf)) {
        if (Test-Path $SrcFile -PathType Leaf) {
            Generate-FromTemplate -TemplatePath $SrcFile -DestPath $DestFile
            Write-Host "Generated rules file: $DestFile"
        } else {
            Write-Warning "Template source file missing: $SrcFile"
        }
    } else {
        Write-Host "File already exists, skipping: $DestFile"
    }
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
Copy-TemplateFile "ai/workflows/new-feature.md"
Copy-TemplateFile "ai/skills/example-skill.md"
Copy-TemplateFile "ai/history/conver-001-example-transcript.md"
Copy-TemplateFile "ai/runs/run-001-example-automation.sh"

# Generate dynamically configured rules
Generate-RulesFile "ai/rules/coding.md"
Generate-RulesFile "ai/rules/security.md"
Generate-RulesFile "ai/rules/testing.md"

Write-Host "Minimal project structure created successfully."
