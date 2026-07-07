# Tasks

This file is the index and convention reference for the `tasks/` directory.
Individual tasks are stored as separate Markdown files in `tasks/`.

---

## Convention

### File Location

All task files are placed in the `tasks/` directory at the project root.
Do not place task content directly in this file.

### File Naming

```
task-NNN-short-description.md
```

- `NNN` — zero-padded sequential number (e.g., `001`, `012`)
- `short-description` — lowercase, words separated by hyphens, no special characters
- No backticks, colons, slashes, or other characters invalid in file names

**Examples:**

```
task-001-duplicate-knowledge-section.md
task-002-agents-md-template-contradicts-scope-rule.md
task-011-document-contradicts-no-preset-levels-principle.md
```

### Frontmatter Schema

Every task file must begin with a YAML frontmatter block:

```yaml
---
id: task-NNN
tags:
  - tasks
status: todo          # todo | in_progress | blocked | review | done | cancelled
priority: medium      # low | medium | high | critical
type: docs            # docs | bug | feature | refactor | chore
owner: <name>
created: YYYY-MM-DD
updated: YYYY-MM-DD
depends_on:
  - task-NNN          # list of blocking task IDs, or [] if none
---
```

### Status Values

| Status | Meaning |
|---|---|
| `todo` | Task is waiting to be started |
| `in_progress` | Currently being worked on (WIP) |
| `blocked` | Blocked by another task or external problem |
| `review` | Complete, awaiting review |
| `done` | Completed and accepted |
| `cancelled` | Deliberately cancelled, will not be implemented |

### Priority Values

| Priority | Meaning |
|---|---|
| `low` | Nice to have, no urgency |
| `medium` | Should be done in the current cycle |
| `high` | Important, do soon |
| `critical` | Must be resolved immediately — blocks other work |

### Type Values

| Type | Meaning |
|---|---|
| `docs` | Documentation change |
| `bug` | Something is broken or incorrect |
| `feature` | New functionality |
| `refactor` | Code or structure improvement without behavior change |
| `chore` | Maintenance, tooling, or housekeeping |

---
