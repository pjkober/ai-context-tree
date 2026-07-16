---
id: task-014
tags:
  - tasks
status: done
priority: high
type: docs
owner: Antigravity
created: 2026-07-07
updated: 2026-07-07
depends_on:
  - task-013
---

# Task-014: Create Docs Structure Files

**Location:** `docs/structure/` directory

**Description:**
Create dedicated documentation files explaining the directory structure and specific directory rules, organized under a sub-folder `docs/structure/`:

- `docs/structure/root-files.md` (Detailed description of root files: `AGENTS.md`, `MANIFEST.md`, `README.md`, `CHANGELOG.md`, `ROADMAP.md`, `task.md` & `tasks/`, `LICENSE`, `.gitignore`, `.github/`)
- `docs/structure/ai-agents.md` (Detailed description of the `ai/` folder, including `context/` with `structure-map.md`, `rules/`, `workflows/`, `prompts/`, `templates/`, and `memory/`)
- `docs/structure/business-knowledge.md` (Detailed description of business/knowledge directories: `specs/`, `knowledge/`, `checklists/`, `decisions/` [ADRs], `contracts/`, `docs/`)
- `docs/structure/implementation.md` (Detailed description of implementation directories: `src/`, `tests/`, `config/`, `scripts/`, `infrastructure/`, `tools/`)
- `docs/structure/supporting.md` (Detailed description of supporting directories: `examples/`, `plans/`, `prototypes/`, `research/`, `archive/`, `assets/`, `tmp/`)

Each file must explain:
1. What the directory/file is.
2. The rules/prohibitions associated with it.
3. Link directly to its template in `templates/`.

**Justification:**
Consolidates the directory-level documentation into small, logically grouped files in a sub-folder to avoid cluttering the parent `docs/` folder, while retaining high LLM utility and human searchability.
