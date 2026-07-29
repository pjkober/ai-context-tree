---
id: task-044
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

# Task-044: Implement Task Management & Boundaries Policy Configuration

**Description:**
1. Define default value and interactive prompt for "Task Boundaries & Granularity" in `create_minimal_structure.sh` and `create_minimal_structure.ps1`.
2. Detail the pros, cons, and consequences of each option (Strict Boundaries & Micro-tasks vs. Flexible / Broad Scope) in the wizard.
3. Recommend "Strict Boundaries & Micro-tasks" as the default.
4. Add placeholder `__TASK_MANAGEMENT_POLICY__` in `templates/ai/rules/security.md`.
5. Update scripts to replace the placeholder dynamically.
6. Verify and document.

## Verification Walkthrough
- Added `$TaskManagementPolicyVal` and `TASK_MANAGEMENT_POLICY_VAL` defaults.
- Integrated Section 2.3 prompts in both `.sh` and `.ps1` scripts with comprehensive details on pros, cons, and consequences.
- Verified dynamic replacement of `__TASK_MANAGEMENT_POLICY__` placeholder.
