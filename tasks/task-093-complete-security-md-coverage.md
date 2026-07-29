---
id: task-093
tags:
  - tasks
status: done
priority: medium
type: docs
owner: agent
created: 2026-07-17
updated: 2026-07-17
depends_on:
  - task-091
---

# task-093: Complete SECURITY.md Coverage in Docs, Templates, and Create Scripts

## Goal

Ensure the SECURITY.md file (created in task-091) is fully covered by:
1. Documentation in `docs/structure/root-files.md`.
2. A reusable template in `templates/SECURITY.md`.
3. An opt-in wizard step in both bootstrap scripts.
4. Integration test assertions.

## Problem

After task-091 created `SECURITY.md` at the project root, the following gaps remained:
- `docs/structure/root-files.md` had no SECURITY.md section.
- No `templates/SECURITY.md` existed for projects adopting the standard.
- `create_minimal_structure.sh` and `.ps1` always silently generated `ai/rules/security.md` with no user choice about root-level SECURITY.md.
- Bootstrap integration tests did not assert that SECURITY.md is generated.

## Changes Made

- `templates/SECURITY.md` [NEW] — root-level template with GitHub Advisory standard structure.
- `docs/structure/root-files.md` [MODIFIED] — added SECURITY.md section with role, rules, and template link.
- `create_minimal_structure.sh` [MODIFIED] — added `GEN_SECURITY_MD=true` flag and wizard step 1.9.
- `create_minimal_structure.ps1` [MODIFIED] — added `$GenSecurityMd = $true` flag and wizard step 1.9.
- `scripts/test-bootstrap.sh` [MODIFIED] — added SECURITY.md to REQUIRED files list.
- `scripts/test-bootstrap.ps1` [MODIFIED] — added SECURITY.md to Required files list.

## Verification

Bootstrap integration test output:

```
=== Bootstrap Integration Test ===
[3/4] Checking required files and directories...
      OK:      AGENTS.md
      OK:      MANIFEST.md
      OK:      SECURITY.md
      OK:      VERSION
      OK:      ai/context/project.md
      OK:      ai/context/structure-map.md
      OK:      ai/rules/coding.md
      OK:      ai/rules/security.md
      OK:      ai/rules/testing.md
      OK:      ai/workflows/new-feature.md
      OK:      tasks.md
      OK:      tmp/.gitkeep
[4/4] Checking for leftover __PLACEHOLDER__ tokens...
      OK: No placeholder tokens found.

=== Results ===
PASSED: All checks passed.
```
