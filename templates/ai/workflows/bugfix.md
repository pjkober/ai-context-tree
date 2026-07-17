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
