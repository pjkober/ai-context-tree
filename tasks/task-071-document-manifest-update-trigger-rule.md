---
id: task-071
tags:
  - tasks
status: todo
priority: medium
type: docs
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on: []
---

# Task-071: Document MANIFEST.md Update Trigger Rule

## Source
Report section 5.1 (Ambiguity).

## Location
- `file-templates/AGENTS.md` -- add the trigger rule
- `docs/structure/root-files.md` -- expand the MANIFEST.md section
- `file-templates/ai/workflows/new-feature.md` -- add MANIFEST update step

## Description

The `MANIFEST.md` is defined as a "living index" that must be kept up to date as files and directories are added. However, there is no documented trigger rule specifying when exactly it must be updated. The consequence is that AI agents and developers update it inconsistently: some update it after every file, others only at the end of a task, and others forget entirely, leading to stale manifests.

## What to Do

### 1. Add trigger rule to `file-templates/AGENTS.md`

In the "Follow (Rules & Guidelines)" section, add a new bullet:
```markdown
└── MANIFEST.md Update Rule: Update MANIFEST.md whenever a directory or key file is
    added, renamed, or removed. Do this as part of the same commit as the file change.
```

### 2. Expand the MANIFEST.md section in `docs/structure/root-files.md`

Under the existing MANIFEST.md description, add a "When to update" subsection:
```markdown
### When to Update

Update `MANIFEST.md` immediately (in the same commit) whenever:
- A new top-level directory is created.
- A key file (e.g., `AGENTS.md`, `README.md`, contract files, major docs) is added, renamed, or deleted.
- A directory is deleted or archived.

Do NOT update `MANIFEST.md` for:
- Files inside `tmp/` (excluded from git).
- Temporary or scratch files.
- Files added during testing that will be reverted.
```

### 3. Add a step to `file-templates/ai/workflows/new-feature.md`

After the step for adding tests, add:
```markdown
6. Update `MANIFEST.md` if any new directories or key files were created during this task.
```

## Verification

- `file-templates/AGENTS.md` contains an explicit MANIFEST update rule.
- `docs/structure/root-files.md` contains a "When to Update" subsection for MANIFEST.md with trigger conditions.
- `file-templates/ai/workflows/new-feature.md` contains a MANIFEST update step.
