---
id: task-045
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

# Task-045: Implement Context & Cost Control Policy Configuration

**Description:**
1. Define default value and interactive prompt for "Context & Cost Control Policy" in `create_minimal_structure.sh` and `create_minimal_structure.ps1`.
2. Detail the pros, cons, and consequences of each option (Strict Token Diet vs. Context Rich) in the wizard.
3. Recommend "Strict Token Diet" as the default.
4. Add placeholder `__CONTEXT_MANAGEMENT_POLICY__` in `file-templates/ai/rules/security.md`.
5. Update scripts to replace the placeholder dynamically.
6. Verify and document.

## Verification Walkthrough
- Added `$ContextManagementPolicyVal` and `CONTEXT_MANAGEMENT_POLICY_VAL` defaults.
- Integrated Section 1.8 prompts in both `.sh` and `.ps1` scripts with comprehensive details on pros, cons, and consequences.
- Verified dynamic replacement of `__CONTEXT_MANAGEMENT_POLICY__` placeholder.
