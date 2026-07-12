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
$TemplatesDir = Join-Path $BaseDir "templates"

# Check if templates directory is present
if (-not (Test-Path $TemplatesDir -PathType Container)) {
    Write-Error "Error: 'templates/' directory not found at $TemplatesDir."
    Write-Error "This script must be run inside the cloned repository context containing templates."
    Write-Error "If you are setting up a new project, copy BOTH this script and the 'templates/' directory to your project root."
    exit 1
}

# Determine default project name based on the target/base directory name
$ResolvedBaseDir = Resolve-Path $BaseDir
$BaseDirName = (Get-Item $ResolvedBaseDir).Name
$DefaultProjectName = $BaseDirName -replace '[^a-zA-Z0-9 _.-]', ''
if ($DefaultProjectName.Length -gt 50) {
    $DefaultProjectName = $DefaultProjectName.Substring(0, 50)
}
if ([string]::IsNullOrWhiteSpace($DefaultProjectName)) {
    $DefaultProjectName = "my-project"
}
$ProjectName = $DefaultProjectName

function Get-ValidatedChoice {
    param (
        [string]$PromptText,
        [int]$DefaultVal,
        [int]$MaxVal
    )
    while ($true) {
        $opt = Read-Host "$PromptText [Default: $DefaultVal]"
        if ([string]::IsNullOrWhiteSpace($opt)) {
            return $DefaultVal
        }
        if ($opt -match '^\d+$') {
            $val = [int]$opt
            if ($val -ge 1 -and $val -le $MaxVal) {
                return $val
            }
        }
        Write-Host "Invalid selection. Please choose a number between 1 and $MaxVal." -ForegroundColor Red
    }
}

function Get-ValidatedYN {
    param (
        [string]$PromptText,
        [string]$DefaultVal # 'y' or 'n'
    )
    $displayDefault = if ($DefaultVal.ToLower() -eq 'y') { "Y/n" } else { "y/N" }
    while ($true) {
        $choice = Read-Host "$PromptText [$displayDefault] [Default: $DefaultVal]"
        if ([string]::IsNullOrWhiteSpace($choice)) {
            return $DefaultVal.ToLower()
        }
        $choice = $choice.Trim().ToLower()
        if ($choice -eq 'y' -or $choice -eq 'n') {
            return $choice
        }
        Write-Host "Invalid selection. Please enter y or n." -ForegroundColor Red
    }
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
            if ($RelPath -eq "README.md" -or $RelPath -eq "ai/context/project.md") {
                $Content = Get-Content -Path $SrcFile -Raw
                $Content = $Content -replace '# Project Name', "# $ProjectName"
                Set-Content -Path $DestFile -Value $Content
                Write-Host "Generated custom $RelPath for project: $ProjectName"
            } else {
                Copy-Item -Path $SrcFile -Destination $DestFile -Force
                Write-Host "Copied template to: $DestFile"
            }
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
$CommunicationPolicyVal = "- **Communication Style:** Be extremely concise and technical. Avoid conversational filler. Focus explanations on high-level architecture and exact code changes."
$LintingPolicyVal = "- **Linting & Formatting:** You MUST run code formatters and linters (e.g. Prettier, ESLint, Black, gofmt) on modified files after every edit to ensure styling compliance before finalizing tasks."
$TaskManagementPolicyVal = "- **Task Boundaries:** Restrict modifications to the exact files needed. Do not touch more than 3 files or implement more than one logical sub-task per iteration without checking in or seeking approval."
$ContextManagementPolicyVal = "- **Context Management:** Minimize file reads. Do not read entire directories or large files unless essential. Target specific line ranges using line-specific tools or grep search first."
$SecretsPolicyVal = "- **Secrets & Security:** Never write API keys, passwords, or credentials to any files, including local env files or comments. Prompt the user to set them locally if needed."
$TechStackVal = "- Stack: General / To be defined later.`n- Adhere to the existing coding style of any file you edit."

$GenClaude = $false
$GenCursor = $false
$GenCline = $false
$GenWindsurf = $false
$GenCopilot = $false
$GenJetbrains = $false
$GenAider = $false
$GenTabnine = $false
$GenCody = $false
$InitGit = $false

# Check if interactive
if (-not $NonInteractive) {
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host "   AI-First Project Rule Configuration Wizard" -ForegroundColor Cyan
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host ""
    
    # --- SECTION 0: Project Details ---
    Write-Host "--- SECTION 0: Project Details ---" -ForegroundColor Yellow
    while ($true) {
        Write-Host "Please enter the project name."
        Write-Host "Guidelines:"
        Write-Host "  - Length: 3 to 50 characters"
        Write-Host "  - Allowed characters: letters, numbers, spaces, hyphens (-), underscores (_), dots (.)"
        Write-Host "  - Avoid special shell/system characters (e.g. /, \, *, ?, <, >, |, $, &)"
        Write-Host ""
        $userProjName = Read-Host "Enter project name [Default: $DefaultProjectName]"
        
        # Use default if empty
        if ([string]::IsNullOrWhiteSpace($userProjName)) {
            $userProjName = $DefaultProjectName
        }
        
        # Validate length
        if ($userProjName.Length -gt 50) {
            Write-Warning "Error: Project name is too long ($($userProjName.Length) chars). Max length is 50 characters."
            Write-Host ""
            continue
        }
        if ($userProjName.Length -lt 3) {
            Write-Warning "Error: Project name is too short ($($userProjName.Length) chars). Min length is 3 characters."
            Write-Host ""
            continue
        }
        
        # Validate regex
        if ($userProjName -notmatch '^[a-zA-Z0-9 _.-]+$') {
            Write-Warning "Error: Project name contains forbidden characters."
            Write-Warning "Allowed: letters, numbers, spaces, dashes (-), underscores (_), and dots (.)"
            Write-Host ""
            continue
        }
        
        $ProjectName = $userProjName
        break
    }
    Write-Host "Project name set to: $ProjectName" -ForegroundColor Green
    Write-Host ""

    # --- SECTION 1: Autonomy & Decisions ---
    Write-Host "--- SECTION 1: Autonomy & Decisions ---" -ForegroundColor Yellow
    Write-Host "1.1) Choose AI Autonomy Mode:"
    Write-Host "  [1] Consultative / Ask-First  [Default]"
    Write-Host "      AI stops and asks if unsure"
    Write-Host "      - Pros: Safest mode. AI will never make assumptions or execute risky changes."
    Write-Host "      - Cons: Slowest mode. Requires manual human confirmation for every ambiguous task."
    Write-Host "      - Consequence: AI will stop and prompt for confirmation on any ambiguity."
    Write-Host "  [2] Autonomous / Proactive"
    Write-Host "      AI decides and implements, explains later"
    Write-Host "      - Pros: Fast development. AI uses senior expertise to resolve ambiguity and write code."
    Write-Host "      - Cons: Riskier. AI might make incorrect assumptions or write unwanted code."
    Write-Host "      - Consequence: AI will make senior-level design decisions independently."
    Write-Host "  [3] Plan-First"
    Write-Host "      AI writes a plan for approval first"
    Write-Host "      - Pros: High control. You review a formal design document before any code is written."
    Write-Host "      - Cons: Adds an extra review step for all tasks, including minor ones."
    Write-Host "      - Consequence: AI must write and get approval for an implementation plan first."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-3]" -DefaultVal 1 -MaxVal 3
    Write-Host "Selected: $opt"
    if ($opt -eq "2") {
        $AutonomyModeVal = "- **Autonomous Mode:** If you encounter ambiguity, decide what is best based on your senior expertise, implement it, and explain your choice in the summary. Ask only when blocked."
    } elseif ($opt -eq "3") {
        $AutonomyModeVal = "- **Plan-First Mode:** For any non-trivial changes, write an implementation plan first, present it to the user for approval, and wait for confirmation before writing code."
    }
    Write-Host ""

    Write-Host "1.2) Choose Dependency Policy:"
    Write-Host "  [1] Strict / Ask-First  [Default]"
    Write-Host "      AI must ask before installing packages"
    Write-Host "      - Pros: Absolute control over external dependencies. Prevents bloat or license issues."
    Write-Host "      - Cons: Developer must manually approve or install every library."
    Write-Host "      - Consequence: AI is forbidden from adding packages to package.json/requirements.txt."
    Write-Host "  [2] Proactive"
    Write-Host "      AI can install standard packages if needed"
    Write-Host "      - Pros: Seamless development. AI handles package installations on its own."
    Write-Host "      - Cons: Risk of installing unneeded, heavy, or poorly-licensed libraries."
    Write-Host "      - Consequence: AI may add standard, safe packages without prompting."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-2]" -DefaultVal 1 -MaxVal 2
    Write-Host "Selected: $opt"
    if ($opt -eq "2") {
        $DependencyPolicyVal = "- **Proactive Dependency Policy:** You can install standard, widely-used packages if they are necessary for the implementation, but inform the user in the summary."
    }
    Write-Host ""

    Write-Host "1.3) Choose AI Architecture Policy:"
    Write-Host "  [1] Strict / Ask-First  [Default]"
    Write-Host "      AI cannot change patterns/directories/database without approval"
    Write-Host "      - Pros: Protects codebase structure, patterns, and framework decisions."
    Write-Host "      - Cons: AI cannot perform minor refactoring or structure cleanups independently."
    Write-Host "      - Consequence: AI cannot change project patterns or folder paths without asking."
    Write-Host "  [2] Flexible"
    Write-Host "      AI can propose and implement minor refactors, but must document"
    Write-Host "      - Pros: Allows AI to refactor small parts of code to improve design patterns."
    Write-Host "      - Cons: Minor risk of codebase drifting from original developer design."
    Write-Host "      - Consequence: AI can suggest and run minor refactorings as long as documented."
    Write-Host "  [3] Full Autonomy / Change Architecture (NOT RECOMMENDED)"
    Write-Host "      - Pros: AI can completely redesign structures and libraries for optimal efficiency."
    Write-Host "      - Cons: High risk of structure fragmentation and incompatible design patterns."
    Write-Host "      - Consequence: AI has full control over files, directories, databases, and schemas."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-3]" -DefaultVal 1 -MaxVal 3
    Write-Host "Selected: $opt"
    if ($opt -eq "2") {
        $ArchitecturePolicyVal = "- **Flexible Architecture Scope:** You may suggest and implement minor architectural improvements or helper utilities if they simplify the implementation, but document them in the task summary."
    } elseif ($opt -eq "3") {
        $ArchitecturePolicyVal = "- **Full Architectural Autonomy (NOT RECOMMENDED):** You have full autonomy to make architectural modifications, refactor structural design patterns, or rename/create top-level directories to achieve the task goal."
    }
    Write-Host ""

    Write-Host "1.4) Choose Dependency License Policy:"
    Write-Host "  [1] Permissive Only  [Default]"
    Write-Host "      Allows MIT, Apache 2.0, BSD, Public Domain"
    Write-Host "      - Pros: Safe for proprietary and commercial software development."
    Write-Host "      - Cons: Restricts the usage of some popular libraries under copyleft."
    Write-Host "      - Consequence: AI will block any copyleft or viral licenses (like GPL/AGPL)."
    Write-Host "  [2] Copyleft Tolerant"
    Write-Host "      Permissive + LGPL, MPL"
    Write-Host "      - Pros: Access to a wider range of open source packages."
    Write-Host "      - Cons: Requires caution when statically linking or distributing products."
    Write-Host "      - Consequence: AI allows LGPL/MPL but still blocks GPL/AGPL."
    Write-Host "  [3] Any License"
    Write-Host "      No license restrictions"
    Write-Host "      - Pros: Maximum access to any library on npm/pip/go package registries."
    Write-Host "      - Cons: High risk of legal violations or open-sourcing proprietary code."
    Write-Host "      - Consequence: AI will not verify licenses when adding dependencies."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-3]" -DefaultVal 1 -MaxVal 3
    Write-Host "Selected: $opt"
    if ($opt -eq "2") {
        $LicensePolicyVal = "- **License Constraints:** You are allowed to introduce dependencies under permissive licenses (MIT, Apache 2.0, BSD, Public Domain) and weak-copyleft licenses (LGPL, MPL). Refer to the knowledge/licenses.md file for details."
    } elseif ($opt -eq "3") {
        $LicensePolicyVal = "- **License Constraints:** No strict license restrictions, but prefer widely-adopted, open-source libraries. Ensure compliance before commercial deployment."
    }
    Write-Host ""

    Write-Host "1.5) Choose Git Autonomy Mode:"
    Write-Host "  [1] None  [Default]"
    Write-Host "      AI only modifies files; human commits"
    Write-Host "      - Pros: Maximum control. Every line of code is reviewed before staging."
    Write-Host "      - Cons: Developer must manually stage, write commit messages, and commit."
    Write-Host "      - Consequence: AI will leave git actions entirely to the developer."
    Write-Host "  [2] Commit-First"
    Write-Host "      AI commits changes on current branch using Conventional Commits"
    Write-Host "      - Pros: Hands-free version control for rapid iterations."
    Write-Host "      - Cons: Messy commit history if AI commits broken or half-implemented code."
    Write-Host "      - Consequence: AI will stage and commit code using Conventional Commits."
    Write-Host "  [3] Branch-First"
    Write-Host "      AI creates dedicated feature branch and commits there"
    Write-Host "      - Pros: Completely isolates AI work from main development branch."
    Write-Host "      - Cons: Requires managing, reviewing, and merging additional git branches."
    Write-Host "      - Consequence: AI creates a dedicated task branch to commit its changes."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-3]" -DefaultVal 1 -MaxVal 3
    Write-Host "Selected: $opt"
    if ($opt -eq "2") {
        $GitPolicyVal = "- **Git Autonomy:** You are allowed to stage and commit your changes on the current branch. Use Conventional Commits formatting (e.g., `"feat(ui): add button`") for commit messages."
    } elseif ($opt -eq "3") {
        $GitPolicyVal = "- **Git Autonomy:** Create a new feature branch for your changes (e.g., `"feature/task-NNN-desc`") and commit there. Do not commit directly to master/main."
    }
    Write-Host ""

    Write-Host "1.6) Choose Critical Operations / Safety Policy:"
    Write-Host "  [1] Strict Protection  [Default]"
    Write-Host "      AI forbidden from running destructive commands like DROP/DELETE/force push without asking"
    Write-Host "      - Pros: Blocks accidental drops/truncates of databases, force pushes, or deletes."
    Write-Host "      - Cons: AI will pause and ask even for simple deletions of obsolete files."
    Write-Host "      - Consequence: AI is forbidden from running destructive CLI commands without asking."
    Write-Host "  [2] Collaborative / Loose"
    Write-Host "      AI can run destructive cleanup if task calls for it"
    Write-Host "      - Pros: Fast cleanups of project history and deprecated components."
    Write-Host "      - Cons: Risk of executing commands that permanently destroy data."
    Write-Host "      - Consequence: AI is allowed to delete files or run cleanup commands independently."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-2]" -DefaultVal 1 -MaxVal 2
    Write-Host "Selected: $opt"
    if ($opt -eq "2") {
        $SafetyPolicyVal = "- **Critical Operations Policy:** You can perform cleanup actions (like removing obsolete prototype files or database tables) if it is directly required to complete the task."
    }
    Write-Host ""

    Write-Host "1.7) Choose Secrets & Security Policy:"
    Write-Host "  [1] Zero-Trust / Strict Secret Protection [Default]"
    Write-Host "      - Pros: Maximum security, zero risk of committing API keys, tokens, or credentials."
    Write-Host "      - Cons: Developer must manually configure env files and local environment settings."
    Write-Host "      - Consequence: AI is strictly forbidden from writing keys or credentials to any file."
    Write-Host "  [2] Auto-Config / Permissive"
    Write-Host "      - Pros: Automatic and seamless local environment configuration."
    Write-Host "      - Cons: High risk of accidental credential leaks to Git."
    Write-Host "      - Consequence: AI is allowed to write mock/test credentials to local config files."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-2]" -DefaultVal 1 -MaxVal 2
    Write-Host "Selected: $opt"
    if ($opt -eq "2") {
        $SecretsPolicyVal = "- **Secrets & Security:** You may generate or update local configuration and .env files with test or dummy credentials for local execution, but never commit them to Git."
    }
    Write-Host ""

    Write-Host "1.8) Choose Context & Cost Control Policy:"
    Write-Host "  [1] Strict Token Diet  [Default]"
    Write-Host "      Targeted reads, minimizes token usage"
    Write-Host "      - Pros: Highly token-efficient, lower costs, fast response times."
    Write-Host "      - Cons: AI might miss global dependencies or duplicate helper code."
    Write-Host "      - Consequence: AI prioritizes grep and targeted line range reads over full file reads."
    Write-Host "  [2] Context Rich"
    Write-Host "      Comprehensive reads, full file and directory understanding"
    Write-Host "      - Pros: Deeper understanding of full codebase dependencies, safer refactoring."
    Write-Host "      - Cons: Extremely high token consumption, high costs, risks context window saturation."
    Write-Host "      - Consequence: AI reads entire files and directories before making modifications."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-2]" -DefaultVal 1 -MaxVal 2
    Write-Host "Selected: $opt"
    if ($opt -eq "2") {
        $ContextManagementPolicyVal = "- **Context Management:** Read files in full to fully understand the module structure and dependencies before making any changes."
    }
    Write-Host ""

    # --- SECTION 2: Coding & Refactoring ---
    Write-Host "--- SECTION 2: Coding & Refactoring ---" -ForegroundColor Yellow
    Write-Host "2.1) Choose Refactoring Policy:"
    Write-Host "  [1] Strict Scope  [Default]"
    Write-Host "      AI only touches what's requested"
    Write-Host "      - Pros: Tiny PRs, minimal code churn, low risk of regression."
    Write-Host "      - Cons: Technical debt and code smells persist in modified files."
    Write-Host "      - Consequence: AI will modify only the exact lines requested for the task."
    Write-Host "  [2] Boy Scout Rule"
    Write-Host "      AI cleans up minor smells in edited files"
    Write-Host "      - Pros: Continuous code health improvements, fixes types/formatting in passing."
    Write-Host "      - Cons: Larger diffs, slight risk of regression in surrounding code."
    Write-Host "      - Consequence: AI will format and clean up adjacent code smells in modified files."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-2]" -DefaultVal 1 -MaxVal 2
    Write-Host "Selected: $opt"
    if ($opt -eq "2") {
        $RefactoringPolicyVal = "- **Boy Scout Rule:** Proactively clean up minor code smells, formatting issues, or type safety gaps in files you are already modifying, as long as it does not expand the scope excessively."
    }
    Write-Host ""

    Write-Host "2.2) Choose Code Quality & Linting Policy:"
    Write-Host "  [1] Automatic Formatter & Linter [Default]"
    Write-Host "      - Pros: Code is always clean, matches project style, prevents merge conflicts."
    Write-Host "      - Cons: Adds minor execution overhead and delay during tasks."
    Write-Host "      - Consequence: AI will run tools like Prettier/ESLint/Black after modifications."
    Write-Host "  [2] Minimalist"
    Write-Host "      On-demand / Manual formatting"
    Write-Host "      - Pros: Maximum iteration speed, zero tool execution overhead."
    Write-Host "      - Cons: Risk of committing unformatted or style-violating code if developer forgets."
    Write-Host "      - Consequence: AI relies entirely on manual compliance and will not auto-run tools."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-2]" -DefaultVal 1 -MaxVal 2
    Write-Host "Selected: $opt"
    if ($opt -eq "2") {
        $LintingPolicyVal = "- **Linting & Formatting:** Do not run formatting or linting commands automatically unless explicitly requested. Focus on functional correctness, adhering to the surrounding code style manually."
    }
    Write-Host ""

    Write-Host "2.3) Choose Task Boundaries & Granularity:"
    Write-Host "  [1] Strict Boundaries & Micro-tasks [Default]"
    Write-Host "      - Pros: Prevents scope creep, keeps PRs small, low risk of code conflicts."
    Write-Host "      - Cons: Higher interaction frequency, requires user approval more often."
    Write-Host "      - Consequence: AI will restrict modifications to <= 3 files and one sub-task at a time."
    Write-Host "  [2] Flexible / Broad Scope"
    Write-Host "      - Pros: Rapid implementation of wide features, fewer prompts."
    Write-Host "      - Cons: Harder to debug, larger PRs, high risk of breaking unrelated systems."
    Write-Host "      - Consequence: AI will implement multi-file refactors in a single pass."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-2]" -DefaultVal 1 -MaxVal 2
    Write-Host "Selected: $opt"
    if ($opt -eq "2") {
        $TaskManagementPolicyVal = "- **Task Boundaries:** You have flexible scope. If a feature requires modifying several files or modules, implement them in a single stream, but document the full list of files affected in the summary."
    }
    Write-Host ""

    Write-Host "2.4) Choose AI Communication & Explanation Style:"
    Write-Host "  [1] Concise & Technical [Default]"
    Write-Host "      - Pros: Low token overhead, fast response times, fits cleanly in context."
    Write-Host "      - Cons: Skips beginner-friendly explanations or pattern breakdowns."
    Write-Host "      - Consequence: AI expects senior-level understanding and skips tutorial-like text."
    Write-Host "  [2] Detailed & Educational"
    Write-Host "      - Pros: High educational value, explains design patterns and choices."
    Write-Host "      - Cons: Large token consumption, slower responses, potential context bloat."
    Write-Host "      - Consequence: Good for learning a new stack, but increases costs and latency."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-2]" -DefaultVal 1 -MaxVal 2
    Write-Host "Selected: $opt"
    if ($opt -eq "2") {
        $CommunicationPolicyVal = "- **Communication Style:** Provide detailed, step-by-step explanations of your implementation decisions, design patterns, and potential alternatives. Focus on educational value."
    }
    Write-Host ""

    # --- SECTION 3: Testing Strategy ---
    Write-Host "--- SECTION 3: Testing Strategy ---" -ForegroundColor Yellow
    Write-Host "3.1) Choose Testing Coverage Policy:"
    Write-Host "  [1] Critical Path only  [Default]"
    Write-Host "      Write tests only for key logic and critical paths"
    Write-Host "      - Pros: Good safety-to-overhead ratio. Focuses tests where they matter most."
    Write-Host "      - Cons: Helper functions and edge cases might remain untested."
    Write-Host "      - Consequence: AI will write tests only for critical paths and core logic."
    Write-Host "  [2] None"
    Write-Host "      Skip tests for maximum speed"
    Write-Host "      - Pros: Faster implementations, zero testing overhead."
    Write-Host "      - Cons: High risk of regression and undetected bugs in production."
    Write-Host "      - Consequence: AI will focus entirely on code and skip writing any tests."
    Write-Host "  [3] Full Coverage"
    Write-Host "      Task is complete only when fully covered and tests pass"
    Write-Host "      - Pros: Maximum stability, code correctness verified automatically."
    Write-Host "      - Cons: Much slower implementation times due to writing extensive test cases."
    Write-Host "      - Consequence: AI will write thorough unit/integration tests for all paths."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-3]" -DefaultVal 1 -MaxVal 3
    Write-Host "Selected: $opt"
    if ($opt -eq "2") {
        $TestingCoverageVal = "- **Testing Coverage:** No tests are required for this project. Focus entirely on speed and coding."
    } elseif ($opt -eq "3") {
        $TestingCoverageVal = "- **Testing Coverage:** Full test coverage is required. A task or feature is only complete when it has thorough unit/integration tests covering all new paths, and all tests pass."
    }
    Write-Host ""

    Write-Host "3.2) Choose Testing Approach:"
    Write-Host "  [1] Write-After / Post-Implementation  [Default]"
    Write-Host "      Write tests after implementation"
    Write-Host "      - Pros: Easier to write tests once code structure is established."
    Write-Host "      - Cons: Tests might be biased by the implementation rather than requirements."
    Write-Host "      - Consequence: AI writes code first, then writes tests to verify it."
    Write-Host "  [2] TDD / Test-First"
    Write-Host "      Write tests before implementation"
    Write-Host "      - Pros: Ensures clean API design, forces implementation of requirements."
    Write-Host "      - Cons: Higher startup overhead; requires mock setups before code is written."
    Write-Host "      - Consequence: AI writes failing tests first, then implements code to pass."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-2]" -DefaultVal 1 -MaxVal 2
    Write-Host "Selected: $opt"
    if ($opt -eq "2") {
        $TestingApproachVal = "- **Testing Approach:** Follow Test-Driven Development (TDD) principles. Write failing tests before writing the implementation."
    }
    Write-Host ""

    Write-Host "3.3) Choose Test Execution Scope:"
    Write-Host "  [1] Unit Tests only  [Default]"
    Write-Host "      Run single unit tests related to changed code"
    Write-Host "      - Pros: Fast test runs, local verification is quick."
    Write-Host "      - Cons: Misses regressions in cross-module interactions."
    Write-Host "      - Consequence: AI runs only single test files related to modified code."
    Write-Host "  [2] Module / Integration Tests"
    Write-Host "      Run unit and integration tests for the module"
    Write-Host "      - Pros: Catches integration issues within the module or domain."
    Write-Host "      - Cons: Slower test feedback loop."
    Write-Host "      - Consequence: AI runs tests for the modified module/domain."
    Write-Host "  [3] Full Suite"
    Write-Host "      Run the entire test suite on every change"
    Write-Host "      - Pros: 100% certainty that no regressions exist anywhere in the codebase."
    Write-Host "      - Cons: Very slow developer loop if the test suite is large."
    Write-Host "      - Consequence: AI runs the entire repository test suite on every change."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-3]" -DefaultVal 1 -MaxVal 3
    Write-Host "Selected: $opt"
    if ($opt -eq "2") {
        $TestExecutionScopeVal = "- **Test Execution Scope:** Run unit and module integration tests for the current feature scope during iterations."
    } elseif ($opt -eq "3") {
        $TestExecutionScopeVal = "- **Test Execution Scope:** Run the entire test suite of the repository to ensure no regressions on every meaningful code change."
    }
    Write-Host ""

    # --- SECTION 4: Tech Stack ---
    Write-Host "--- SECTION 4: Tech Stack ---" -ForegroundColor Yellow
    Write-Host "WARNING: Select ONLY the technologies you will actually use. Adding unnecessary" -ForegroundColor Red
    Write-Host "technologies clutters the AI's memory, leading to inefficient token usage and costs." -ForegroundColor Red
    Write-Host "Since a project grows over time, adding new technologies or rules incrementally"
    Write-Host "(by editing 'ai/rules/coding.md') is the recommended approach."
    Write-Host ""
    Write-Host "4.1) Select Tech Stack / Framework option:"
    Write-Host "  [1] Decide later / General [Default]"
    Write-Host "      - Universal layout. Adapts to any language or framework automatically."
    Write-Host "  [2] Custom Selection / Choose multiple"
    Write-Host "      - Choose specific technologies from a list of popular options."
    
    $opt = Get-ValidatedChoice -PromptText "Select option [1-2]" -DefaultVal 1 -MaxVal 2
    Write-Host "Selected: $opt"

    if ($opt -eq 1) {
        $TechStackVal = "- Stack: General / To be defined later.`n- Adhere to the existing coding style of any file you edit."
    } else {
        $chosenStacks = @()
        
        $choice = Get-ValidatedYN -PromptText "Include Node.js / TypeScript?" -DefaultVal "n"
        if ($choice -eq "y") {
            $chosenStacks += "- Stack: Node.js / TypeScript.`n- Use strict TypeScript configurations.`n- Prefer async/await over raw Promises.`n- Avoid using ``any`` type annotations; define interfaces or types."
        }
        
        $choice = Get-ValidatedYN -PromptText "Include Python?" -DefaultVal "n"
        if ($choice -eq "y") {
            $chosenStacks += "- Stack: Python.`n- Adhere to PEP 8 standards.`n- Use type hints for all public function signatures.`n- Prefer list comprehensions and generator expressions where readable."
        }
        
        $choice = Get-ValidatedYN -PromptText "Include Go?" -DefaultVal "n"
        if ($choice -eq "y") {
            $chosenStacks += "- Stack: Go.`n- Use standard Go conventions (``gofmt``, ``go lint``).`n- Explicitly handle all errors; do not ignore them.`n- Keep packages cohesive and API surfaces clean."
        }
        
        $choice = Get-ValidatedYN -PromptText "Include React / Next.js?" -DefaultVal "n"
        if ($choice -eq "y") {
            $chosenStacks += "- Stack: React / Next.js.`n- Use functional components with hooks.`n- Keep components small, reusable, and state localized.`n- Follow Next.js directory and routing conventions."
        }
        
        $choice = Get-ValidatedYN -PromptText "Include Rust?" -DefaultVal "n"
        if ($choice -eq "y") {
            $chosenStacks += "- Stack: Rust.`n- Follow Cargo and standard Clippy lints.`n- Handle results/errors explicitly; avoid ``.unwrap()`` in production code.`n- Adhere to ownership and borrowing rules without unnecessary cloning."
        }
        
        $choice = Get-ValidatedYN -PromptText "Include Java / Spring Boot?" -DefaultVal "n"
        if ($choice -eq "y") {
            $chosenStacks += "- Stack: Java / Spring Boot.`n- Follow standard Java CamelCase naming conventions.`n- Use constructor-based dependency injection.`n- Utilize standard Spring Boot annotations correctly and keep controllers thin."
        }
        
        $choice = Get-ValidatedYN -PromptText "Include C# / .NET?" -DefaultVal "n"
        if ($choice -eq "y") {
            $chosenStacks += "- Stack: C# / .NET.`n- Follow Microsoft C# coding conventions and naming guidelines (PascalCase).`n- Use modern C# language features and expression-bodied members.`n- Implement async/await correctly for all I/O bound operations."
        }
        
        $choice = Get-ValidatedYN -PromptText "Include PHP / Laravel?" -DefaultVal "n"
        if ($choice -eq "y") {
            $chosenStacks += "- Stack: PHP / Laravel.`n- Adhere to PSR-12 coding standard.`n- Declare strict types (``declare(strict_types=1);``).`n- Leverage Eloquent ORM correctly and avoid raw SQL where possible."
        }

        if ($chosenStacks.Count -eq 0) {
            Write-Host "No technologies selected. Defaulting to General."
            $TechStackVal = "- Stack: General / To be defined later.`n- Adhere to the existing coding style of any file you edit."
        } else {
            $TechStackVal = $chosenStacks -join "`n`n"
        }
    }
    Write-Host ""

    # --- SECTION 5: AI IDE Configuration ---
    Write-Host "--- SECTION 5: AI IDE Configuration ---" -ForegroundColor Yellow
    Write-Host "5.1) Choose which AI IDE configuration files (thin pointers) to generate:"
    Write-Host "  [1] Standard  [Default]"
    Write-Host "      Only AGENTS.md - works natively with all modern AI agents"
    Write-Host "      - Pros: Zero root directory clutter, works with all modern AI agents natively."
    Write-Host "      - Cons: Requires AI agents to discover rules from the root file without custom pointers."
    Write-Host "      - Consequence: Only the central AGENTS.md is created."
    Write-Host "  [2] Custom"
    Write-Host "      Generates AGENTS.md plus your choice of additional AI IDE pointers"
    Write-Host "      - Pros: Tailored configuration files created only for the IDEs you actually use."
    Write-Host "      - Cons: Requires answering individual prompts for each supported IDE."
    Write-Host "      - Consequence: AGENTS.md is generated, and you choose which extra pointer files to add."
    Write-Host "  [3] All"
    Write-Host "      Generate files for all 10 popular AI IDEs"
    Write-Host "      - Pros: Complete workspace readiness. Any team developer's IDE will pick up the rules."
    Write-Host "      - Cons: Creates minor clutter by adding 10 pointer files in the root."
    Write-Host "      - Consequence: Pointers for Claude Code, Cursor, Cline, Windsurf, Copilot, etc., are all created."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-3]" -DefaultVal 1 -MaxVal 3
    Write-Host "Selected: $opt"

    if ($opt -eq 3) {
        $GenClaude = $true
        $GenCursor = $true
        $GenCline = $true
        $GenWindsurf = $true
        $GenCopilot = $true
        $GenJetbrains = $true
        $GenAider = $true
        $GenTabnine = $true
        $GenCody = $true
    } elseif ($opt -eq 2) {
        $choice = Get-ValidatedYN -PromptText "Generate Claude Code pointer (CLAUDE.md)?" -DefaultVal "n"
        if ($choice -eq "y") {
            $GenClaude = $true
            Write-Host "Selected: Yes"
        } else {
            Write-Host "Selected: No"
        }

        $choice = Get-ValidatedYN -PromptText "Generate Cursor pointer (.cursorrules)?" -DefaultVal "n"
        if ($choice -eq "y") {
            $GenCursor = $true
            Write-Host "Selected: Yes"
        } else {
            Write-Host "Selected: No"
        }

        $choice = Get-ValidatedYN -PromptText "Generate Cline/Roo Code pointer (.clinerules)?" -DefaultVal "n"
        if ($choice -eq "y") {
            $GenCline = $true
            Write-Host "Selected: Yes"
        } else {
            Write-Host "Selected: No"
        }

        $choice = Get-ValidatedYN -PromptText "Generate Windsurf pointer (.windsurfrules)?" -DefaultVal "n"
        if ($choice -eq "y") {
            $GenWindsurf = $true
            Write-Host "Selected: Yes"
        } else {
            Write-Host "Selected: No"
        }

        $choice = Get-ValidatedYN -PromptText "Generate GitHub Copilot pointer (.github/copilot-instructions.md)?" -DefaultVal "n"
        if ($choice -eq "y") {
            $GenCopilot = $true
            Write-Host "Selected: Yes"
        } else {
            Write-Host "Selected: No"
        }

        $choice = Get-ValidatedYN -PromptText "Generate JetBrains AI Assistant pointer (.aiassistant/rules/main.md)?" -DefaultVal "n"
        if ($choice -eq "y") {
            $GenJetbrains = $true
            Write-Host "Selected: Yes"
        } else {
            Write-Host "Selected: No"
        }

        $choice = Get-ValidatedYN -PromptText "Generate Aider pointer (CONVENTIONS.md & .aider.conf.yml)?" -DefaultVal "n"
        if ($choice -eq "y") {
            $GenAider = $true
            Write-Host "Selected: Yes"
        } else {
            Write-Host "Selected: No"
        }

        $choice = Get-ValidatedYN -PromptText "Generate Tabnine pointer (.tabnine/guidelines/main.md)?" -DefaultVal "n"
        if ($choice -eq "y") {
            $GenTabnine = $true
            Write-Host "Selected: Yes"
        } else {
            Write-Host "Selected: No"
        }

        $choice = Get-ValidatedYN -PromptText "Generate Sourcegraph Cody pointer (.cody/rules.md)?" -DefaultVal "n"
        if ($choice -eq "y") {
            $GenCody = $true
            Write-Host "Selected: Yes"
        } else {
            Write-Host "Selected: No"
        }
    }
    Write-Host ""

    # --- SECTION 6: Git Version Control ---
    Write-Host "--- SECTION 6: Git Version Control ---" -ForegroundColor Yellow
    Write-Host "6.1) Do you want to initialize Git repository tracking?"
    Write-Host "  [1] No  [Default]"
    Write-Host "      Skip Git tracking for now"
    Write-Host "      - Pros: Quick setup, no Git repository directory created."
    Write-Host "      - Cons: No version control or change tracking immediately."
    Write-Host "      - Consequence: Git repository will not be initialized."
    Write-Host "  [2] Yes, initialize Git and track changes from the start"
    Write-Host "      - Pros: Instant tracking, easy to review changes, standard professional setup."
    Write-Host "      - Cons: Adds the '.git' directory to the workspace root."
    Write-Host "      - Consequence: Initializes Git repo, copies 'knowledge/git.md' template, and stages initial files."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-2]" -DefaultVal 1 -MaxVal 2
    Write-Host "Selected: $opt"
    if ($opt -eq "2") {
        $InitGit = $true
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
    $Content = $Content -replace "__COMMUNICATION_POLICY__", $CommunicationPolicyVal
    $Content = $Content -replace "__LINTING_POLICY__", $LintingPolicyVal
    $Content = $Content -replace "__TASK_MANAGEMENT_POLICY__", $TaskManagementPolicyVal
    $Content = $Content -replace "__CONTEXT_MANAGEMENT_POLICY__", $ContextManagementPolicyVal
    $Content = $Content -replace "__SECRETS_POLICY__", $SecretsPolicyVal
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
New-DirectoryIfNotExists (Join-Path $BaseDir "tmp")
New-Item -ItemType File -Path (Join-Path $BaseDir "tmp/.gitkeep") -Force | Out-Null

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

# Generate AI IDE pointer files if requested
if ($GenClaude) {
    $Content = @"
Refer to AGENTS.md for coding guidelines, architecture, and workflows.
Do not deviate from the workflows defined in ai/workflows/.
"@
    Set-Content -Path (Join-Path $BaseDir "CLAUDE.md") -Value $Content -Encoding utf8
    Write-Host "Generated Claude Code pointer: CLAUDE.md"
}

if ($GenCursor) {
    $Content = @"
Always read AGENTS.md first to understand the project structure and rules.
Follow the guidelines in ai/rules/coding.md for all code modifications.
"@
    Set-Content -Path (Join-Path $BaseDir ".cursorrules") -Value $Content -Encoding utf8
    Write-Host "Generated Cursor pointer: .cursorrules"
}

if ($GenCline) {
    $Content = @"
Read AGENTS.md to understand the repository structure and context.
Adhere strictly to the active guidelines in ai/rules/.
"@
    Set-Content -Path (Join-Path $BaseDir ".clinerules") -Value $Content -Encoding utf8
    Write-Host "Generated Cline/Roo Code pointer: .clinerules"
}

if ($GenWindsurf) {
    $Content = @"
Always read AGENTS.md first to understand the project rules, coding standards, and workflows.
Follow the guidelines in ai/rules/coding.md for code modifications.
"@
    Set-Content -Path (Join-Path $BaseDir ".windsurfrules") -Value $Content -Encoding utf8
    Write-Host "Generated Windsurf pointer: .windsurfrules"
}

if ($GenCopilot) {
    $Dir = Join-Path $BaseDir ".github"
    if (-not (Test-Path $Dir)) { New-Item -ItemType Directory -Path $Dir | Out-Null }
    $Content = @"
Always refer to AGENTS.md in the root directory for general project instructions, tech stack rules, and coding standards.
"@
    Set-Content -Path (Join-Path $Dir "copilot-instructions.md") -Value $Content -Encoding utf8
    Write-Host "Generated GitHub Copilot pointer: .github/copilot-instructions.md"
}

if ($GenJetbrains) {
    $Dir = Join-Path $BaseDir ".aiassistant/rules"
    if (-not (Test-Path $Dir)) { New-Item -ItemType Directory -Path $Dir -Force | Out-Null }
    $Content = @"
# JetBrains AI Assistant Rules
Always refer to AGENTS.md in the project root directory for coding standards, autonomy rules, and workflows.
"@
    Set-Content -Path (Join-Path $Dir "main.md") -Value $Content -Encoding utf8
    Write-Host "Generated JetBrains AI Assistant pointer: .aiassistant/rules/main.md"
}

if ($GenAider) {
    $Content = @"
Always read AGENTS.md first to understand coding style, testing rules, and project workflows.
"@
    Set-Content -Path (Join-Path $BaseDir "CONVENTIONS.md") -Value $Content -Encoding utf8

    $Content = @"
read:
  - CONVENTIONS.md
"@
    Set-Content -Path (Join-Path $BaseDir ".aider.conf.yml") -Value $Content -Encoding utf8
    Write-Host "Generated Aider pointers: CONVENTIONS.md & .aider.conf.yml"
}

if ($GenTabnine) {
    $Dir = Join-Path $BaseDir ".tabnine/guidelines"
    if (-not (Test-Path $Dir)) { New-Item -ItemType Directory -Path $Dir -Force | Out-Null }
    $Content = @"
# Tabnine Guidelines
Refer to AGENTS.md in the project root for coding rules, testing constraints, and workflows.
"@
    Set-Content -Path (Join-Path $Dir "main.md") -Value $Content -Encoding utf8
    Write-Host "Generated Tabnine pointer: .tabnine/guidelines/main.md"
}

if ($GenCody) {
    $Dir = Join-Path $BaseDir ".cody"
    if (-not (Test-Path $Dir)) { New-Item -ItemType Directory -Path $Dir | Out-Null }
    $Content = @"
Always read AGENTS.md in the root directory for project-specific rules, tech stack details, and coding conventions.
"@
    Set-Content -Path (Join-Path $Dir "rules.md") -Value $Content -Encoding utf8
    Write-Host "Generated Cody pointer: .cody/rules.md"
}



if ($InitGit) {
    New-DirectoryIfNotExists (Join-Path $BaseDir "knowledge")
    Copy-TemplateFile "knowledge/git.md"
}

Write-Host "Minimal project structure created successfully."

# --- Post-Setup Cleanup ---
$CleanupOption = "1"

if (-not $NonInteractive) {
    Write-Host ""
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host "   Post-Setup Cleanup" -ForegroundColor Cyan
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host "The setup scripts are no longer needed and will be removed."
    Write-Host "The 'templates/' directory contains some one-time templates that have already"
    Write-Host "been initialized, as well as optional templates for future project growth."
    Write-Host ""
    Write-Host "What would you like to do?"
    Write-Host "  [1] Clean up one-time templates, but KEEP remaining future-growth templates in 'templates/' [Default]"
    Write-Host "      - Pros: Preserves incremental templates for future use while keeping them clean."
    Write-Host "      - Cons: Keeps the 'templates/' folder in your project root."
    Write-Host "  [2] Delete the entire 'templates/' directory permanently"
    Write-Host "      - Pros: Absolute minimal project files in root."
    Write-Host "      - Cons: You lose the templates for future directory scaffolding."
    Write-Host "  [3] Keep everything as-is (do not delete or cleanup anything)"
    Write-Host "      - Pros: Leaves all setup files and templates completely untouched."
    Write-Host "      - Cons: Clutters the root directory with unused setup scripts."
    $opt = Get-ValidatedChoice -PromptText "Select option [1-3]" -DefaultVal 1 -MaxVal 3
    $CleanupOption = "$opt"
    Write-Host "Selected: $CleanupOption"
} else {
    Write-Host "Non-interactive run: Cleaning up setup scripts and one-time templates..."
    $CleanupOption = "1"
}

# Define clean-up paths
$SiblingScript = Join-Path $BaseDir "create_minimal_structure.sh"

if ($CleanupOption -eq "1") {
    Write-Host "Cleaning up one-time templates and setup scripts..."
    # Remove one-time template files
    $OneTimeFiles = @("README.md", "AGENTS.md", "MANIFEST.md", ".gitignore")
    foreach ($File in $OneTimeFiles) {
        $FilePath = Join-Path $TemplatesDir $File
        if (Test-Path $FilePath -PathType Leaf) { Remove-Item -Path $FilePath -Force | Out-Null }
    }
    # Remove one-time template folder
    $OneTimeFolder = Join-Path $TemplatesDir "ai"
    if (Test-Path $OneTimeFolder -PathType Container) { Remove-Item -Path $OneTimeFolder -Recurse -Force | Out-Null }
    
    # Remove sibling setup script
    if (Test-Path $SiblingScript -PathType Leaf) { Remove-Item -Path $SiblingScript -Force | Out-Null }
} elseif ($CleanupOption -eq "2") {
    Write-Host "Deleting all templates and setup scripts..."
    if (Test-Path $TemplatesDir -PathType Container) { Remove-Item -Path $TemplatesDir -Recurse -Force | Out-Null }
    if (Test-Path $SiblingScript -PathType Leaf) { Remove-Item -Path $SiblingScript -Force | Out-Null }
    $ManifestPath = Join-Path $BaseDir "MANIFEST.md"
    if (Test-Path $ManifestPath -PathType Leaf) {
        (Get-Content $ManifestPath) | Where-Object { $_ -notmatch 'templates/' } | Set-Content $ManifestPath -Encoding utf8
    }
} else {
    Write-Host "Keeping all files as-is."
}

if ($InitGit) {
    Write-Host "Initializing Git repository..."
    git init
    Write-Host "Staging files in Git..."
    git add .
    # Unstage the setup scripts from Git tracking
    git reset -- $MyInvocation.MyCommand.Definition $SiblingScript 2>$null
    Write-Host "Git repository initialized and files staged successfully."
}

# Print final status message
Write-Host ""
Write-Host "=============================================================" -ForegroundColor Green
Write-Host "   Project structure for: $ProjectName" -ForegroundColor Green
Write-Host "   is ready for AI-first collaboration!" -ForegroundColor Green
Write-Host ""
Write-Host "   Project information is available in README.md" -ForegroundColor Green
Write-Host "=============================================================" -ForegroundColor Green
Write-Host ""

# Self delete at the very end if cleanup was requested
if ($CleanupOption -eq "1" -or $CleanupOption -eq "2") {
    try {
        Remove-Item -Path $MyInvocation.MyCommand.Definition -Force -ErrorAction Stop | Out-Null
        Write-Host "Cleanup complete."
    } catch {
        Write-Warning "Could not delete the running script automatically due to file lock. Please delete it manually."
    }
}

