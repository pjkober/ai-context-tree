---
id: task-025
tags:
  - tasks
status: done
priority: high
type: refactor
owner: Antigravity
created: 2026-07-07
updated: 2026-07-07
depends_on:
  - task-024
---

# Task-025: Update Templates and Scripts with ai/history/ and ai/runs/

**Location:** `file-templates/`, `create_minimal_structure.sh`, `create_minimal_structure.ps1`, and `README.md`

**Description:**
1. Create placeholder/template directories and files in `file-templates/`:
   - `file-templates/ai/history/conver-001-example-transcript.md`
   - `file-templates/ai/runs/run-001-example-automation.sh`
2. Update the minimal structure bootstrap script `create_minimal_structure.sh` to:
   - Create directories: `ai/skills`, `ai/history`, and `ai/runs`.
   - Copy templates: `ai/skills/example-skill.md`, `ai/history/conver-001-example-transcript.md`, and `ai/runs/run-001-example-automation.sh`.
3. Update the PowerShell bootstrap script `create_minimal_structure.ps1` to do the same directory creation and template copying.
4. Update `README.md` minimal and full snapshots to display the new directories.

**Justification:**
Ensures all projects initialized with the standard have `ai/skills/`, `ai/history/`, and `ai/runs/` set up natively out-of-the-box.

## Verification

1. **Created Template Files:** Added `file-templates/ai/history/conver-001-example-transcript.md` and `file-templates/ai/runs/run-001-example-automation.sh`.
2. **Refactored Scripts:** Updated `create_minimal_structure.sh` (Bash) and `create_minimal_structure.ps1` (PowerShell) to create the new directories and copy the newly added templates.
3. **Updated README:** Displayed `ai/history/` and `ai/runs/` in the minimal and full structure trees.

