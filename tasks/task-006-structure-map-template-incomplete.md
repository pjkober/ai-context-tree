---
id: task-006
tags:
  - tasks
status: todo
priority: high
type: docs
owner: jan
created: 2026-07-07
updated: 2026-07-07
depends_on:
  - task-011
---

# Task-006: structure-map.md Minimal Template Is Incomplete

**Location:** Lines 482-494 (template) vs. Lines 155-224 (FULL snapshot)

**Description:** The template for `ai/context/structure-map.md` lists only 8 directories. The FULL snapshot contains many additional top-level directories absent from the template: `research/`, `tools/`, `scripts/`, `config/`, `infrastructure/`, `assets/`, `examples/`, `tmp/`, `docs/`, `src/`, `tests/`.

**Justification:** The document declares `structure-map.md` to be "a full, flat catalog of all directories" and "the only place the AI checks before creating a new top-level directory." Missing directories mean the AI cannot find their official names — directly contradicting the file's stated purpose.
