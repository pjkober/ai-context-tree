---
id: task-010
tags:
  - tasks
status: todo
priority: low
type: docs
owner: pjk
created: 2026-07-07
updated: 2026-07-07
depends_on: []
---

# Task-010: docs Code Snippet Rule May Unintentionally Cover ai-workflows

**Location:** Line 836 (`docs/` rule) vs. Lines 525-550 (`ai/workflows/` description)

**Description:** The `docs/` rule states: "Documentation must not contain code snippets longer than 5 lines." `ai/workflows/` also contains Markdown documentation files, and no explicit exemption is granted for workflows. Yet realistic workflow procedures frequently require multi-step code blocks exceeding 5 lines.

**Justification:** Without a stated scope, the 5-line rule technically applies to `ai/workflows/` too, making many realistic workflow files non-compliant. The document must clarify whether the restriction is scoped to `docs/` only or is a global rule — and if global, how workflows handle longer code blocks.
