---
id: task-069
tags:
  - tasks
status: todo
priority: medium
type: chore
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on: []
---

# Task-069: Clean Up `tmp/` Directory and Add `.gitkeep`

## Source
Report section 4.7 (MEDIUM).

## Location
- `tmp/test-delete.txt`
- `tmp/test-project/` (subdirectory)

## Description

The `tmp/` directory at the project root contains leftover test artifacts from development:
- `tmp/test-delete.txt` -- a test file with 5 bytes of content.
- `tmp/test-project/` -- a test project subdirectory.

These artifacts contradict `docs/structure/supporting.md`, which defines `tmp/` as: "A local scratchpad for automatically generated logs, temporary build artifacts, or AI tutoring cache files." They also contradict the rule that `tmp/` should contain only a `.gitkeep` file at the start of a project.

The presence of these files could confuse new users examining the project structure, who may assume these files are intentional examples or required content.

## What to Do

1. Delete all leftover artifacts in `tmp/`:
   ```bash
   rm -f tmp/test-delete.txt
   rm -rf tmp/test-project/
   ```
2. Confirm `.gitkeep` is present (or add it):
   ```bash
   ls -la tmp/
   # If .gitkeep is missing:
   touch tmp/.gitkeep
   ```
3. Verify `.gitignore` correctly excludes `tmp/*` but tracks the directory:
   ```
   # .gitignore should contain:
   tmp/*
   !tmp/.gitkeep
   ```
   If not, update `.gitignore` accordingly.
4. Update `tasks.md` index to reference this task.

## Verification

- `ls tmp/` shows only `.gitkeep`.
- `git status` shows no untracked/modified files in `tmp/` (except `.gitkeep` if newly added).
- `cat .gitignore | grep tmp` confirms `tmp/*` is excluded and `!tmp/.gitkeep` is tracked.
