---
id: task-019
tags:
  - tasks
status: done
priority: high
type: refactor
owner: Antigravity
created: 2026-07-07
updated: 2026-07-07
depends_on:
  - task-018
---

# Task-019: Update Initialization Scripts and Templates with ai/skills/

**Location:** `create_minimal_structure.sh`, `create_minimal_structure.ps1`, and `file-templates/`

**Description:**
1. Create a template folder `file-templates/ai/skills/` and put an example template `example-skill.md` inside it.
2. Update the shell script `create_minimal_structure.sh` to:
   - Create `ai/skills/` directory.
   - Copy `ai/skills/example-skill.md` from the template directory.
3. Update the PowerShell script `create_minimal_structure.ps1` to:
   - Create `ai/skills/` directory.
   - Copy `ai/skills/example-skill.md` from the template directory.
4. Update the structure snapshot in `README.md` to display `ai/skills/` in the minimal structure layout.

**Justification:**
Ensures that the `ai/skills/` directory is automatically bootstrapped when initializing new projects using our cross-platform scripts.
