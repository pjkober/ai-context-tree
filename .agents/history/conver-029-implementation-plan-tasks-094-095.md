# Implementation Plan - Tasks 094 and 095

This plan covers two housekeeping and release tasks identified after task-093.

## Task 094 - Fix CHANGELOG, MANIFEST, and ai/history Numbering

Three gaps identified after reviewing the project state:

1. CHANGELOG.md [Unreleased] had only a stub entry. Missing: task-091, 092, 093, history files.
2. MANIFEST.md was missing ai/ and examples/ directories, and the MANIFEST.md self-entry.
3. ai/history/ conver-024 gap: already resolved by git rename to conver-028 in commit a6e7f19. No action needed.

### Proposed Changes for Task 094

- CHANGELOG.md [MODIFY]: full [Unreleased] section with all changes.
- MANIFEST.md [MODIFY]: add ai/, examples/, MANIFEST.md, fix VERSION alignment.
- tasks/task-094 [NEW]: task file.
- tasks.md [MODIFY]: add task-094 and task-095 entries.

## Task 095 - Release v1.0.0

Consolidate all work from tasks 063-094 into the first stable release.

### Scope of v1.0.0

- Complete template set (ai/rules, ai/workflows, ai/prompts, ai/templates, supporting dirs).
- Bootstrap wizard with 9 sections and all policy options.
- Bootstrap integration tests (sh and ps1).
- SECURITY.md policy and templates.
- Real-world example project.
- CI/CD pipeline.
- CONTRIBUTING.md, CHANGELOG.md, semantic versioning.
- Multi-agent coordination guide.
- Full ai/history/ documentation (conver-001 through conver-028).

### Proposed Changes for Task 095

- CHANGELOG.md [MODIFY]: promote [Unreleased] to [1.0.0] - 2026-07-17, add [0.6.0] block.
- VERSION [MODIFY]: 0.6.0 -> 1.0.0.
- git tag v1.0.0.
- tasks/task-095 [NEW]: task file.

## Verification Plan

- Confirm VERSION reads 1.0.0.
- Confirm git tag v1.0.0 exists.
- Confirm CHANGELOG.md has no items left in [Unreleased].
- Confirm MANIFEST.md lists all top-level directories.
