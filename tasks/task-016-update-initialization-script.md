---
id: task-016
tags:
  - tasks
status: done
priority: medium
type: refactor
owner: Antigravity
created: 2026-07-07
updated: 2026-07-07
depends_on:
  - task-012
---

# Task-016: Update Minimal Structure Initialization Script

**Location:** `create_minimal_structure.sh`

**Description:**
Refactor the shell script `create_minimal_structure.sh` so that it copies files directly from `templates/` instead of using hardcoded inline echo strings.

Specifically:
- Check if `templates/` directory exists.
- Instead of:
  `create_file_if_not_exists "$BASE_DIR/AGENTS.md" "..."`
  Use:
  `copy_template_file "AGENTS.md"`
  where `copy_template_file` handles checking and copying the file from `templates/` to the target location.
- Keep the script portable and ensure it outputs helpful errors if a template is missing.

**Justification:**
Decouples script logic from template content, making it easier to maintain templates in one place (`templates/`) rather than modifying the shell script whenever a template changes.
