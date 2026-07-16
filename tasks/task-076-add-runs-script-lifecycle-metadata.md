---
id: task-076
tags:
  - tasks
status: todo
priority: low
type: docs
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on:
  - task-063
---

# Task-076: Add Lifecycle Metadata Convention for `ai/runs/` Scripts

## Source
Report section 5.6 (Ambiguity).

## Location
- `docs/structure/ai-agents.md` -- `ai/runs/` section
- `templates/ai/runs/run-001-example-automation.sh` -- example template

## Description

`ai/runs/` stores numbered automation scripts (`run-NNN-description.sh`). Unlike tasks which have YAML frontmatter for status tracking, run scripts have no structured metadata. There is no way to determine if a script is:
- Still current vs. deprecated.
- Intended for one-time use vs. reuse.
- Safe to run again vs. idempotent.
- Last executed successfully and when.

## What to Do

### 1. Add a metadata comment convention to `docs/structure/ai-agents.md`

In the `ai/runs/` section, after the existing "Core Rules", add:

```markdown
### Script Header Convention

Every run script must begin with a metadata comment block immediately after the shebang line:

```bash
#!/usr/bin/env bash
# ---
# id: run-NNN
# description: [One sentence describing what this script does]
# created: YYYY-MM-DD
# last-run: YYYY-MM-DD
# reusable: true|false   # true = safe to run again; false = one-time-use, archive after use
# idempotent: true|false # true = running multiple times has the same effect as once
# author: [agent name or developer name]
# ---
```

**Lifecycle rules based on `reusable` field:**
- `reusable: true` -- Keep the script in `ai/runs/`. Update `last-run` date after each execution.
- `reusable: false` -- After successful execution, move the script to `archive/` or delete it. Do not leave one-time scripts accumulating in `ai/runs/`.
```

### 2. Update the example template `templates/ai/runs/run-001-example-automation.sh`

Add the metadata comment block at the top of the file following the convention above.

## Verification

- `docs/structure/ai-agents.md` contains the script header convention in the `ai/runs/` section.
- `templates/ai/runs/run-001-example-automation.sh` begins with the metadata comment block.
- The lifecycle rule for reusable vs. one-time scripts is documented.
