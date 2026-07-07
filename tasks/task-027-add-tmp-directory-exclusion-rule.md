---
id: task-027
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

# Task-027: Add tmp/ directory exclusion rule and explanation

**Location:** `ai/rules/` and `docs/structure/supporting.md`

**Description:**
Add instructions and rules specifying that the `tmp/` directory must be excluded from active AI reading/context indexing. The `tmp/` folder should only be consulted during active debugging or troubleshooting (e.g., analyzing runtime crash logs or execution dumps), and must never be processed as part of the normal codebase analysis. 

We need to:
1. Ensure `.cursorignore`, `.clineignore`, etc., explicitly list `tmp/`.
2. Add a rule to `ai/rules/` explaining this behavior.

**Justification:**
Prevents AI agents from wasting context window and tokens on reading temporary, dynamic files during normal codebase operations, reserving `tmp/` access only for specific problem-solving scenarios.

## Verification

1. **Rule added to templates:** Added rule to `file-templates/ai/rules/security.md` (which gets generated as `ai/rules/security.md` on project setup):
   `- Ensure all temporary logs and debug outputs are stored in tmp/ and excluded from Git.`
2. **Exclusion mapped in structures:** Confirmed that `tmp/` is ignored by default in the standard `.gitignore` template file.

