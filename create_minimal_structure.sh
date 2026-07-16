#!/usr/bin/env bash

# Script to create minimal project structure as defined in ai-context-tree
# ------------------------------------------------------------
set -e

# Determine the directory where this script lives – treat it as the project root
BASE_DIR="."
TEMPLATES_DIR="$BASE_DIR/templates"

# Check if templates directory is present
if [ ! -d "$TEMPLATES_DIR" ]; then
  echo "Error: 'templates/' directory not found at $TEMPLATES_DIR."
  echo "This script must be run inside the cloned repository context containing templates."
  echo "If you are setting up a new project, copy BOTH this script and the 'templates/' directory to your project root."
  exit 1
fi

# Determine default project name based on the target/base directory name
# Extract base folder name and sanitize it (only keep alphanumeric, spaces, hyphens, underscores, dots)
DIR_NAME=$(basename "$(cd "$BASE_DIR" && pwd)")
DEFAULT_PROJECT_NAME=$(echo "$DIR_NAME" | sed 's/[^a-zA-Z0-9 _.-]//g')
# Limit to 50 characters
DEFAULT_PROJECT_NAME=${DEFAULT_PROJECT_NAME:0:50}
# Fallback if empty or invalid
DEFAULT_PROJECT_NAME=${DEFAULT_PROJECT_NAME:-"my-project"}
PROJECT_NAME="$DEFAULT_PROJECT_NAME"

# Helper function to get validated selection from numeric menus
# Arguments:
#   1: Prompt text (e.g. "Select option [1-3]")
#   2: Default value (e.g. 1)
#   3: Max option number (e.g. 3)
get_validated_choice() {
  local prompt_text="$1"
  local default_val="$2"
  local max_val="$3"
  local val
  while true; do
    read -p "$prompt_text [Default: $default_val]: " val
    val=${val:-$default_val}
    # Check if val is a number and between 1 and max_val
    if [[ "$val" =~ ^[0-9]+$ ]] && [ "$val" -ge 1 ] && [ "$val" -le "$max_val" ]; then
      echo "$val"
      return 0
    else
      echo "Invalid selection. Please choose a number between 1 and $max_val." >&2
    fi
  done
}

# Helper function to get validated y/n
# Arguments:
#   1: Prompt text (e.g. "Include Python?")
#   2: Default value (e.g. "n")
get_validated_yn() {
  local prompt_text="$1"
  local default_val="$2"
  local val
  local display_default
  if [ "$default_val" = "y" ] || [ "$default_val" = "Y" ]; then
    display_default="Y/n"
  else
    display_default="y/N"
  fi
  while true; do
    read -p "$prompt_text [$display_default] [Default: $default_val]: " val
    val=${val:-$default_val}
    case "$val" in
      [Yy]|[Nn])
        case "$val" in
          [Yy]) echo "y" ;;
          [Nn]) echo "n" ;;
        esac
        return 0
        ;;
      *)
        echo "Invalid selection. Please enter y or n." >&2
        ;;
    esac
  done
}

# Helper to create a directory if it does not exist
mkdir_if_not_exists() {
  local dir="$1"
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
    echo "Created directory: $dir"
  else
    echo "Directory already exists: $dir"
  fi
}

# Helper to copy template file if it does not exist in target location
copy_template_file() {
  local rel_path="$1"
  local src_file="$TEMPLATES_DIR/$rel_path"
  local dest_file="$BASE_DIR/$rel_path"

  # Ensure destination directory exists
  mkdir_if_not_exists "$(dirname "$dest_file")"

  if [ ! -f "$dest_file" ]; then
    if [ -f "$src_file" ]; then
      if [ "$rel_path" = "README.md" ] || [ "$rel_path" = "ai/context/project.md" ]; then
        # Replace '# Project Name' with '# $PROJECT_NAME'
        sed "s/# Project Name/# $PROJECT_NAME/g" "$src_file" > "$dest_file"
        echo "Generated custom $rel_path for project: $PROJECT_NAME"
      else
        cp "$src_file" "$dest_file"
        echo "Copied template to: $dest_file"
      fi
    else
      echo "Warning: Template source file missing: $src_file"
    fi
  else
    echo "File already exists, skipping: $dest_file"
  fi
}



# Default values for AI-First rules configuration
AUTONOMY_MODE_VAL="- **Consultative Mode:** If you don't know something, see multiple solutions, or encounter ambiguity, STOP and ask the user. Do not make assumptions."
DEPENDENCY_POLICY_VAL="- **Strict Dependency Policy:** Never add new libraries or dependencies without explicit user permission. Prefer standard/existing project tools."
ARCHITECTURE_POLICY_VAL="- **Strict Architecture Scope:** Do not alter the project architecture (e.g., introducing new design patterns, changing database/state-management libraries, or renaming/creating top-level directories) without explicit human confirmation."
LICENSE_POLICY_VAL="- **License Constraints:** You are allowed to introduce dependencies only under strictly permissive licenses: MIT, Apache 2.0, BSD, or Public Domain. Copyleft/viral licenses (such as GPL, AGPL) are strictly forbidden. Refer to the knowledge/licenses.md file for details."
GIT_POLICY_VAL="- **Git Autonomy:** Do not stage, commit, or push files to Git. Modify the workspace files only and let the human review and commit."
SAFETY_POLICY_VAL="- **Critical Operations Policy:** You are strictly forbidden from running potentially destructive commands (e.g., database drops/truncates, force pushes, file deletions outside tmp/) without explicit human confirmation. Always ask first."
REFACTORING_POLICY_VAL="- **Strict Scope:** Modify only lines and files directly related to the requested task. Do not clean up unrelated code or formatting."
TESTING_COVERAGE_VAL="- **Testing Coverage:** Write tests only for the key/critical codebase functionality. Do not waste time on 100% coverage of minor helper functions."
TESTING_APPROACH_VAL="- **Testing Approach:** Write tests post-implementation (after coding features)."
TEST_EXECUTION_SCOPE_VAL="- **Test Execution Scope:** Run only relevant unit tests related to modified or new code files during local iterations."
COMMUNICATION_POLICY_VAL="- **Communication Style:** Be extremely concise and technical. Avoid conversational filler. Focus explanations on high-level architecture and exact code changes."
LINTING_POLICY_VAL="- **Linting & Formatting:** You MUST run code formatters and linters (e.g. Prettier, ESLint, Black, gofmt) on modified files after every edit to ensure styling compliance before finalizing tasks."
TASK_MANAGEMENT_POLICY_VAL="- **Task Boundaries:** Restrict modifications to the exact files needed. Do not touch more than 3 files or implement more than one logical sub-task per iteration without checking in or seeking approval."
CONTEXT_MANAGEMENT_POLICY_VAL="- **Context Management:** Minimize file reads. Do not read entire directories or large files unless essential. Target specific line ranges using line-specific tools or grep search first."
SECRETS_POLICY_VAL="- **Secrets & Security:** Never write API keys, passwords, or credentials to any files, including local env files or comments. Prompt the user to set them locally if needed."
TECH_STACK_VAL="- Stack: General / To be defined later.
- Adhere to the existing coding style of any file you edit."

NON_INTERACTIVE=false
GEN_CLAUDE=false
GEN_CURSOR=false
GEN_CLINE=false
GEN_WINDSURF=false
GEN_COPILOT=false
GEN_JETBRAINS=false
GEN_AIDER=false
GEN_TABNINE=false
GEN_CODY=false
INIT_GIT=false



# Parse flags
for arg in "$@"; do
  case $arg in
    --non-interactive|-n)
      NON_INTERACTIVE=true
      shift
      ;;
  esac
done

# Check if interactive (stdin and stdout are TTY)
if [ "$NON_INTERACTIVE" = false ] && [ -t 0 ] && [ -t 1 ]; then
  echo "============================================="
  echo "   AI-First Project Rule Configuration Wizard"
  echo "============================================="
  echo ""
  
  # --- SECTION 0: Project Details ---
  echo "--- SECTION 0: Project Details ---"
  while true; do
    echo "Please enter the project name."
    echo "Guidelines:"
    echo "  - Length: 3 to 50 characters"
    echo "  - Allowed characters: letters, numbers, spaces, hyphens (-), underscores (_), dots (.)"
    echo "  - Avoid special shell/system characters (e.g. /, \, *, ?, <, >, |, $, &)"
    echo ""
    read -p "Enter project name [Default: $DEFAULT_PROJECT_NAME]: " user_proj_name
    
    # Use default if empty
    user_proj_name=${user_proj_name:-$DEFAULT_PROJECT_NAME}
    
    # Validate length
    if [ ${#user_proj_name} -gt 50 ]; then
      echo "Error: Project name is too long (${#user_proj_name} chars). Max length is 50 characters."
      echo ""
      continue
    fi
    if [ ${#user_proj_name} -lt 3 ]; then
      echo "Error: Project name is too short (${#user_proj_name} chars). Min length is 3 characters."
      echo ""
      continue
    fi
    
    # Validate character regex
    if [[ ! "$user_proj_name" =~ ^[a-zA-Z0-9\ _.-]+$ ]]; then
      echo "Error: Project name contains forbidden characters."
      echo "Allowed: letters, numbers, spaces, dashes (-), underscores (_), and dots (.)"
      echo ""
      continue
    fi
    
    PROJECT_NAME="$user_proj_name"
    break
  done
  echo "Project name set to: $PROJECT_NAME"
  echo ""

  # --- SECTION 1: Autonomy & Decisions ---
  echo "--- SECTION 1: Autonomy & Decisions ---"
  echo "1.1) Choose AI Autonomy Mode:"
  echo "  [1] Consultative / Ask-First [Default]"
  echo "      AI stops and asks if unsure"
  echo "      - Pros: Safest mode. AI will never make assumptions or execute risky changes."
  echo "      - Cons: Slowest mode. Requires manual human confirmation for every ambiguous task."
  echo "      - Consequence: AI will stop and prompt for confirmation on any ambiguity."
  echo "  [2] Autonomous / Proactive"
  echo "      AI decides and implements, explains later"
  echo "      - Pros: Fast development. AI uses senior expertise to resolve ambiguity and write code."
  echo "      - Cons: Riskier. AI might make incorrect assumptions or write unwanted code."
  echo "      - Consequence: AI will make senior-level design decisions independently."
  echo "  [3] Plan-First"
  echo "      AI writes a plan for approval first"
  echo "      - Pros: High control. You review a formal design document before any code is written."
  echo "      - Cons: Adds an extra review step for all tasks, including minor ones."
  echo "      - Consequence: AI must write and get approval for an implementation plan first."
  opt=$(get_validated_choice "Select option [1-3]" 1 3)
  echo "Selected: $opt"
  case "$opt" in
    2)
      AUTONOMY_MODE_VAL="- **Autonomous Mode:** If you encounter ambiguity, decide what is best based on your senior expertise, implement it, and explain your choice in the summary. Ask only when blocked."
      ;;
    3)
      AUTONOMY_MODE_VAL="- **Plan-First Mode:** For any non-trivial changes, write an implementation plan first, present it to the user for approval, and wait for confirmation before writing code."
      ;;
  esac
  echo ""

  echo "1.2) Choose Dependency Policy:"
  echo "  [1] Strict / Ask-First  [Default]"
  echo "      AI must ask before installing packages"
  echo "      - Pros: Absolute control over external dependencies. Prevents bloat or license issues."
  echo "      - Cons: Developer must manually approve or install every library."
  echo "      - Consequence: AI is forbidden from adding packages to package.json/requirements.txt."
  echo "  [2] Proactive"
  echo "      AI can install standard packages if needed"
  echo "      - Pros: Seamless development. AI handles package installations on its own."
  echo "      - Cons: Risk of installing unneeded, heavy, or poorly-licensed libraries."
  echo "      - Consequence: AI may add standard, safe packages without prompting."
  opt=$(get_validated_choice "Select option [1-2]" 1 2)
  echo "Selected: $opt"
  case "$opt" in
    2)
      DEPENDENCY_POLICY_VAL="- **Proactive Dependency Policy:** You can install standard, widely-used packages if they are necessary for the implementation, but inform the user in the summary."
      ;;
  esac
  echo ""

  echo "1.3) Choose AI Architecture Policy:"
  echo "  [1] Strict / Ask-First  [Default]"
  echo "      AI cannot change patterns/directories/database without approval"
  echo "      - Pros: Protects codebase structure, patterns, and framework decisions."
  echo "      - Cons: AI cannot perform minor refactoring or structure cleanups independently."
  echo "      - Consequence: AI cannot change project patterns or folder paths without asking."
  echo "  [2] Flexible"
  echo "      AI can propose and implement minor refactors, but must document"
  echo "      - Pros: Allows AI to refactor small parts of code to improve design patterns."
  echo "      - Cons: Minor risk of codebase drifting from original developer design."
  echo "      - Consequence: AI can suggest and run minor refactorings as long as documented."
  echo "  [3] Full Autonomy / Change Architecture (NOT RECOMMENDED)"
  echo "      - Pros: AI can completely redesign structures and libraries for optimal efficiency."
  echo "      - Cons: High risk of structure fragmentation and incompatible design patterns."
  echo "      - Consequence: AI has full control over files, directories, databases, and schemas."
  opt=$(get_validated_choice "Select option [1-3]" 1 3)
  echo "Selected: $opt"
  case "$opt" in
    2)
      ARCHITECTURE_POLICY_VAL="- **Flexible Architecture Scope:** You may suggest and implement minor architectural improvements or helper utilities if they simplify the implementation, but document them in the task summary."
      ;;
    3)
      ARCHITECTURE_POLICY_VAL="- **Full Architectural Autonomy (NOT RECOMMENDED):** You have full autonomy to make architectural modifications, refactor structural design patterns, or rename/create top-level directories to achieve the task goal."
      ;;
  esac
  echo ""

  echo "1.4) Choose Dependency License Policy:"
  echo "  [1] Permissive Only  [Default]"
  echo "      Allows MIT, Apache 2.0, BSD, Public Domain"
  echo "      - Pros: Safe for proprietary and commercial software development."
  echo "      - Cons: Restricts the usage of some popular libraries under copyleft."
  echo "      - Consequence: AI will block any copyleft or viral licenses (like GPL/AGPL)."
  echo "  [2] Copyleft Tolerant"
  echo "      Permissive + LGPL, MPL"
  echo "      - Pros: Access to a wider range of open source packages."
  echo "      - Cons: Requires caution when statically linking or distributing products."
  echo "      - Consequence: AI allows LGPL/MPL but still blocks GPL/AGPL."
  echo "  [3] Any License"
  echo "      No license restrictions"
  echo "      - Pros: Maximum access to any library on npm/pip/go package registries."
  echo "      - Cons: High risk of legal violations or open-sourcing proprietary code."
  echo "      - Consequence: AI will not verify licenses when adding dependencies."
  opt=$(get_validated_choice "Select option [1-3]" 1 3)
  echo "Selected: $opt"
  case "$opt" in
    2)
      LICENSE_POLICY_VAL="- **License Constraints:** You are allowed to introduce dependencies under permissive licenses (MIT, Apache 2.0, BSD, Public Domain) and weak-copyleft licenses (LGPL, MPL). Refer to the knowledge/licenses.md file for details."
      ;;
    3)
      LICENSE_POLICY_VAL="- **License Constraints:** No strict license restrictions, but prefer widely-adopted, open-source libraries. Ensure compliance before commercial deployment."
      ;;
  esac
  echo ""

  echo "1.5) Choose Git Autonomy Mode:"
  echo "  [1] None  [Default]"
  echo "      AI only modifies files; human commits"
  echo "      - Pros: Maximum control. Every line of code is reviewed before staging."
  echo "      - Cons: Developer must manually stage, write commit messages, and commit."
  echo "      - Consequence: AI will leave git actions entirely to the developer."
  echo "  [2] Commit-First"
  echo "      AI commits changes on current branch using Conventional Commits"
  echo "      - Pros: Hands-free version control for rapid iterations."
  echo "      - Cons: Messy commit history if AI commits broken or half-implemented code."
  echo "      - Consequence: AI will stage and commit code using Conventional Commits."
  echo "  [3] Branch-First"
  echo "      AI creates dedicated feature branch and commits there"
  echo "      - Pros: Completely isolates AI work from main development branch."
  echo "      - Cons: Requires managing, reviewing, and merging additional git branches."
  echo "      - Consequence: AI creates a dedicated task branch to commit its changes."
  opt=$(get_validated_choice "Select option [1-3]" 1 3)
  echo "Selected: $opt"
  case "$opt" in
    2)
      GIT_POLICY_VAL="- **Git Autonomy:** You are allowed to stage and commit your changes on the current branch. Use Conventional Commits formatting (e.g., \"feat(ui): add button\") for commit messages."
      ;;
    3)
      GIT_POLICY_VAL="- **Git Autonomy:** Create a new feature branch for your changes (e.g., \"feature/task-NNN-desc\") and commit there. Do not commit directly to master/main."
      ;;
  esac
  echo ""

  echo "1.6) Choose Critical Operations / Safety Policy:"
  echo "  [1] Strict Protection  [Default]"
  echo "      AI forbidden from running destructive commands like DROP/DELETE/force push without asking"
  echo "      - Pros: Blocks accidental drops/truncates of databases, force pushes, or deletes."
  echo "      - Cons: AI will pause and ask even for simple deletions of obsolete files."
  echo "      - Consequence: AI is forbidden from running destructive CLI commands without asking."
  echo "  [2] Collaborative / Loose"
  echo "      AI can run destructive cleanup if task calls for it"
  echo "      - Pros: Fast cleanups of project history and deprecated components."
  echo "      - Cons: Risk of executing commands that permanently destroy data."
  echo "      - Consequence: AI is allowed to delete files or run cleanup commands independently."
  opt=$(get_validated_choice "Select option [1-2]" 1 2)
  echo "Selected: $opt"
  case "$opt" in
    2)
      SAFETY_POLICY_VAL="- **Critical Operations Policy:** You can perform cleanup actions (like removing obsolete prototype files or database tables) if it is directly required to complete the task."
      ;;
  esac
  echo ""

  echo "1.7) Choose Secrets & Security Policy:"
  echo "  [1] Zero-Trust / Strict Secret Protection [Default]"
  echo "      - Pros: Maximum security, zero risk of committing API keys, tokens, or credentials."
  echo "      - Cons: Developer must manually configure env files and local environment settings."
  echo "      - Consequence: AI is strictly forbidden from writing keys or credentials to any file."
  echo "  [2] Auto-Config / Permissive"
  echo "      - Pros: Automatic and seamless local environment configuration."
  echo "      - Cons: High risk of accidental credential leaks to Git."
  echo "      - Consequence: AI is allowed to write mock/test credentials to local config files."
  opt=$(get_validated_choice "Select option [1-2]" 1 2)
  echo "Selected: $opt"
  case "$opt" in
    2)
      SECRETS_POLICY_VAL="- **Secrets & Security:** You may generate or update local configuration and .env files with test or dummy credentials for local execution, but never commit them to Git."
      ;;
  esac
  echo ""

  echo "1.8) Choose Context & Cost Control Policy:"
  echo "  [1] Strict Token Diet  [Default]"
  echo "      Targeted reads, minimizes token usage"
  echo "      - Pros: Highly token-efficient, lower costs, fast response times."
  echo "      - Cons: AI might miss global dependencies or duplicate helper code."
  echo "      - Consequence: AI prioritizes grep and targeted line range reads over full file reads."
  echo "  [2] Context Rich"
  echo "      Comprehensive reads, full file and directory understanding"
  echo "      - Pros: Deeper understanding of full codebase dependencies, safer refactoring."
  echo "      - Cons: Extremely high token consumption, high costs, risks context window saturation."
  echo "      - Consequence: AI reads entire files and directories before making modifications."
  opt=$(get_validated_choice "Select option [1-2]" 1 2)
  echo "Selected: $opt"
  case "$opt" in
    2)
      CONTEXT_MANAGEMENT_POLICY_VAL="- **Context Management:** Read files in full to fully understand the module structure and dependencies before making any changes."
      ;;
  esac
  echo ""

  # --- SECTION 2: Coding & Refactoring ---
  echo "--- SECTION 2: Coding & Refactoring ---"
  echo "2.1) Choose Refactoring Policy:"
  echo "  [1] Strict Scope  [Default]"
  echo "      AI only touches what's requested"
  echo "      - Pros: Tiny PRs, minimal code churn, low risk of regression."
  echo "      - Cons: Technical debt and code smells persist in modified files."
  echo "      - Consequence: AI will modify only the exact lines requested for the task."
  echo "  [2] Boy Scout Rule"
  echo "      AI cleans up minor smells in edited files"
  echo "      - Pros: Continuous code health improvements, fixes types/formatting in passing."
  echo "      - Cons: Larger diffs, slight risk of regression in surrounding code."
  echo "      - Consequence: AI will format and clean up adjacent code smells in modified files."
  opt=$(get_validated_choice "Select option [1-2]" 1 2)
  echo "Selected: $opt"
  case "$opt" in
    2)
      REFACTORING_POLICY_VAL="- **Boy Scout Rule:** Proactively clean up minor code smells, formatting issues, or type safety gaps in files you are already modifying, as long as it does not expand the scope excessively."
      ;;
  esac
  echo ""

  echo "2.2) Choose Code Quality & Linting Policy:"
  echo "  [1] Automatic Formatter & Linter [Default]"
  echo "      - Pros: Code is always clean, matches project style, prevents merge conflicts."
  echo "      - Cons: Adds minor execution overhead and delay during tasks."
  echo "      - Consequence: AI will run tools like Prettier/ESLint/Black after modifications."
  echo "  [2] Minimalist"
  echo "      On-demand / Manual formatting"
  echo "      - Pros: Maximum iteration speed, zero tool execution overhead."
  echo "      - Cons: Risk of committing unformatted or style-violating code if developer forgets."
  echo "      - Consequence: AI relies entirely on manual compliance and will not auto-run tools."
  opt=$(get_validated_choice "Select option [1-2]" 1 2)
  echo "Selected: $opt"
  case "$opt" in
    2)
      LINTING_POLICY_VAL="- **Linting & Formatting:** Do not run formatting or linting commands automatically unless explicitly requested. Focus on functional correctness, adhering to the surrounding code style manually."
      ;;
  esac
  echo ""

  echo "2.3) Choose Task Boundaries & Granularity:"
  echo "  [1] Strict Boundaries & Micro-tasks [Default]"
  echo "      - Pros: Prevents scope creep, keeps PRs small, low risk of code conflicts."
  echo "      - Cons: Higher interaction frequency, requires user approval more often."
  echo "      - Consequence: AI will restrict modifications to <= 3 files and one sub-task at a time."
  echo "  [2] Flexible / Broad Scope"
  echo "      - Pros: Rapid implementation of wide features, fewer prompts."
  echo "      - Cons: Harder to debug, larger PRs, high risk of breaking unrelated systems."
  echo "      - Consequence: AI will implement multi-file refactors in a single pass."
  opt=$(get_validated_choice "Select option [1-2]" 1 2)
  echo "Selected: $opt"
  case "$opt" in
    2)
      TASK_MANAGEMENT_POLICY_VAL="- **Task Boundaries:** You have flexible scope. If a feature requires modifying several files or modules, implement them in a single stream, but document the full list of files affected in the summary."
      ;;
  esac
  echo ""

  echo "2.4) Choose AI Communication & Explanation Style:"
  echo "  [1] Concise & Technical [Default]"
  echo "      - Pros: Low token overhead, fast response times, fits cleanly in context."
  echo "      - Cons: Skips beginner-friendly explanations or pattern breakdowns."
  echo "      - Consequence: AI expects senior-level understanding and skips tutorial-like text."
  echo "  [2] Detailed & Educational"
  echo "      - Pros: High educational value, explains design patterns and choices."
  echo "      - Cons: Large token consumption, slower responses, potential context bloat."
  echo "      - Consequence: Good for learning a new stack, but increases costs and latency."
  opt=$(get_validated_choice "Select option [1-2]" 1 2)
  echo "Selected: $opt"
  case "$opt" in
    2)
      COMMUNICATION_POLICY_VAL="- **Communication Style:** Provide detailed, step-by-step explanations of your implementation decisions, design patterns, and potential alternatives. Focus on educational value."
      ;;
  esac
  echo ""

  # --- SECTION 3: Testing Strategy ---
  echo "--- SECTION 3: Testing Strategy ---"
  echo "3.1) Choose Testing Coverage Policy:"
  echo "  [1] Critical Path only  [Default]"
  echo "      Write tests only for key logic and critical paths"
  echo "      - Pros: Good safety-to-overhead ratio. Focuses tests where they matter most."
  echo "      - Cons: Helper functions and edge cases might remain untested."
  echo "      - Consequence: AI will write tests only for critical paths and core logic."
  echo "  [2] None"
  echo "      Skip tests for maximum speed"
  echo "      - Pros: Faster implementations, zero testing overhead."
  echo "      - Cons: High risk of regression and undetected bugs in production."
  echo "      - Consequence: AI will focus entirely on code and skip writing any tests."
  echo "  [3] Full Coverage"
  echo "      Task is complete only when fully covered and tests pass"
  echo "      - Pros: Maximum stability, code correctness verified automatically."
  echo "      - Cons: Much slower implementation times due to writing extensive test cases."
  echo "      - Consequence: AI will write thorough unit/integration tests for all paths."
  opt=$(get_validated_choice "Select option [1-3]" 1 3)
  echo "Selected: $opt"
  case "$opt" in
    2)
      TESTING_COVERAGE_VAL="- **Testing Coverage:** No tests are required for this project. Focus entirely on speed and coding."
      ;;
    3)
      TESTING_COVERAGE_VAL="- **Testing Coverage:** Full test coverage is required. A task or feature is only complete when it has thorough unit/integration tests covering all new paths, and all tests pass."
      ;;
  esac
  echo ""

  echo "3.2) Choose Testing Approach:"
  echo "  [1] Write-After / Post-Implementation  [Default]"
  echo "      Write tests after implementation"
  echo "      - Pros: Easier to write tests once code structure is established."
  echo "      - Cons: Tests might be biased by the implementation rather than requirements."
  echo "      - Consequence: AI writes code first, then writes tests to verify it."
  echo "  [2] TDD / Test-First"
  echo "      Write tests before implementation"
  echo "      - Pros: Ensures clean API design, forces implementation of requirements."
  echo "      - Cons: Higher startup overhead; requires mock setups before code is written."
  echo "      - Consequence: AI writes failing tests first, then implements code to pass."
  opt=$(get_validated_choice "Select option [1-2]" 1 2)
  echo "Selected: $opt"
  case "$opt" in
    2)
      TESTING_APPROACH_VAL="- **Testing Approach:** Follow Test-Driven Development (TDD) principles. Write failing tests before writing the implementation."
      ;;
  esac
  echo ""

  echo "3.3) Choose Test Execution Scope:"
  echo "  [1] Unit Tests only  [Default]"
  echo "      Run single unit tests related to changed code"
  echo "      - Pros: Fast test runs, local verification is quick."
  echo "      - Cons: Misses regressions in cross-module interactions."
  echo "      - Consequence: AI runs only single test files related to modified code."
  echo "  [2] Module / Integration Tests"
  echo "      Run unit and integration tests for the module"
  echo "      - Pros: Catches integration issues within the module or domain."
  echo "      - Cons: Slower test feedback loop."
  echo "      - Consequence: AI runs tests for the modified module/domain."
  echo "  [3] Full Suite"
  echo "      Run the entire test suite on every change"
  echo "      - Pros: 100% certainty that no regressions exist anywhere in the codebase."
  echo "      - Cons: Very slow developer loop if the test suite is large."
  echo "      - Consequence: AI runs the entire repository test suite on every change."
  opt=$(get_validated_choice "Select option [1-3]" 1 3)
  echo "Selected: $opt"
  case "$opt" in
    2)
      TEST_EXECUTION_SCOPE_VAL="- **Test Execution Scope:** Run unit and module integration tests for the current feature scope during iterations."
      ;;
    3)
      TEST_EXECUTION_SCOPE_VAL="- **Test Execution Scope:** Run the entire test suite of the repository to ensure no regressions on every meaningful code change."
      ;;
  esac
  echo ""

  # --- SECTION 4: Tech Stack ---
  echo "--- SECTION 4: Tech Stack ---"
  echo "WARNING: Select ONLY the technologies you will actually use. Adding unnecessary"
  echo "technologies clutters the AI's memory, leading to inefficient token usage and costs."
  echo "Since a project grows over time, adding new technologies or rules incrementally"
  echo "(by editing 'ai/rules/coding.md') is the recommended approach."
  echo ""
  echo "4.1) Select Tech Stack / Framework option:"
  echo "  [1] Decide later / General [Default]"
  echo "      - Universal layout. Adapts to any language or framework automatically."
  echo "  [2] Custom Selection / Choose multiple"
  echo "      - Choose specific technologies from a list of popular options."
  opt=$(get_validated_choice "Select option [1-2]" 1 2)
  echo "Selected: $opt"

  if [ "$opt" -eq 1 ]; then
    TECH_STACK_VAL="- Stack: General / To be defined later.
- Adhere to the existing coding style of any file you edit."
  else
    chosen_stacks=()
    
    choice=$(get_validated_yn "Include Node.js / TypeScript?" "n")
    if [ "$choice" = "y" ]; then
      chosen_stacks+=("- Stack: Node.js / TypeScript.
- Use strict TypeScript configurations.
- Prefer async/await over raw Promises.
- Avoid using \`any\` type annotations; define interfaces or types.")
    fi

    choice=$(get_validated_yn "Include Python?" "n")
    if [ "$choice" = "y" ]; then
      chosen_stacks+=("- Stack: Python.
- Adhere to PEP 8 standards.
- Use type hints for all public function signatures.
- Prefer list comprehensions and generator expressions where readable.")
    fi

    choice=$(get_validated_yn "Include Go?" "n")
    if [ "$choice" = "y" ]; then
      chosen_stacks+=("- Stack: Go.
- Use standard Go conventions (\`gofmt\`, \`go lint\`).
- Explicitly handle all errors; do not ignore them.
- Keep packages cohesive and API surfaces clean.")
    fi

    choice=$(get_validated_yn "Include React / Next.js?" "n")
    if [ "$choice" = "y" ]; then
      chosen_stacks+=("- Stack: React / Next.js.
- Use functional components with hooks.
- Keep components small, reusable, and state localized.
- Follow Next.js directory and routing conventions.")
    fi

    choice=$(get_validated_yn "Include Rust?" "n")
    if [ "$choice" = "y" ]; then
      chosen_stacks+=("- Stack: Rust.
- Follow Cargo and standard Clippy lints.
- Handle results/errors explicitly; avoid \`.unwrap()\` in production code.
- Adhere to ownership and borrowing rules without unnecessary cloning.")
    fi

    choice=$(get_validated_yn "Include Java / Spring Boot?" "n")
    if [ "$choice" = "y" ]; then
      chosen_stacks+=("- Stack: Java / Spring Boot.
- Follow standard Java CamelCase naming conventions.
- Use constructor-based dependency injection.
- Utilize standard Spring Boot annotations correctly and keep controllers thin.")
    fi

    choice=$(get_validated_yn "Include C# / .NET?" "n")
    if [ "$choice" = "y" ]; then
      chosen_stacks+=("- Stack: C# / .NET.
- Follow Microsoft C# coding conventions and naming guidelines (PascalCase).
- Use modern C# language features and expression-bodied members.
- Implement async/await correctly for all I/O bound operations.")
    fi

    choice=$(get_validated_yn "Include PHP / Laravel?" "n")
    if [ "$choice" = "y" ]; then
      chosen_stacks+=("- Stack: PHP / Laravel.
- Adhere to PSR-12 coding standard.
- Declare strict types (\`declare(strict_types=1);\`).
- Leverage Eloquent ORM correctly and avoid raw SQL where possible.")
    fi

    if [ ${#chosen_stacks[@]} -eq 0 ]; then
      echo "No technologies selected. Defaulting to General."
      TECH_STACK_VAL="- Stack: General / To be defined later.
- Adhere to the existing coding style of any file you edit."
    else
      # Join with empty line separating the blocks
      TECH_STACK_VAL=""
      for idx in "${!chosen_stacks[@]}"; do
        if [ $idx -eq 0 ]; then
          TECH_STACK_VAL="${chosen_stacks[$idx]}"
        else
          TECH_STACK_VAL="${TECH_STACK_VAL}

${chosen_stacks[$idx]}"
        fi
      done
    fi
  fi
  echo ""

  # --- SECTION 5: AI IDE Configuration ---
  echo "--- SECTION 5: AI IDE Configuration ---"
  echo "5.1) Choose which AI IDE configuration files (thin pointers) to generate:"
  echo "  [1] Standard  [Default]"
  echo "      Only AGENTS.md — works natively with all modern AI agents"
  echo "      - Pros: Zero root directory clutter, works with all modern AI agents natively."
  echo "      - Cons: Requires AI agents to discover rules from the root file without custom pointers."
  echo "      - Consequence: Only the central AGENTS.md is created."
  echo "  [2] Custom"
  echo "      Generates AGENTS.md plus your choice of additional AI IDE pointers"
  echo "      - Pros: Tailored configuration files created only for the IDEs you actually use."
  echo "      - Cons: Requires answering individual prompts for each supported IDE."
  echo "      - Consequence: AGENTS.md is generated, and you choose which extra pointer files to add."
  echo "  [3] All"
  echo "      Generate files for all 10 popular AI IDEs"
  echo "      - Pros: Complete workspace readiness. Any team developer's IDE will pick up the rules."
  echo "      - Cons: Creates minor clutter by adding 10 pointer files in the root."
  echo "      - Consequence: Pointers for Claude Code, Cursor, Cline, Windsurf, Copilot, etc., are all created."
  opt=$(get_validated_choice "Select option [1-3]" 1 3)
  echo "Selected: $opt"
  case "$opt" in
    1)
      # Standard (only AGENTS.md) - already initialized to false
      ;;
    3)
      GEN_CLAUDE=true
      GEN_CURSOR=true
      GEN_CLINE=true
      GEN_WINDSURF=true
      GEN_COPILOT=true
      GEN_JETBRAINS=true
      GEN_AIDER=true
      GEN_TABNINE=true
      GEN_CODY=true
      ;;
    2)
      choice=$(get_validated_yn "Generate Claude Code pointer (CLAUDE.md)?" "n")
      if [ "$choice" = "y" ]; then
        GEN_CLAUDE=true
        echo "Selected: Yes"
      else
        echo "Selected: No"
      fi

      choice=$(get_validated_yn "Generate Cursor pointer (.cursorrules)?" "n")
      if [ "$choice" = "y" ]; then
        GEN_CURSOR=true
        echo "Selected: Yes"
      else
        echo "Selected: No"
      fi

      choice=$(get_validated_yn "Generate Cline/Roo Code pointer (.clinerules)?" "n")
      if [ "$choice" = "y" ]; then
        GEN_CLINE=true
        echo "Selected: Yes"
      else
        echo "Selected: No"
      fi

      choice=$(get_validated_yn "Generate Windsurf pointer (.windsurfrules)?" "n")
      if [ "$choice" = "y" ]; then
        GEN_WINDSURF=true
        echo "Selected: Yes"
      else
        echo "Selected: No"
      fi

      choice=$(get_validated_yn "Generate GitHub Copilot pointer (.github/copilot-instructions.md)?" "n")
      if [ "$choice" = "y" ]; then
        GEN_COPILOT=true
        echo "Selected: Yes"
      else
        echo "Selected: No"
      fi

      choice=$(get_validated_yn "Generate JetBrains AI Assistant pointer (.aiassistant/rules/main.md)?" "n")
      if [ "$choice" = "y" ]; then
        GEN_JETBRAINS=true
        echo "Selected: Yes"
      else
        echo "Selected: No"
      fi

      choice=$(get_validated_yn "Generate Aider pointer (CONVENTIONS.md & .aider.conf.yml)?" "n")
      if [ "$choice" = "y" ]; then
        GEN_AIDER=true
        echo "Selected: Yes"
      else
        echo "Selected: No"
      fi

      choice=$(get_validated_yn "Generate Tabnine pointer (.tabnine/guidelines/main.md)?" "n")
      if [ "$choice" = "y" ]; then
        GEN_TABNINE=true
        echo "Selected: Yes"
      else
        echo "Selected: No"
      fi

      choice=$(get_validated_yn "Generate Sourcegraph Cody pointer (.cody/rules.md)?" "n")
      if [ "$choice" = "y" ]; then
        GEN_CODY=true
        echo "Selected: Yes"
      else
        echo "Selected: No"
      fi
      ;;
  esac
  echo ""

  # --- SECTION 6: Git Version Control ---
  echo "--- SECTION 6: Git Version Control ---"
  echo "6.1) Do you want to initialize Git repository tracking?"
  echo "  [1] No  [Default]"
  echo "      Skip Git tracking for now"
  echo "      - Pros: Quick setup, no Git repository directory created."
  echo "      - Cons: No version control or change tracking immediately."
  echo "      - Consequence: Git repository will not be initialized."
  echo "  [2] Yes, initialize Git and track changes from the start"
  echo "      - Pros: Instant tracking, easy to review changes, standard professional setup."
  echo "      - Cons: Adds the '.git' directory to the workspace root."
  echo "      - Consequence: Initializes Git repo, copies 'knowledge/git.md' template, and stages initial files."
  opt=$(get_validated_choice "Select option [1-2]" 1 2)
  echo "Selected: $opt"
  if [ "$opt" = "2" ]; then
    INIT_GIT=true
  fi
  echo ""
fi

# Helper to generate file with user preferences replaced
generate_from_template() {
  local template_path="$1"
  local dest_path="$2"
  
  while IFS= read -r line || [ -n "$line" ]; do
    if [[ "$line" == *"__REFACTORING_POLICY__"* ]]; then
      echo "$REFACTORING_POLICY_VAL"
    elif [[ "$line" == *"__TECH_STACK__"* ]]; then
      echo "$TECH_STACK_VAL"
    elif [[ "$line" == *"__AUTONOMY_MODE__"* ]]; then
      echo "$AUTONOMY_MODE_VAL"
    elif [[ "$line" == *"__DEPENDENCY_POLICY__"* ]]; then
      echo "$DEPENDENCY_POLICY_VAL"
    elif [[ "$line" == *"__ARCHITECTURE_POLICY__"* ]]; then
      echo "$ARCHITECTURE_POLICY_VAL"
    elif [[ "$line" == *"__LICENSE_POLICY__"* ]]; then
      echo "$LICENSE_POLICY_VAL"
    elif [[ "$line" == *"__GIT_POLICY__"* ]]; then
      echo "$GIT_POLICY_VAL"
    elif [[ "$line" == *"__SAFETY_POLICY__"* ]]; then
      echo "$SAFETY_POLICY_VAL"
    elif [[ "$line" == *"__TESTING_COVERAGE__"* ]]; then
      echo "$TESTING_COVERAGE_VAL"
    elif [[ "$line" == *"__TESTING_APPROACH__"* ]]; then
      echo "$TESTING_APPROACH_VAL"
    elif [[ "$line" == *"__TEST_EXECUTION_SCOPE__"* ]]; then
      echo "$TEST_EXECUTION_SCOPE_VAL"
    elif [[ "$line" == *"__COMMUNICATION_POLICY__"* ]]; then
      echo "$COMMUNICATION_POLICY_VAL"
    elif [[ "$line" == *"__LINTING_POLICY__"* ]]; then
      echo "$LINTING_POLICY_VAL"
    elif [[ "$line" == *"__TASK_MANAGEMENT_POLICY__"* ]]; then
      echo "$TASK_MANAGEMENT_POLICY_VAL"
    elif [[ "$line" == *"__CONTEXT_MANAGEMENT_POLICY__"* ]]; then
      echo "$CONTEXT_MANAGEMENT_POLICY_VAL"
    elif [[ "$line" == *"__SECRETS_POLICY__"* ]]; then
      echo "$SECRETS_POLICY_VAL"
    else
      echo "$line"
    fi
  done < "$template_path" > "$dest_path"
}

generate_rules_file() {
  local rel_path="$1"
  local src_file="$TEMPLATES_DIR/$rel_path"
  local dest_file="$BASE_DIR/$rel_path"

  mkdir_if_not_exists "$(dirname "$dest_file")"

  if [ ! -f "$dest_file" ]; then
    if [ -f "$src_file" ]; then
      generate_from_template "$src_file" "$dest_file"
      echo "Generated rules file: $dest_file"
    else
      echo "Warning: Template source file missing: $src_file"
    fi
  else
    echo "File already exists, skipping: $dest_file"
  fi
}

# Create minimal directories
mkdir_if_not_exists "$BASE_DIR/docs"
mkdir_if_not_exists "$BASE_DIR/src"
mkdir_if_not_exists "$BASE_DIR/tests"
mkdir_if_not_exists "$BASE_DIR/tmp"
touch "$BASE_DIR/tmp/.gitkeep"

# Copy minimal files from templates
copy_template_file "AGENTS.md"
copy_template_file "README.md"
copy_template_file ".gitignore"
copy_template_file "MANIFEST.md"
copy_template_file "ai/context/project.md"
copy_template_file "ai/context/structure-map.md"
copy_template_file "ai/workflows/new-feature.md"
copy_template_file "ai/skills/example-skill.md"
copy_template_file "ai/history/conver-001-example-transcript.md"
copy_template_file "ai/lessons/lesson-001-example.md"
copy_template_file "ai/runs/run-001-example-automation.sh"

# Generate dynamically configured rules
generate_rules_file "ai/rules/coding.md"
generate_rules_file "ai/rules/security.md"
generate_rules_file "ai/rules/testing.md"

# Generate AI IDE pointer files if requested
if [ "$GEN_CLAUDE" = true ]; then
  cat << 'EOF' > "$BASE_DIR/CLAUDE.md"
Refer to AGENTS.md for coding guidelines, architecture, and workflows.
Do not deviate from the workflows defined in ai/workflows/.
EOF
  echo "Generated Claude Code pointer: CLAUDE.md"
fi

if [ "$GEN_CURSOR" = true ]; then
  cat << 'EOF' > "$BASE_DIR/.cursorrules"
Always read AGENTS.md first to understand the project structure and rules.
Follow the guidelines in ai/rules/coding.md for all code modifications.
EOF
  echo "Generated Cursor pointer: .cursorrules"
fi

if [ "$GEN_CLINE" = true ]; then
  cat << 'EOF' > "$BASE_DIR/.clinerules"
Read AGENTS.md to understand the repository structure and context.
Adhere strictly to the active guidelines in ai/rules/.
EOF
  echo "Generated Cline/Roo Code pointer: .clinerules"
fi

if [ "$GEN_WINDSURF" = true ]; then
  cat << 'EOF' > "$BASE_DIR/.windsurfrules"
Always read AGENTS.md first to understand the project rules, coding standards, and workflows.
Follow the guidelines in ai/rules/coding.md for code modifications.
EOF
  echo "Generated Windsurf pointer: .windsurfrules"
fi

if [ "$GEN_COPILOT" = true ]; then
  mkdir -p "$BASE_DIR/.github"
  cat << 'EOF' > "$BASE_DIR/.github/copilot-instructions.md"
Always refer to AGENTS.md in the root directory for general project instructions, tech stack rules, and coding standards.
EOF
  echo "Generated GitHub Copilot pointer: .github/copilot-instructions.md"
fi

if [ "$GEN_JETBRAINS" = true ]; then
  mkdir -p "$BASE_DIR/.aiassistant/rules"
  cat << 'EOF' > "$BASE_DIR/.aiassistant/rules/main.md"
# JetBrains AI Assistant Rules
Always refer to AGENTS.md in the project root directory for coding standards, autonomy rules, and workflows.
EOF
  echo "Generated JetBrains AI Assistant pointer: .aiassistant/rules/main.md"
fi

if [ "$GEN_AIDER" = true ]; then
  cat << 'EOF' > "$BASE_DIR/CONVENTIONS.md"
Always read AGENTS.md first to understand coding style, testing rules, and project workflows.
EOF
  cat << 'EOF' > "$BASE_DIR/.aider.conf.yml"
read:
  - CONVENTIONS.md
EOF
  echo "Generated Aider pointers: CONVENTIONS.md & .aider.conf.yml"
fi

if [ "$GEN_TABNINE" = true ]; then
  mkdir -p "$BASE_DIR/.tabnine/guidelines"
  cat << 'EOF' > "$BASE_DIR/.tabnine/guidelines/main.md"
# Tabnine Guidelines
Refer to AGENTS.md in the project root for coding rules, testing constraints, and workflows.
EOF
  echo "Generated Tabnine pointer: .tabnine/guidelines/main.md"
fi

if [ "$GEN_CODY" = true ]; then
  mkdir -p "$BASE_DIR/.cody"
  cat << 'EOF' > "$BASE_DIR/.cody/rules.md"
Always read AGENTS.md in the root directory for project-specific rules, tech stack details, and coding conventions.
EOF
  echo "Generated Cody pointer: .cody/rules.md"
fi



if [ "$INIT_GIT" = true ]; then
  mkdir_if_not_exists "$BASE_DIR/knowledge"
  copy_template_file "knowledge/git.md"
fi

echo "Minimal project structure created successfully."

# --- Post-Setup Cleanup ---
CLEANUP_OPTION=1

if [ "$NON_INTERACTIVE" = false ] && [ -t 0 ] && [ -t 1 ]; then
  echo ""
  echo "============================================="
  echo "   Post-Setup Cleanup"
  echo "============================================="
  echo "The setup scripts are no longer needed and will be removed."
  echo "The 'templates/' directory contains some one-time templates that have already"
  echo "been initialized, as well as optional templates for future project growth."
  echo ""
  echo "What would you like to do?"
  echo "  [1] Clean up one-time templates, but KEEP remaining future-growth templates in 'templates/' [Default]"
  echo "      - Pros: Preserves incremental templates for future use while keeping them clean."
  echo "      - Cons: Keeps the 'templates/' folder in your project root."
  echo "  [2] Delete the entire 'templates/' directory permanently"
  echo "      - Pros: Absolute minimal project files in root."
  echo "      - Cons: You lose the templates for future directory scaffolding."
  echo "  [3] Keep everything as-is (do not delete or cleanup anything)"
  echo "      - Pros: Leaves all setup files and templates completely untouched."
  echo "      - Cons: Clutters the root directory with unused setup scripts."
  opt=$(get_validated_choice "Select option [1-3]" 1 3)
  echo "Selected: $opt"
  CLEANUP_OPTION=$opt
else
  # Default to option 1 in non-interactive mode
  echo "Non-interactive run: Cleaning up setup scripts and one-time templates..."
  CLEANUP_OPTION=1
fi

case "$CLEANUP_OPTION" in
  1)
    echo "Cleaning up one-time templates and setup scripts..."
    # Remove one-time template files
    rm -f "$TEMPLATES_DIR/README.md" "$TEMPLATES_DIR/AGENTS.md" "$TEMPLATES_DIR/MANIFEST.md" "$TEMPLATES_DIR/.gitignore"
    # Remove one-time template folder
    rm -rf "$TEMPLATES_DIR/ai"
    # Remove sibling setup script
    rm -f "$BASE_DIR/create_minimal_structure.ps1"
    ;;
  2)
    echo "Deleting all templates and setup scripts..."
    rm -rf "$TEMPLATES_DIR"
    rm -f "$BASE_DIR/create_minimal_structure.ps1"
    if [ -f "$BASE_DIR/MANIFEST.md" ]; then
      grep -v 'templates/' "$BASE_DIR/MANIFEST.md" > "$BASE_DIR/MANIFEST.md.tmp" && mv "$BASE_DIR/MANIFEST.md.tmp" "$BASE_DIR/MANIFEST.md"
    fi
    ;;
  3)
    echo "Keeping all files as-is."
    ;;
esac

if [ "$INIT_GIT" = true ]; then
  echo "Initializing Git repository..."
  git init
  echo "Staging files in Git..."
  git add .
  # Unstage the setup scripts from Git tracking
  git reset -- "$0" "$BASE_DIR/create_minimal_structure.ps1" 2>/dev/null || true
  echo "Git repository initialized and files staged successfully."
fi

# Print final status message
echo ""
echo "============================================================="
echo "   Project structure for: $PROJECT_NAME"
echo "   is ready for AI-first collaboration!"
echo ""
echo "   Project information is available in README.md"
echo "============================================================="
echo ""

# Self delete at the very end if cleanup was requested
if [ "$CLEANUP_OPTION" = "1" ] || [ "$CLEANUP_OPTION" = "2" ]; then
  exec rm -f -- "$0"
fi

