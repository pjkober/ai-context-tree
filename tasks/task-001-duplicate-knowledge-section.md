---
id: task-001
tags:
  - tasks
status: todo
priority: high
type: docs
owner: pjk
created: 2026-07-07
updated: 2026-07-07
depends_on: []
---

# Task-001: Duplicate knowledge Section

**Location:** Lines 672-706 and Lines 707-723

**Description:** The `knowledge/` directory is described **twice** under two consecutive headings. The first instance provides subdirectory explanations and a Minimal Template; the second repeats the directory listing with slightly different wording.

**Justification:** Violates the **Single Source of Truth (SSOT)** principle (Principle 1). Two separate definitions create ambiguity about which is authoritative. One section must be removed or the two merged into one.
