---
id: task-035
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

# Task-035: Implement Architecture & Scope Policy in creative_minimal_structure Scripts

**Location:** `create_minimal_structure.sh`, `create_minimal_structure.ps1`, and `file-templates/ai/rules/security.md`

**Description:**
1. Update `file-templates/ai/rules/security.md` to add the `## Architecture & Scope Policy` section with the `__ARCHITECTURE_POLICY__` placeholder.
2. Update the interactive configuration wizards in both `create_minimal_structure.sh` and `create_minimal_structure.ps1` to:
   - Prompt the user with Section 1.3: Choose AI Architecture Policy:
     - `[1] Strict / Ask-First (AI cannot change patterns/directories/database without approval) [Default]`
     - `[2] Flexible (AI can propose and implement minor refactors, but document)`
     - `[3] Full Autonomy / Change Architecture (NOT RECOMMENDED) (AI can fully change architecture and patterns without asking)`
   - Set default value for non-interactive mode.
   - Replace the `__ARCHITECTURE_POLICY__` placeholder when generating `ai/rules/security.md`.

**Justification:**
Allows repository owners to define the boundaries of AI agent architectural changes upon bootstrapping.

## Verification Walkthrough

1. **Updated Templates:**
   - Modified `file-templates/ai/rules/security.md` to contain `## Architecture & Scope Policy` and `__ARCHITECTURE_POLICY__` placeholder.
2. **Updated Scripts:**
   - Added option `1.3` to the interactive prompt wizard of `create_minimal_structure.sh` and `create_minimal_structure.ps1`.
   - Set defaults for `$ArchitecturePolicyVal` and replaced `__ARCHITECTURE_POLICY__` placeholder during the templating expansion step in both Bash and PowerShell scripts.

