---
id: task-002
tags:
  - tasks
status: done
priority: medium
type: docs
owner: pjk
created: 2026-07-07
updated: 2026-07-07
depends_on: []
---

# Task-002: AGENTS.md Minimal Template Contradicts Its Own Scope Rule

**Location:** Lines 240-261

**Description:** The rule states `AGENTS.md` must contain four categories: (1) where docs are, (2) which rules apply, (3) which workflows to use, (4) **what not to do**. The Minimal Template below that rule includes only the first three and omits the fourth entirely.

**Justification:** The template is the concrete implementation reference. Omitting a required category contradicts the rule directly above it, leaving implementers uncertain what a compliant `AGENTS.md` looks like.
