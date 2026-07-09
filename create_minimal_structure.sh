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
      cp "$src_file" "$dest_file"
      echo "Copied template to: $dest_file"
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
TECH_STACK_VAL="- Stack: General / To be defined later.
- Adhere to the existing coding style of any file you edit."

NON_INTERACTIVE=false

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
  
  # --- SECTION 1: Autonomy & Decisions ---
  echo "--- SECTION 1: Autonomy & Decisions ---"
  echo "1.1) Choose AI Autonomy Mode:"
  echo "  [1] Consultative / Ask-First (AI stops and asks if unsure) [Default]"
  echo "  [2] Autonomous / Proactive (AI decides and implements, explains later)"
  echo "  [3] Plan-First (AI writes a plan for approval first)"
  read -p "Select option [1-3]: " opt
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
  read -p "Select option [1-2]: " opt
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
  read -p "Select option [1-3]: " opt
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
  read -p "Select option [1-3]: " opt
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
  read -p "Select option [1-3]: " opt
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
  read -p "Select option [1-2]: " opt
  case "$opt" in
    2)
      SAFETY_POLICY_VAL="- **Critical Operations Policy:** You can perform cleanup actions (like removing obsolete prototype files or database tables) if it is directly required to complete the task."
      ;;
  esac
  echo ""

  # --- SECTION 2: Coding & Refactoring ---
  echo "--- SECTION 2: Coding & Refactoring ---"
  echo "2.1) Choose Refactoring Policy:"
  echo "  [1] Strict Scope (AI only touches what's requested) [Default]"
  echo "  [2] Boy Scout Rule (AI cleans up minor smells in edited files)"
  read -p "Select option [1-2]: " opt
  case "$opt" in
    2)
      REFACTORING_POLICY_VAL="- **Boy Scout Rule:** Proactively clean up minor code smells, formatting issues, or type safety gaps in files you are already modifying, as long as it does not expand the scope excessively."
      ;;
  esac
  echo ""

  # --- SECTION 3: Testing Strategy ---
  echo "--- SECTION 3: Testing Strategy ---"
  echo "3.1) Choose Testing Coverage Policy:"
  echo "  [1] Critical Path only (Write tests only for key logic/critical paths) [Default]"
  echo "  [2] None (Skip tests for maximum speed)"
  echo "  [3] Full Coverage (Task is complete only when fully covered and tests pass)"
  read -p "Select option [1-3]: " opt
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
  read -p "Select option [1-2]: " opt
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
  read -p "Select option [1-3]: " opt
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
  read -p "Select option [1-5]: " opt
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

