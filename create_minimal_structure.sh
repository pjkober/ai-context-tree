#!/usr/bin/env bash

# Script to create minimal project structure as defined in ai-context-tree
# ------------------------------------------------------------
set -e

# Determine the directory where this script lives – treat it as the project root
BASE_DIR="."
TEMPLATES_DIR="$BASE_DIR/file-templates"

# Check if templates directory is present
if [ ! -d "$TEMPLATES_DIR" ]; then
  echo "Error: 'file-templates/' directory not found at $TEMPLATES_DIR."
  echo "This script must be run inside the cloned repository context containing file-templates."
  echo "If you are setting up a new project, copy BOTH this script and the 'file-templates/' directory to your project root."
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
  echo "  [1] Consultative / Ask-First (AI stops and asks if unsure) [Default]"
  echo "  [2] Autonomous / Proactive (AI decides and implements, explains later)"
  echo "  [3] Plan-First (AI writes a plan for approval first)"
  read -p "Select option [1-3] [Default: 1]: " opt
  opt=${opt:-1}
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
  echo "  [1] Strict / Ask-First (AI must ask before installing packages) [Default]"
  echo "  [2] Proactive (AI can install standard packages if needed)"
  read -p "Select option [1-2] [Default: 1]: " opt
  opt=${opt:-1}
  case "$opt" in
    2)
      DEPENDENCY_POLICY_VAL="- **Proactive Dependency Policy:** You can install standard, widely-used packages if they are necessary for the implementation, but inform the user in the summary."
      ;;
  esac
  echo ""

  echo "1.3) Choose AI Architecture Policy:"
  echo "  [1] Strict / Ask-First (AI cannot change patterns/directories/database without approval) [Default]"
  echo "  [2] Flexible (AI can propose and implement minor refactors, but must document)"
  echo "  [3] Full Autonomy / Change Architecture (NOT RECOMMENDED) (AI can fully change architecture and patterns without asking)"
  read -p "Select option [1-3] [Default: 1]: " opt
  opt=${opt:-1}
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
  echo "  [1] Permissive Only (MIT, Apache 2.0, BSD, Public Domain) [Default]"
  echo "  [2] Copyleft Tolerant (Permissive + LGPL, MPL)"
  echo "  [3] Any License (No license restrictions)"
  read -p "Select option [1-3] [Default: 1]: " opt
  opt=${opt:-1}
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
  echo "  [1] None (AI only modifies files; human commits) [Default]"
  echo "  [2] Commit-First (AI commits changes on current branch using Conventional Commits)"
  echo "  [3] Branch-First (AI creates dedicated feature branch and commits there)"
  read -p "Select option [1-3] [Default: 1]: " opt
  opt=${opt:-1}
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
  echo "  [1] Strict Protection (AI forbidden from running destructive commands like DROP/DELETE/force push without asking) [Default]"
  echo "  [2] Collaborative / Loose (AI can run destructive cleanup if task calls for it)"
  read -p "Select option [1-2] [Default: 1]: " opt
  opt=${opt:-1}
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
  read -p "Select option [1-2] [Default: 1]: " opt
  opt=${opt:-1}
  case "$opt" in
    2)
      SECRETS_POLICY_VAL="- **Secrets & Security:** You may generate or update local configuration and .env files with test or dummy credentials for local execution, but never commit them to Git."
      ;;
  esac
  echo ""

  echo "1.8) Choose Context & Cost Control Policy:"
  echo "  [1] Strict Token Diet (Targeted Reads) [Default]"
  echo "      - Pros: Highly token-efficient, lower costs, fast response times."
  echo "      - Cons: AI might miss global dependencies or duplicate helper code."
  echo "      - Consequence: AI prioritizes grep and targeted line range reads over full file reads."
  echo "  [2] Context Rich (Comprehensive Reads)"
  echo "      - Pros: Deeper understanding of full codebase dependencies, safer refactoring."
  echo "      - Cons: Extremely high token consumption, high costs, risks context window saturation."
  echo "      - Consequence: AI reads entire files and directories before making modifications."
  read -p "Select option [1-2] [Default: 1]: " opt
  opt=${opt:-1}
  case "$opt" in
    2)
      CONTEXT_MANAGEMENT_POLICY_VAL="- **Context Management:** Read files in full to fully understand the module structure and dependencies before making any changes."
      ;;
  esac
  echo ""

  # --- SECTION 2: Coding & Refactoring ---
  echo "--- SECTION 2: Coding & Refactoring ---"
  echo "2.1) Choose Refactoring Policy:"
  echo "  [1] Strict Scope (AI only touches what's requested) [Default]"
  echo "  [2] Boy Scout Rule (AI cleans up minor smells in edited files)"
  read -p "Select option [1-2] [Default: 1]: " opt
  opt=${opt:-1}
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
  echo "  [2] Minimalist (On-demand / Manual)"
  echo "      - Pros: Maximum iteration speed, zero tool execution overhead."
  echo "      - Cons: Risk of committing unformatted or style-violating code if developer forgets."
  echo "      - Consequence: AI relies entirely on manual compliance and will not auto-run tools."
  read -p "Select option [1-2] [Default: 1]: " opt
  opt=${opt:-1}
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
  read -p "Select option [1-2] [Default: 1]: " opt
  opt=${opt:-1}
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
  read -p "Select option [1-2] [Default: 1]: " opt
  opt=${opt:-1}
  case "$opt" in
    2)
      COMMUNICATION_POLICY_VAL="- **Communication Style:** Provide detailed, step-by-step explanations of your implementation decisions, design patterns, and potential alternatives. Focus on educational value."
      ;;
  esac
  echo ""

  # --- SECTION 3: Testing Strategy ---
  echo "--- SECTION 3: Testing Strategy ---"
  echo "3.1) Choose Testing Coverage Policy:"
  echo "  [1] Critical Path only (Write tests only for key logic/critical paths) [Default]"
  echo "  [2] None (Skip tests for maximum speed)"
  echo "  [3] Full Coverage (Task is complete only when fully covered and tests pass)"
  read -p "Select option [1-3] [Default: 1]: " opt
  opt=${opt:-1}
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
  echo "  [1] Write-After / Post-Implementation (Write tests after implementation) [Default]"
  echo "  [2] TDD / Test-First (Write tests before implementation)"
  read -p "Select option [1-2] [Default: 1]: " opt
  opt=${opt:-1}
  case "$opt" in
    2)
      TESTING_APPROACH_VAL="- **Testing Approach:** Follow Test-Driven Development (TDD) principles. Write failing tests before writing the implementation."
      ;;
  esac
  echo ""

  echo "3.3) Choose Test Execution Scope:"
  echo "  [1] Unit Tests only (Run single unit tests related to changed code) [Default]"
  echo "  [2] Module / Integration Tests (Run unit and integration tests for the module)"
  echo "  [3] Full Suite (Run the entire test suite on every change)"
  read -p "Select option [1-3] [Default: 1]: " opt
  opt=${opt:-1}
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
  echo "4.1) Select Tech Stack / Framework:"
  echo "  [1] Node.js / TypeScript"
  echo "  [2] Python"
  echo "  [3] Go"
  echo "  [4] React / Next.js"
  echo "  [5] Decide later / I'll customize it later [Default]"
  read -p "Select option [1-5] [Default: 5]: " opt
  opt=${opt:-5}
  case "$opt" in
    1)
      TECH_STACK_VAL="- Stack: Node.js / TypeScript.
- Use strict TypeScript configurations.
- Prefer async/await over raw Promises.
- Avoid using \`any\` type annotations; define interfaces or types."
      ;;
    2)
      TECH_STACK_VAL="- Stack: Python.
- Adhere to PEP 8 standards.
- Use type hints for all public function signatures.
- Prefer list comprehensions and generator expressions where readable."
      ;;
    3)
      TECH_STACK_VAL="- Stack: Go.
- Use standard Go conventions (\`gofmt\`, \`go lint\`).
- Explicitly handle all errors; do not ignore them.
- Keep packages cohesive and API surfaces clean."
      ;;
    4)
      TECH_STACK_VAL="- Stack: React / Next.js.
- Use functional components with hooks.
- Keep components small, reusable, and state localized.
- Follow Next.js directory and routing conventions."
      ;;
  esac
  echo ""

  # --- SECTION 5: AI IDE Configuration ---
  echo "--- SECTION 5: AI IDE Configuration ---"
  echo "5.1) Choose which AI IDE configuration files (thin pointers) to generate:"
  echo "  [1] Standard (only AGENTS.md) [Default]"
  echo "      (Recommended for tools with native AGENTS.md support: Antigravity, OpenCode, Gemini CLI, etc.)"
  echo "  [2] Custom (Choose individually)"
  echo "      (Generate pointers for: Claude Code, Cursor, Cline, Windsurf, Copilot, JetBrains AI, Aider, Tabnine, Cody)"
  echo "  [3] All (Generate files for all 10 popular AI IDEs)"
  read -p "Select option [1-3] [Default: 1]: " opt
  opt=${opt:-1}
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
      read -p "Generate Claude Code pointer (CLAUDE.md)? [y/N] [Default: N]: " choice
      choice=${choice:-n}
      if [[ "$choice" =~ ^[yY](es)?$ ]]; then GEN_CLAUDE=true; fi

      read -p "Generate Cursor pointer (.cursorrules)? [y/N] [Default: N]: " choice
      choice=${choice:-n}
      if [[ "$choice" =~ ^[yY](es)?$ ]]; then GEN_CURSOR=true; fi

      read -p "Generate Cline/Roo Code pointer (.clinerules)? [y/N] [Default: N]: " choice
      choice=${choice:-n}
      if [[ "$choice" =~ ^[yY](es)?$ ]]; then GEN_CLINE=true; fi

      read -p "Generate Windsurf pointer (.windsurfrules)? [y/N] [Default: N]: " choice
      choice=${choice:-n}
      if [[ "$choice" =~ ^[yY](es)?$ ]]; then GEN_WINDSURF=true; fi

      read -p "Generate GitHub Copilot pointer (.github/copilot-instructions.md)? [y/N] [Default: N]: " choice
      choice=${choice:-n}
      if [[ "$choice" =~ ^[yY](es)?$ ]]; then GEN_COPILOT=true; fi

      read -p "Generate JetBrains AI Assistant pointer (.aiassistant/rules/main.md)? [y/N] [Default: N]: " choice
      choice=${choice:-n}
      if [[ "$choice" =~ ^[yY](es)?$ ]]; then GEN_JETBRAINS=true; fi

      read -p "Generate Aider pointer (CONVENTIONS.md & .aider.conf.yml)? [y/N] [Default: N]: " choice
      choice=${choice:-n}
      if [[ "$choice" =~ ^[yY](es)?$ ]]; then GEN_AIDER=true; fi

      read -p "Generate Tabnine pointer (.tabnine/guidelines/main.md)? [y/N] [Default: N]: " choice
      choice=${choice:-n}
      if [[ "$choice" =~ ^[yY](es)?$ ]]; then GEN_TABNINE=true; fi

      read -p "Generate Sourcegraph Cody pointer (.cody/rules.md)? [y/N] [Default: N]: " choice
      choice=${choice:-n}
      if [[ "$choice" =~ ^[yY](es)?$ ]]; then GEN_CODY=true; fi
      ;;
  esac
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



echo "Minimal project structure created successfully."

# --- Post-Setup Cleanup ---
if [ "$NON_INTERACTIVE" = false ] && [ -t 0 ] && [ -t 1 ]; then
  echo ""
  echo "============================================="
  echo "   Post-Setup Cleanup"
  echo "============================================="
  echo "The initialization script and 'file-templates/' are no longer needed."
  echo "What would you like to do with them?"
  echo "  [1] Move to 'tmp/' directory (recommended, keeps root clean) [Default]"
  echo "  [2] Delete permanently"
  echo "  [3] Keep them in the root directory"
  read -p "Select option [1-3]: " opt
  case "$opt" in
    2)
      echo "Deleting setup script and templates..."
      rm -rf "$TEMPLATES_DIR"
      exec rm -f -- "$0"
      ;;
    3)
      echo "Keeping setup script and templates."
      ;;
    *)
      echo "Moving setup script and templates to 'tmp/'..."
      mkdir_if_not_exists "$BASE_DIR/tmp"
      if [ -d "$TEMPLATES_DIR" ]; then
        mv "$TEMPLATES_DIR" "$BASE_DIR/tmp/"
      fi
      exec mv -- "$0" "$BASE_DIR/tmp/"
      ;;
  esac
fi

