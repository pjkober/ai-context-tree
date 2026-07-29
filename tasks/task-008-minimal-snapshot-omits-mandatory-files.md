---
id: task-008
tags:
  - tasks
status: done
priority: high
type: docs
owner: pjk
created: 2026-07-07
updated: 2026-07-07
depends_on: []
---

# Task-008: MINIMAL Snapshot Omits Files Described as Mandatory Elsewhere

**Location:** Lines 133-147 (MINIMAL snapshot) vs. Lines 267-416 (Root Directory Files)

**Description:** The MINIMAL snapshot lists only `AGENTS.md`, `README.md`, `ai/`, `docs/`, `src/`, `tests/`. Yet: `MANIFEST.md` is the essential "project's index" for AI navigation; `ai/context/structure-map.md` must be consulted before creating any directory; `.gitignore` is called mandatory (the `tmp/` exclusion "must" be present). None appear in the MINIMAL snapshot.

**Justification:** Files described as essential elsewhere must appear in the MINIMAL template, or each must explicitly state the condition under which it becomes required. The current gap leads to inconsistently configured projects.
