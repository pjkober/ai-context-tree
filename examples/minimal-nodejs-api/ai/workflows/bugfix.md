# Workflow: Bug Fix

Follow these steps sequentially:

1. **Reproduction:** Read the bug report in the task file. Create a failing test in `tests/` reproducing the bug.
2. **Investigation:** Trace the issue to its module and function using `ai/context/modules.md`.
3. **Fix:** Apply the minimal required fix in `src/` according to `ai/rules/coding.md`.
4. **Validation:** Confirm the test now passes and that the full test suite remains green.
5. **Close:** Update `CHANGELOG.md` under `Fixed` and append verification details to the bottom of the task file.
