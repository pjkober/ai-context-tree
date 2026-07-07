#!/usr/bin/env bash

# Script to create minimal project structure as defined in ai-context-tree
# ------------------------------------------------------------
set -e

# Determine the directory where this script lives – treat it as the project root
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
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
copy_template_file "ai/rules/coding.md"
copy_template_file "ai/workflows/new-feature.md"
copy_template_file "ai/skills/example-skill.md"
copy_template_file "ai/history/conver-001-example-transcript.md"
copy_template_file "ai/runs/run-001-example-automation.sh"

echo "Minimal project structure created successfully."


