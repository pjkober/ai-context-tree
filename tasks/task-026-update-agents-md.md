---
id: task-026
tags:
  - tasks
status: done
priority: high
type: refactor
owner: Antigravity
created: 2026-07-07
updated: 2026-07-07
depends_on: []
---

# Task-026: Update Root AGENTS.md and Its Template File

**Location:** `AGENTS.md` and `templates/AGENTS.md`

**Description:**
Update the main entry point `AGENTS.md` (and its corresponding template file in `templates/AGENTS.md`) to integrate the new directories and rules:
- Point the agent to read `tasks.md` for active tasks and lifecycle rules.
- Add the `Completed Task Lifecycle Rule` under rules to follow.
- Reference the new `ai/skills/` directory for custom skills.
- Reference `ai/history/` and `ai/runs/` for conversation and script logging (with a strong reminder: "No Secrets!").
- Keep the layout clean, tree-like, and highly readable.

**Justification:**
Ensures that any AI agent starting up in this repository is immediately aware of all directories (including skills, history, and runs) and the new task lifecycle rule upon loading `AGENTS.md`.

## Verification

1. **Updated Root File:** Modified `AGENTS.md` at the project root to include the new guidelines, directories, and completed task rule.
2. **Updated Template File:** Modified `templates/AGENTS.md` to match the root file exactly.
3. **Verified Structure:** Checked that the layout remains a clean tree pointer hierarchy.

