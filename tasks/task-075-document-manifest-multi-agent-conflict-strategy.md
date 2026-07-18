---
id: task-075
tags:
  - tasks
status: done
priority: medium
type: docs
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on: []
---

# Task-075: Document MANIFEST.md Conflict Resolution for Multi-Agent Scenarios

## Source
Report section 5.5 (Ambiguity).

## Location
- `docs/structure/root-files.md` -- MANIFEST.md section

## Description

Multi-agent collaboration is listed as a primary use case of `ai-context-tree`. However, no document explains what happens when two AI agents modify `MANIFEST.md` concurrently. In a parallel multi-agent workflow, this file is the most likely source of merge conflicts since both agents would add their newly created directories or files to the same living index.

## What to Do

### Update `docs/structure/root-files.md`

In the MANIFEST.md section, add a "Multi-Agent Conflict Strategy" subsection:

```markdown
### Multi-Agent Conflict Strategy

When multiple AI agents work in parallel on different tasks:

1. **Atomic updates:** Each agent must update `MANIFEST.md` in the same commit as the file creation it documents. Never defer MANIFEST updates to a separate commit.

2. **Rebase preferred over merge:** When integrating a branch that modified `MANIFEST.md`, always rebase (`git rebase main`) rather than merge. This preserves a linear history and makes MANIFEST conflicts easier to resolve.

3. **Conflict resolution rule:** If two agents create conflicting MANIFEST entries:
   - Both entries are correct -- they simply need to be combined.
   - Keep both new lines from both versions.
   - Sort the combined list alphabetically by directory name.
   - Do not delete any entry from either version.

4. **Agent coordination tip:** If a project uses a task queue, assign MANIFEST ownership to a single "integration agent" whose sole responsibility is merging outputs and updating MANIFEST after each parallel batch of work.
```

## Verification

- `docs/structure/root-files.md` contains a "Multi-Agent Conflict Strategy" subsection under the MANIFEST.md section.
- The subsection covers: atomic update timing, rebase over merge preference, conflict resolution rule, and optional agent coordination tip.

## Walkthrough

- Modified `docs/structure/root-files.md` by inserting a "Multi-Agent Conflict Strategy" subsection under the `MANIFEST.md` section.
- Verified that all paths and links in the modified section are correct and follow style guidelines.
