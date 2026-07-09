---
id: task-036
tags:
  - tasks
status: done
priority: medium
type: feature
owner: Antigravity
created: 2026-07-09
updated: 2026-07-09
depends_on: []
---

# Task-036: Implement Dependency License Policy and Licenses Knowledge Document

**Location:** `create_minimal_structure.sh`, `create_minimal_structure.ps1`, `file-templates/ai/rules/security.md`, and `knowledge/`

**Description:**
1. Create a dedicated knowledge base file `knowledge/licenses.md` detailing the differences between software licenses (Permissive like MIT/Apache, weak-copyleft like LGPL/MPL, and strong-copyleft like GPL/AGPL).
2. Update `file-templates/ai/rules/security.md` to add `## License Policy` with `__LICENSE_POLICY__` placeholder.
3. Update both `create_minimal_structure.sh` and `create_minimal_structure.ps1` to:
   - Prompt the user with Section 1.4: Choose Dependency License Policy:
     - `[1] Permissive Only (MIT, Apache 2.0, BSD, Public Domain) [Default]`
     - `[2] Copyleft Tolerant (Permissive + LGPL, MPL)`
     - `[3] Any License (No license restrictions)`
   - Set default value for non-interactive mode.
   - Replace the `__LICENSE_POLICY__` placeholder when generating `ai/rules/security.md`.

**Justification:**
Provides the AI agent with clear licensing requirements for packages it intends to add to the repository.

## Verification Walkthrough

1. **Created Licenses Reference:**
   - Written [knowledge/licenses.md](file:///Users/pjk/code/ai-context-tree/knowledge/licenses.md) detailing software license classifications (Permissive, Weak-Copyleft, Strong-Copyleft) to help developers and AI agents decide.
2. **Updated Rule Files and Scripts:**
   - Updated `file-templates/ai/rules/security.md` to introduce the `__LICENSE_POLICY__` placeholder.
   - Added Option `1.4` to the interactive prompt wizard in `create_minimal_structure.sh` and `create_minimal_structure.ps1`.
   - Replaced `__LICENSE_POLICY__` with the corresponding configuration values in both scripts.

