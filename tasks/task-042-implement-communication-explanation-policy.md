---
id: task-042
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

# Task-042: Implement Communication & Explanation Style Policy Configuration

**Description:**
1. Define default value and interactive prompt for "AI Communication & Explanation Style" in `create_minimal_structure.sh` and `create_minimal_structure.ps1`.
2. Detail the pros, cons, and consequences of each option (Concise & Technical vs. Detailed & Educational) in the wizard.
3. Recommend "Concise & Technical" as the default.
4. Add placeholder `__COMMUNICATION_POLICY__` in `file-templates/ai/rules/coding.md`.
5. Update scripts to replace the placeholder dynamically.
6. Verify and document.

## Verification Walkthrough
- Added `$CommunicationPolicyVal` and `COMMUNICATION_POLICY_VAL` defaults.
- Integrated Section 2.4 prompts in both `.sh` and `.ps1` scripts with comprehensive details on pros, cons, and consequences.
- Verified dynamic replacement of `__COMMUNICATION_POLICY__` placeholder.
