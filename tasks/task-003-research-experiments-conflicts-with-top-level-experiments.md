---
id: task-003
status: todo
priority: high
type: docs
owner: pjk
created: 2026-07-07
updated: 2026-07-07
depends_on:
  - task-011
---

# Task-003: research-experiments Conflicts with Top-Level experiments

**Location:** Lines 189-213 (FULL snapshot) and Lines 993-1036 (detailed sections)

**Description:** The FULL structure snapshot includes **both** a top-level `experiments/` (with `rag/`, `llm/`, `prototypes/`, `benchmarks/`) **and** a `research/experiments/` nested inside `research/`. No distinction between them is documented anywhere.

**Justification:** Two directories with identical names at different hierarchy levels, without stated distinction, violates the single-official-name and one-category-per-directory rules. The difference must be explicitly documented, or one must be renamed or removed.
