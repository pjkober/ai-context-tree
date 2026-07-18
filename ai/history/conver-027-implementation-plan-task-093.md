# Implementation Plan - Task 093

This plan covers task-093: completing the coverage gaps for SECURITY.md identified after task-091 created the root-level security policy file.

## Problem Statement

After task-091 created SECURITY.md at the project root, a review revealed four uncovered gaps:

1. docs/structure/root-files.md had no section documenting SECURITY.md.
2. No templates/SECURITY.md existed for projects adopting the standard.
3. create_minimal_structure.sh and .ps1 always silently generated ai/rules/security.md with no user choice about root-level SECURITY.md generation.
4. Bootstrap integration tests did not assert that SECURITY.md is generated.

Note: templates/ai/rules/security.md (AI agent rules template) already existed and was correct.
The gap was specifically the root-level SECURITY.md (GitHub vulnerability disclosure policy).

## Proposed Changes

### Documentation

#### [MODIFY] docs/structure/root-files.md
- Add SECURITY.md section before LICENSE with: role, rule, when-to-update guidance, and template link.

### Templates

#### [NEW] templates/SECURITY.md
- Root-level template with GitHub Advisory standard structure.
- Sections: Supported Versions, Reporting a Vulnerability, Security Best Practices, Scope.
- Type: one-time template (copied once at setup, removed in cleanup option 1).

### Bootstrap Scripts

#### [MODIFY] create_minimal_structure.sh
- Add GEN_SECURITY_MD=true default flag.
- Add wizard step 1.9: Yes [Default] / No (skip).
- Add conditional copy_template_file call.

#### [MODIFY] create_minimal_structure.ps1
- Add GenSecurityMd = true default flag.
- Add wizard step 1.9 (identical structure to bash).
- Add conditional Copy-TemplateFile call.

### Integration Tests

#### [MODIFY] scripts/test-bootstrap.sh
- Add SECURITY.md to REQUIRED files list.

#### [MODIFY] scripts/test-bootstrap.ps1
- Add SECURITY.md to Required files list.

## Design Decisions

- Wizard step is 1.9 (after existing 1.8 Context and Cost Control, before Section 2).
- Default is Yes (generate). Consistent with secure-defaults principle.
- Non-interactive mode generates SECURITY.md automatically.

## Verification Plan

- Run scripts/test-bootstrap.sh in non-interactive mode.
- Confirm SECURITY.md appears in the OK list.
- Confirm no placeholder tokens remain.
