---
id: task-007
status: todo
priority: medium
type: docs
owner: pjk
created: 2026-07-07
updated: 2026-07-07
depends_on: []
---

# Task-007: Principle 5 States an Incomplete Rule Qualified 1000 Lines Later

**Location:** Line 105 (Principle 5) vs. Lines 1106-1109 (Integration with AI Clients)

**Description:** Principle 5 states: "AI client configuration files should contain at most 2-3 lines." The Integration section much later adds: "the 2-3 lines rule applies to the main rules file inside that directory — the directory itself is not subject to the line limit."

**Justification:** A reader encountering Principle 5 would incorrectly apply the rule to entire tool directories (`.cursor/`, `.roo/`). The qualification must be moved to or cross-referenced from Principle 5 so the rule is unambiguous at the point it is first stated.
