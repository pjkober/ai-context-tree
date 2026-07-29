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
