# Workflow: New Feature

1. Read the requirements in `specs/<feature>/requirements.md`.
2. Check the associated contract in `contracts/`, if it exists.
3. Implement according to `ai/rules/coding.md`.
4. Add tests in `tests/`.
5. Update `CHANGELOG.md`.
6. Update `MANIFEST.md` if any new directories or key files were created during this task.
7. Verify file sizes: Run `./scripts/check-file-sizes.sh` and confirm no modified files exceed 300 lines. If a file exceeds the limit, split it following the single-responsibility principle before marking the task as done.
