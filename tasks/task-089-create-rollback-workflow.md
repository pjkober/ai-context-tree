---
id: task-089
tags:
  - tasks
status: done
priority: medium
type: docs
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on:
  - task-063
  - task-083
---

# Task-089: Create `rollback.md` Workflow Template

## Source
Report section 7.6 (Missing element).

## Location
- `templates/ai/workflows/rollback.md` (new file)
- `docs/structure/ai-agents.md` -- add template link in `ai/workflows/` section

## Description

There is no guidance on what to do when an AI agent makes an irreversible or damaging mistake: accidentally deletes a required file, breaks an API contract, introduces a regression, or overwrites important content. Rollback and recovery is a standard workflow for teams using autonomous agents but is entirely absent from the project.

This workflow is especially critical for teams using Autonomy Mode (full autonomy), where agent mistakes may not be caught until after multiple subsequent changes have been made.

## What to Do

### Create `templates/ai/workflows/rollback.md`

```markdown
# Workflow: Rollback and Recovery

Use this workflow when an AI agent has made a change that needs to be fully or partially reverted.

---

## Step 1: Assess the Damage

Before taking any action, determine the scope of the problem:

1. Run `git log --oneline -10` to see the last 10 commits.
2. Run `git status` to see uncommitted changes.
3. Run `git diff HEAD` to see exactly what changed in the last operation.
4. Identify: Is this an uncommitted change, a committed-but-not-pushed change, or a pushed change?

---

## Step 2: Choose the Recovery Strategy

| Situation | Strategy |
|---|---|
| Changes are uncommitted (working directory only) | `git checkout -- [file]` or `git restore [file]` |
| Changes are committed but not pushed | `git reset HEAD~1 --soft` (keeps files) or `git reset HEAD~1 --hard` (discards files) |
| Changes are pushed but no one has pulled | `git revert [commit-hash]` (creates a new revert commit) |
| Changes are pushed and others have pulled | Create a new fix task; do NOT force-push or amend history |

---

## Step 3: Restore Specific Files

To restore a specific file to its state before a specific commit:
```bash
git show [commit-hash]:[path/to/file] > [path/to/file]
```

To restore all files to the last known good state:
```bash
git restore .
```

---

## Step 4: Verify the Restoration

After rolling back:
1. Run the test suite: `[project test command]`
2. Run `git diff HEAD` to confirm the working directory is clean.
3. Confirm the specific file that was corrupted is back to its correct state.

---

## Step 5: Prevent Recurrence

1. Create a new task in `tasks/` describing what went wrong and what the correct behavior should be.
2. Add a note to `ai/lessons/` explaining the root cause of the agent mistake.
3. If the mistake was caused by an ambiguous rule, update `ai/rules/coding.md` to prevent it in future.
4. If the mistake was caused by a missing specification, add the missing spec to `specs/` before retrying.

---

## Emergency Contacts / Key Commands

```bash
# Undo the last commit (keep changes staged):
git reset HEAD~1 --soft

# Undo the last commit (discard changes completely):
git reset HEAD~1 --hard

# Restore a single file from the last commit:
git restore [file]

# Restore a single file from a specific commit:
git checkout [commit-hash] -- [file]

# See what changed in the last commit:
git show HEAD

# Create a revert commit (safe for shared branches):
git revert HEAD
```
```

### Update `docs/structure/ai-agents.md`

In the `ai/workflows/` section, add:
```markdown
- **Template (rollback.md):** [templates/ai/workflows/rollback.md](../../templates/ai/workflows/rollback.md)
```

## Verification

- `templates/ai/workflows/rollback.md` exists.
- File covers: damage assessment, recovery strategy table, file-level restore, verification, and recurrence prevention.
- `docs/structure/ai-agents.md` contains a template link for `rollback.md`.
- A developer can execute a complete rollback using only this document and `git` commands.

## Walkthrough

- Created `templates/ai/workflows/rollback.md` covering damage assessment, Git recovery tables, restoring files, verification, and post-rollback recurrence prevention.
- Updated `docs/structure/ai-agents.md` to list and link the rollback workflow.
- Confirmed no emojis are present in any of the created or modified files.
