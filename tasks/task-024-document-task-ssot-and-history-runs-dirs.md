---
id: task-024
tags:
  - tasks
status: done
priority: high
type: docs
owner: Antigravity
created: 2026-07-07
updated: 2026-07-07
depends_on: []
---

# Task-024: Document Task Lifecycle (Walkthrough in File) and ai/history/, ai/runs/ Directories

**Location:** `docs/structure/root-files.md`, `docs/structure/ai-agents.md`, `docs/03-incremental-growth.md`, and `file-templates/ai/context/structure-map.md`

**Description:**
1. Update `docs/structure/root-files.md` (specifically under the `task.md & tasks/` section) to explicitly state that completing a task involves:
   - Setting the status to `done` in the YAML frontmatter.
   - Appending a `## Verification` or `## Walkthrough` section directly to the bottom of the task markdown file, serving as a permanent historical record of the execution.
2. Update `docs/structure/ai-agents.md` to document the two new directories:
   - `ai/history/` (Conversation Memory): Storing conversation logs or transcript summaries (`conver-NNN-description.md`) to capture the decision context of the agent.
   - `ai/runs/` (Reusable Scripts): Storing executable scripts and commands (`run-NNN-description.sh` / `.ps1`) written by agents that can be reused in the future.
3. Formulate the core rules for these directories in `docs/structure/ai-agents.md`:
   - **Nazewnictwo z opisem:** Files must be sequentially numbered and descriptively named (e.g. `run-001-migrate-users-db.sh`).
   - **Zasada czystości (No Secrets Rule):** Absolutely zero hardcoded credentials, API keys, or secrets; must load from environment variables (`.env`).
   - **Tylko przydatne skrypty:** Only store reusable automation scripts (e.g. migrations, tests, data generators), no throwaway CLI logs.
4. Update `file-templates/ai/context/structure-map.md` and `docs/03-incremental-growth.md` to list `ai/history/` and `ai/runs/` with their descriptions and snapshots.

**Justification:**
Establishes clear rules for the new reproducibility and memory directories, and enforces the "Task as SSOT" lifecycle rule so walkthroughs are saved in the project history.

## Verification

1. **Updated `docs/structure/root-files.md`:** Appended the "Completed Task Lifecycle Rule" to the `task.md & tasks/` section.
2. **Updated `docs/structure/ai-agents.md`:** Documented `ai/history/` and `ai/runs/` with the three core rules: descriptive naming, "No Secrets" rule, and storing only reusable scripts.
3. **Updated Snapshots & Map:** Included both directories in the minimal tree structure of `docs/03-incremental-growth.md` and added them to `file-templates/ai/context/structure-map.md`.

