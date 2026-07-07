#!/usr/bin/env bash

# Script to create minimal project structure as defined in ai-context-tree
# ------------------------------------------------------------
set -e

# Determine the directory where this script lives – treat it as the project root
BASE_DIR="."
TEMPLATES_DIR="$BASE_DIR/file-templates"


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

# Check if templates directory is present
if [ ! -d "$TEMPLATES_DIR" ]; then
  echo "Error: 'file-templates/' directory not found at $TEMPLATES_DIR."
  echo "This script must be run inside the cloned repository context containing file-templates."
  exit 1
fi

# Default values for AI-First rules configuration
AUTONOMY_MODE_VAL="- **Consultative Mode:** If you don't know something, see multiple solutions, or encounter ambiguity, STOP and ask the user. Do not make assumptions."
DEPENDENCY_POLICY_VAL="- **Strict Dependency Policy:** Never add new libraries or dependencies without explicit user permission. Prefer standard/existing project tools."
REFACTORING_POLICY_VAL="- **Strict Scope:** Modify only lines and files directly related to the requested task. Do not clean up unrelated code or formatting."
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
  
  # 1. Autonomy Mode
  echo "1) Choose AI Autonomy Mode:"
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

  # 2. Refactoring Policy
  echo "2) Choose Refactoring Policy:"
  echo "  [1] Strict Scope (AI only touches what's requested) [Default]"
  echo "  [2] Boy Scout Rule (AI cleans up minor smells in edited files)"
  read -p "Select option [1-2]: " opt
  case "$opt" in
    2)
      REFACTORING_POLICY_VAL="- **Boy Scout Rule:** Proactively clean up minor code smells, formatting issues, or type safety gaps in files you are already modifying, as long as it does not expand the scope excessively."
      ;;
  esac
  echo ""

  # 3. Dependency Policy
  echo "3) Choose Dependency Policy:"
  echo "  [1] Strict / Ask-First (AI must ask before installing packages) [Default]"
  echo "  [2] Proactive (AI can install standard packages if needed)"
  read -p "Select option [1-2]: " opt
  case "$opt" in
    2)
      DEPENDENCY_POLICY_VAL="- **Proactive Dependency Policy:** You can install standard, widely-used packages if they are necessary for the implementation, but inform the user in the summary."
      ;;
  esac
  echo ""

  # 4. Tech Stack
  echo "4) Select Tech Stack / Framework:"
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

echo "Minimal project structure created successfully."
