---
id: task-083
tags:
  - tasks
status: todo
priority: high
type: docs
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on:
  - task-063
  - task-082
---

# Task-083: Add `bugfix.md` and `release.md` Workflow Templates

## Source
Report section 6.7 (Improvement).

## Location
- `file-templates/ai/workflows/bugfix.md` (new file)
- `file-templates/ai/workflows/release.md` (new file)
- `docs/structure/ai-agents.md` -- update `ai/workflows/` section to mention these templates

## Description

The `ai/workflows/` directory contains only `new-feature.md`. Bugfix and release workflows are the two other most common recurring procedures in any software project. Their absence means AI agents default to their training data conventions instead of following project-defined procedures, leading to inconsistent outcomes.

## What to Do

### Create `file-templates/ai/workflows/bugfix.md`

```markdown
# Workflow: Bug Fix

Follow these steps sequentially.

## Diagnose

1. **Read the task:** Open the corresponding task file in `tasks/task-NNN-description.md`. Confirm the bug description, reproduction steps, and expected vs. actual behavior.

2. **Locate the defect:** Identify the failing code. Check `ai/context/modules.md` to understand which module is responsible.

3. **Check for existing tests:** Before writing code, check if a failing test already exists for this bug in `tests/`. If not, write a failing test first (this is the TDD approach for bug fixes).

## Fix

4. **Write a failing test (if not already present):** In `tests/`, add a test that reproduces the exact bug. Run it to confirm it fails.

5. **Apply the minimal fix:** Fix the root cause in `src/`. Follow `ai/rules/coding.md`. Apply only the minimal change required -- do not add new features or unrelated refactoring.

6. **Verify the fix:** Run the test from step 4. Confirm it now passes. Run the full test suite to confirm no regressions.

## Close

7. **Check file sizes:** Confirm no modified file exceeds 300 lines.

8. **Update `CHANGELOG.md`:** Add an entry under `[Unreleased]` in the `Fixed` section.

9. **Update the task file:** Set `status: done`. Append a `## Verification` section documenting: root cause, fix applied, test result, and affected files.

10. **Update `tasks.md` index** if required by the project convention.
```

### Create `file-templates/ai/workflows/release.md`

```markdown
# Workflow: Release

Follow these steps sequentially. All steps are required before creating a release tag.

## Pre-Release Checks

1. **Verify all planned tasks are done:** Check `tasks.md` and confirm all tasks planned for this release have `status: done` or `status: cancelled`.

2. **Run the full test suite:** Execute all tests and confirm zero failures.

3. **Run the lint and file size check:** Execute `./scripts/check-file-sizes.sh` and the project linter. Confirm zero violations.

4. **Check for secrets:** Confirm no API keys or secrets are present in the diff (`git diff main`).

## Update Documentation

5. **Update `CHANGELOG.md`:** Rename the `[Unreleased]` section to the new version number and date (e.g., `[1.0.0] - 2026-07-16`). Add a new empty `[Unreleased]` section above it.

6. **Update `MANIFEST.md`:** Confirm it reflects the current project state accurately.

7. **Update `README.md`:** If the release changes installation instructions or core behavior, update the README accordingly.

## Tag and Publish

8. **Create a git tag:** `git tag -a v1.0.0 -m "Release v1.0.0"` (replace version number).

9. **Push the tag:** `git push origin v1.0.0`.

10. **Create a GitHub Release:** Use the CHANGELOG section as the release notes body.
```

### Update `docs/structure/ai-agents.md`

In the `ai/workflows/` section, add template links for both new files:
```markdown
- **Template (bugfix.md):** [templates/ai/workflows/bugfix.md](../../templates/ai/workflows/bugfix.md)
- **Template (release.md):** [templates/ai/workflows/release.md](../../templates/ai/workflows/release.md)
```

## Verification

- `file-templates/ai/workflows/bugfix.md` exists with at least 8 steps covering diagnose, fix, and close phases.
- `file-templates/ai/workflows/release.md` exists with at least 8 steps covering pre-release, documentation, and publish phases.
- `docs/structure/ai-agents.md` contains template links for both new files.
