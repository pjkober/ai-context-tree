---
id: task-059
tags:
  - tasks
status: done
priority: medium
type: feature
owner: Antigravity
created: 2026-07-12
updated: 2026-07-12
depends_on: []
---

# Task-059: Multi-Select Tech Stack and CLI Input Validation

## Goal
Improve the bootstrap scripts (`create_minimal_structure.sh` and `create_minimal_structure.ps1`) to:
1. Redesign Section 4 (Tech Stack) to allow multi-selection of frameworks/languages with "Decide later / General" as the default/first choice, and a "Custom Selection" option.
2. Add popular tech stacks: Rust, Java / Spring Boot, C# / .NET, and PHP / Laravel.
3. Inform the user that they can modify or extend tech stack conventions later in `ai/rules/coding.md`.
4. Warn the user to choose only active technologies to prevent cluttering the AI's memory and wasting tokens, suggesting incremental additions as the project grows.
5. Ensure robust input validation for all menu/numeric choices to reject invalid inputs like `q` and prompt again.

## Proposed Changes
- [x] Add validation helper functions in `create_minimal_structure.sh` and `create_minimal_structure.ps1`.
- [x] Redesign Section 4.1 in both scripts to use validation and support multi-selection.
- [x] Implement prompts for the 8 tech stacks (Node.js/TS, Python, Go, React/Next.js, Rust, Java/Spring Boot, C#/.NET, PHP/Laravel).
- [x] Add on-screen warnings and documentation tips about memory clutter and incremental additions.
- [x] Replace all options prompts in both scripts with the new validation helpers.
- [x] Update `docs/06-initialization-guide.md` to document the new Section 4 wizard layout.
- [x] Update `tasks.md` with the new task index.

## Verification
- **Bash Syntax Check**: Executed `bash -n create_minimal_structure.sh`. Result: `Syntax: OK` (Exit code: 0, no output, syntax correct).
- **PowerShell Parser Check**: Executed PowerShell parser API `[System.Management.Automation.Language.Parser]::ParseInput(...)` via `pwsh`. Result: `Syntax: OK` (Brace mismatch resolved, file parses successfully).

