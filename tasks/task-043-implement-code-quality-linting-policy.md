---
id: task-043
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

# Task-043: Implement Code Quality & Linting Policy Configuration

**Description:**
1. Define default value and interactive prompt for "Code Quality & Linting Policy" in `create_minimal_structure.sh` and `create_minimal_structure.ps1`.
2. Detail the pros, cons, and consequences of each option (Automatic Formatter & Linter vs. Minimalist) in the wizard.
3. Recommend "Automatic Formatter & Linter" as the default.
4. Add placeholder `__LINTING_POLICY__` in `file-templates/ai/rules/coding.md`.
5. Update scripts to replace the placeholder dynamically.
6. Verify and document.

## Verification Walkthrough
- Added `$LintingPolicyVal` and `LINTING_POLICY_VAL` defaults.
- Integrated Section 2.2 prompts in both `.sh` and `.ps1` scripts with comprehensive details on pros, cons, and consequences.
- Verified dynamic replacement of `__LINTING_POLICY__` placeholder.
