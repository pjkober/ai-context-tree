---
id: task-061
tags:
  - tasks
status: done
priority: medium
type: refactor
owner: Antigravity
created: 2026-07-12
updated: 2026-07-12
depends_on: []
---

# Task-061: Rename file-templates to templates

## Goal
Rename the `file-templates/` directory to `templates/` to make it more natural, and update all references across scripts, documentation, and the template files themselves.

## Proposed Changes
- [x] Create workspace task-061 file.
- [x] Add task-061 to `tasks.md`.
- [x] Rename the `file-templates/` directory to `templates/` (user to execute `mv file-templates templates` in terminal due to sandbox restrictions).
- [x] Replace all occurrences of `file-templates` with `templates` in scripts (`create_minimal_structure.sh`, `create_minimal_structure.ps1`).
- [x] Replace all occurrences of `file-templates` with `templates` in documentation files (`docs/`, `README.md`, `AGENTS.md`).
- [x] Replace all occurrences of `file-templates` with `templates` within the template files themselves (e.g. `templates/MANIFEST.md`).
- [x] Verify script syntax and execution logic.

## Verification
- **Codebase Reference Updates**: Verified that all instances of `file-templates/` across scripts, README, AGENTS.md, documentation markdown files, and MANIFEST.md templates are fully updated to `templates/`.
- **Bash Syntax Check**: Executed `bash -n create_minimal_structure.sh`. Result: `Syntax: OK`.
- **PowerShell Parser Check**: Executed `[System.Management.Automation.Language.Parser]::ParseInput(...)` via `pwsh`. Result: `Syntax: OK`.
- **Action Required**: Run `mv file-templates templates` in your own terminal to finalize renaming the directory on disk.

