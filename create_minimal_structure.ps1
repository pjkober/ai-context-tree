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

# Check if templates directory is present
if (-not (Test-Path $TemplatesDir -PathType Container)) {
    Write-Error "Error: 'file-templates/' directory not found at $TemplatesDir."
    Write-Error "This script must be run inside the cloned repository context containing file-templates."
    Write-Error "If you are setting up a new project, copy BOTH this script and the 'file-templates/' directory to your project root."
    exit 1
}


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


# Default values for AI-First rules configuration
$AutonomyModeVal = "- **Consultative Mode:** If you don't know something, see multiple solutions, or encounter ambiguity, STOP and ask the user. Do not make assumptions."
$DependencyPolicyVal = "- **Strict Dependency Policy:** Never add new libraries or dependencies without explicit user permission. Prefer standard/existing project tools."
$ArchitecturePolicyVal = "- **Strict Architecture Scope:** Do not alter the project architecture (e.g., introducing new design patterns, changing database/state-management libraries, or renaming/creating top-level directories) without explicit human confirmation."
$LicensePolicyVal = "- **License Constraints:** You are allowed to introduce dependencies only under strictly permissive licenses: MIT, Apache 2.0, BSD, or Public Domain. Copyleft/viral licenses (such as GPL, AGPL) are strictly forbidden. Refer to the knowledge/licenses.md file for details."
$GitPolicyVal = "- **Git Autonomy:** Do not stage, commit, or push files to Git. Modify the workspace files only and let the human review and commit."
$SafetyPolicyVal = "- **Critical Operations Policy:** You are strictly forbidden from running potentially destructive commands (e.g., database drops/truncates, force pushes, file deletions outside tmp/) without explicit human confirmation. Always ask first."
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

    Write-Host "1.3) Choose AI Architecture Policy:"
    Write-Host "  [1] Strict / Ask-First (AI cannot change patterns/directories/database without approval) [Default]"
    Write-Host "  [2] Flexible (AI can propose and implement minor refactors, but must document)"
    Write-Host "  [3] Full Autonomy / Change Architecture (NOT RECOMMENDED) (AI can fully change architecture and patterns without asking)"
    $opt = Read-Host "Select option [1-3]"
    if ($opt -eq "2") {
        $ArchitecturePolicyVal = "- **Flexible Architecture Scope:** You may suggest and implement minor architectural improvements or helper utilities if they simplify the implementation, but document them in the task summary."
    } elseif ($opt -eq "3") {
        $ArchitecturePolicyVal = "- **Full Architectural Autonomy (NOT RECOMMENDED):** You have full autonomy to make architectural modifications, refactor structural design patterns, or rename/create top-level directories to achieve the task goal."
    }
    Write-Host ""

    Write-Host "1.4) Choose Dependency License Policy:"
    Write-Host "  [1] Permissive Only (MIT, Apache 2.0, BSD, Public Domain) [Default]"
    Write-Host "  [2] Copyleft Tolerant (Permissive + LGPL, MPL)"
    Write-Host "  [3] Any License (No license restrictions)"
    $opt = Read-Host "Select option [1-3]"
    if ($opt -eq "2") {
        $LicensePolicyVal = "- **License Constraints:** You are allowed to introduce dependencies under permissive licenses (MIT, Apache 2.0, BSD, Public Domain) and weak-copyleft licenses (LGPL, MPL). Refer to the knowledge/licenses.md file for details."
    } elseif ($opt -eq "3") {
        $LicensePolicyVal = "- **License Constraints:** No strict license restrictions, but prefer widely-adopted, open-source libraries. Ensure compliance before commercial deployment."
    }
    Write-Host ""

    Write-Host "1.5) Choose Git Autonomy Mode:"
    Write-Host "  [1] None (AI only modifies files; human commits) [Default]"
    Write-Host "  [2] Commit-First (AI commits changes on current branch using Conventional Commits)"
    Write-Host "  [3] Branch-First (AI creates dedicated feature branch and commits there)"
    $opt = Read-Host "Select option [1-3]"
    if ($opt -eq "2") {
        $GitPolicyVal = "- **Git Autonomy:** You are allowed to stage and commit your changes on the current branch. Use Conventional Commits formatting (e.g., `"feat(ui): add button`") for commit messages."
    } elseif ($opt -eq "3") {
        $GitPolicyVal = "- **Git Autonomy:** Create a new feature branch for your changes (e.g., `"feature/task-NNN-desc`") and commit there. Do not commit directly to master/main."
    }
    Write-Host ""

    Write-Host "1.6) Choose Critical Operations / Safety Policy:"
    Write-Host "  [1] Strict Protection (AI forbidden from running destructive commands like DROP/DELETE/force push without asking) [Default]"
    Write-Host "  [2] Collaborative / Loose (AI can run destructive cleanup if task calls for it)"
    $opt = Read-Host "Select option [1-2]"
    if ($opt -eq "2") {
        $SafetyPolicyVal = "- **Critical Operations Policy:** You can perform cleanup actions (like removing obsolete prototype files or database tables) if it is directly required to complete the task."
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
    $Content = $Content -replace "__ARCHITECTURE_POLICY__", $ArchitecturePolicyVal
    $Content = $Content -replace "__LICENSE_POLICY__", $LicensePolicyVal
    $Content = $Content -replace "__GIT_POLICY__", $GitPolicyVal
    $Content = $Content -replace "__SAFETY_POLICY__", $SafetyPolicyVal
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

# --- Post-Setup Cleanup ---
if (-not $NonInteractive) {
    Write-Host ""
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host "   Post-Setup Cleanup" -ForegroundColor Cyan
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host "The initialization script and 'file-templates/' are no longer needed."
    Write-Host "What would you like to do with them?"
    Write-Host "  [1] Move to 'tmp/' directory (recommended, keeps root clean) [Default]"
    Write-Host "  [2] Delete permanently"
    Write-Host "  [3] Keep them in the root directory"
    $opt = Read-Host "Select option [1-3]"
    
    if ($opt -eq "2") {
        Write-Host "Deleting setup script and templates..."
        if (Test-Path $TemplatesDir -PathType Container) {
            Remove-Item -Path $TemplatesDir -Recurse -Force | Out-Null
        }
        try {
            Remove-Item -Path $MyInvocation.MyCommand.Definition -Force -ErrorAction Stop | Out-Null
            Write-Host "Cleanup complete."
        } catch {
            Write-Warning "Could not delete the running script automatically due to file lock. Please delete it manually."
        }
    } elseif ($opt -eq "3") {
        Write-Host "Keeping setup script and templates."
    } else {
        Write-Host "Moving setup script and templates to 'tmp/'..."
        New-DirectoryIfNotExists (Join-Path $BaseDir "tmp")
        if (Test-Path $TemplatesDir -PathType Container) {
            $DestTemplates = Join-Path $BaseDir "tmp/file-templates"
            if (Test-Path $DestTemplates) {
                Remove-Item -Path $DestTemplates -Recurse -Force | Out-Null
            }
            Move-Item -Path $TemplatesDir -Destination (Join-Path $BaseDir "tmp") -Force | Out-Null
        }
        try {
            $DestScript = Join-Path $BaseDir "tmp/$(Split-Path -Leaf $MyInvocation.MyCommand.Definition)"
            if (Test-Path $DestScript) {
                Remove-Item -Path $DestScript -Force | Out-Null
            }
            Move-Item -Path $MyInvocation.MyCommand.Definition -Destination (Join-Path $BaseDir "tmp") -Force -ErrorAction Stop | Out-Null
            Write-Host "Cleanup complete. Files moved to 'tmp/'."
        } catch {
            Write-Warning "Could not move the running script automatically due to file lock. The templates were moved, but please move this script to 'tmp/' manually."
        }
    }
}

