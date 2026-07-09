---
id: task-037
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

# Task-037: Implement Git Autonomy Policy in creative_minimal_structure Scripts

**Location:** `create_minimal_structure.sh`, `create_minimal_structure.ps1`, and `file-templates/ai/rules/security.md`

**Description:**
1. Update `file-templates/ai/rules/security.md` to add `## Git & Version Control Autonomy` with `__GIT_POLICY__` placeholder.
2. Update the interactive configuration wizards in both `create_minimal_structure.sh` and `create_minimal_structure.ps1` to:
   - Prompt the user with Section 1.5: Choose Git Autonomy Mode:
     - `[1] None (AI only modifies files; human commits) [Default]`
     - `[2] Commit-First (AI commits changes on current branch using Conventional Commits)`
     - `[3] Branch-First (AI creates dedicated feature branch and commits there)`
   - Set default value for non-interactive mode.
   - Replace the `__GIT_POLICY__` placeholder when generating `ai/rules/security.md`.

**Justification:**
Defines Git/commit boundaries for AI agents operating on the project.

## Verification Walkthrough

1. **Updated Templates:**
   - Modified `file-templates/ai/rules/security.md` to contain `## Git & Version Control Autonomy` and `__GIT_POLICY__` placeholder.
2. **Updated Scripts:**
   - Added Option `1.5` to the interactive prompt wizard in both `create_minimal_structure.sh` and `create_minimal_structure.ps1`.
   - Replaced `__GIT_POLICY__` with the corresponding configuration values in both scripts.

