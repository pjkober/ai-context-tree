---
id: task-005
status: todo
priority: medium
type: docs
owner: pjk
created: 2026-07-07
updated: 2026-07-07
depends_on: []
---

# Task-005: TODO.md Rules Contain an Internal Contradiction

**Location:** Lines 363-384 and Line 124

**Description:** The rules state `TODO.md` must not contain technical tasks like "fix a bug" (those go to the ticketing system or `plans/`). Yet line 124 instructs the AI to report a missing directory "as a task in `TODO.md`" — which is itself a technical task. The Minimal Template provides only generic placeholders with no examples of permitted task types.

**Justification:** The rule is both underspecified and internally contradicted. A concrete distinction with examples of allowed vs. forbidden task types is needed to make the rule actionable.
