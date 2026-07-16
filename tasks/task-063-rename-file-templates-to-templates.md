---
id: task-063
tags:
  - tasks
status: todo
priority: critical
type: refactor
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on: []
---

# Task-063: Rename `file-templates/` to `templates/`

## Source
Report section 4.1 (CRITICAL).

## Location
- Root directory: `file-templates/` (actual name on disk)
- All documentation references: `README.md`, `docs/06-initialization-guide.md`, `docs/structure/ai-agents.md`, `docs/structure/business-knowledge.md`, `docs/structure/implementation.md`, `docs/structure/root-files.md`, `docs/structure/supporting.md`, all template link targets.

## Description

The directory on disk is named `file-templates/` but every piece of documentation in the project refers to it as `templates/`. The `README.md` explicitly states:

> "The scripts require the `templates/` directory to run."

`task-061` was previously filed and marked `done` for this rename, but the rename was not executed -- the directory still exists as `file-templates/`. This is a direct, critical violation of the project's own naming and SSOT principles. Any new user who clones the repository and runs the bootstrap script will encounter an immediate failure.

## What to Do

1. Rename the directory on disk:
   ```bash
   mv file-templates templates
   ```
2. Search for all remaining references to `file-templates` across the entire repository:
   ```bash
   grep -r "file-templates" . --include="*.md" --include="*.sh" --include="*.ps1" -l
   ```
3. Update every occurrence found in step 2 to `templates`.
4. Verify the bootstrap scripts reference the correct directory name:
   ```bash
   grep "templates" create_minimal_structure.sh | head -20
   grep "templates" create_minimal_structure.ps1 | head -20
   ```
5. Run a syntax check on the scripts after changes:
   ```bash
   bash -n create_minimal_structure.sh
   ```
6. Update `MANIFEST.md` to reflect the renamed directory.
7. Update `tasks.md` index to reference this task.

## Verification

- `ls templates/` succeeds (directory exists with correct name).
- `grep -r "file-templates" . --include="*.md"` returns zero results.
- `bash -n create_minimal_structure.sh` exits with code 0.
