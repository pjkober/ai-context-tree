---
id: task-038
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

# Task-038: Implement Safety & Destructive Actions Policy in creative_minimal_structure Scripts

**Location:** `create_minimal_structure.sh`, `create_minimal_structure.ps1`, and `file-templates/ai/rules/security.md`

**Description:**
1. Update `file-templates/ai/rules/security.md` to add `## Safety & Destructive Actions Policy` with `__SAFETY_POLICY__` placeholder.
2. Update the interactive configuration wizards in both `create_minimal_structure.sh` and `create_minimal_structure.ps1` to:
   - Prompt the user with Section 1.6: Choose Critical Operations / Safety Policy:
     - `[1] Strict Protection (AI forbidden from running destructive commands like DROP/DELETE/force push without asking) [Default]`
     - `[2] Collaborative / Loose (AI can run destructive cleanup if task calls for it)`
   - Set default value for non-interactive mode.
   - Replace the `__SAFETY_POLICY__` placeholder when generating `ai/rules/security.md`.

**Justification:**
Protects repository data and branch history from unintended AI destructions.

## Verification Walkthrough

1. **Updated Templates:**
   - Modified `file-templates/ai/rules/security.md` to contain `## Safety & Destructive Actions Policy` and `__SAFETY_POLICY__` placeholder.
2. **Updated Scripts:**
   - Added Option `1.6` to the interactive prompt wizard in both `create_minimal_structure.sh` and `create_minimal_structure.ps1`.
   - Replaced `__SAFETY_POLICY__` with the corresponding configuration values in both scripts.

