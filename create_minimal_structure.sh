#!/usr/bin/env bash

# Script to create minimal project structure as defined in Uniwersalna struktura projektu dla AI-First Development.md
# ------------------------------------------------------------
# Creates the following directory tree (relative to the script location):
# project/
# ├── AGENTS.md
# ├── README.md
# ├── .gitignore
# ├── MANIFEST.md
# ├── ai/
# │   ├── context/
# │   └── rules/
# ├── docs/
# ├── src/
# └── tests/
# ------------------------------------------------------------

set -e

# Determine the directory where this script lives – treat it as the project root
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

# Helper to create a file with given content if it does not exist
create_file_if_not_exists() {
  local file="$1"
  local content="$2"
  if [ ! -f "$file" ]; then
    echo -e "$content" > "$file"
    echo "Created file: $file"
  else
    echo "File already exists: $file"
  fi
}

# Create minimal directories
mkdir_if_not_exists "$BASE_DIR/ai/context"
mkdir_if_not_exists "$BASE_DIR/ai/rules"
mkdir_if_not_exists "$BASE_DIR/docs"
mkdir_if_not_exists "$BASE_DIR/src"
mkdir_if_not_exists "$BASE_DIR/tests"

# Minimal placeholder files
create_file_if_not_exists "$BASE_DIR/AGENTS.md" "# AGENTS.md\n\nRead first:\n├── ai/context/project.md\n├── ai/context/structure-map.md\n├── ai/context/architecture.md\n\nFollow:\n├── ai/rules/coding.md\n\nUse workflows:\n├── ai/workflows/new-feature.md"

create_file_if_not_exists "$BASE_DIR/README.md" "# Project Name\n\nOne‑sentence description of the project.\n\n## Installation\n...\n\n## Usage\n...\n\n## Structure\nSee [MANIFEST.md](MANIFEST.md).\n\n## Documentation\nSee [docs/](docs/) and [AGENTS.md](AGENTS.md) (for AI agents)."

create_file_if_not_exists "$BASE_DIR/.gitignore" "tmp/\n.cursor-tutor\nnode_modules/\n.dist/\nbuild/\n*.log\n.env"

# Optional MANIFEST listing the created items
create_file_if_not_exists "$BASE_DIR/MANIFEST.md" "├── [ai/context/](ai/context/)\n├── [ai/rules/](ai/rules/)\n├── [docs/](docs/)\n├── [src/](src/)\n├── [tests/](tests/)\n├── AGENTS.md\n├── README.md\n├── .gitignore"

echo "Minimal project structure created successfully."
