---
id: task-088
tags:
  - tasks
status: done
priority: high
type: docs
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on:
  - task-063
  - task-075
---

# Task-088: Create Multi-Agent Coordination Guidelines

## Source
Report section 7.5 (Missing element).

## Location
- `docs/multi-agent-coordination.md` (new file)
- `README.md` -- add a link to the new guide
- `templates/AGENTS.md` -- add a reference

## Description

`ai-context-tree` claims "multi-agent collaboration" as a primary use case in the README and philosophy document. However, no document in the project explains how multiple AI agents actually coordinate in practice. Teams scaling to parallel multi-agent workflows have no guidance on:
- How to prevent two agents from owning the same task.
- How to handle concurrent file edits and merge conflicts.
- When to run agents sequentially vs. in parallel.
- How to merge and review outputs from different agents.

This is the highest-value documentation gap for teams at scale.

## What to Do

### Create `docs/multi-agent-coordination.md`

```markdown
# Multi-Agent Coordination Guide

This guide explains how to coordinate multiple AI agents working in parallel on the same repository.

---

## Core Principle: Task Ownership

Each task in `tasks/` can be owned by at most one agent at a time. The task's frontmatter field `owner` and `status: in_progress` mark it as claimed.

**Rule:** Before starting a task, an agent must set `status: in_progress` and write its identifier in the `owner` field. If the agent finds the task already `in_progress`, it must not start it.

---

## Parallel Work Patterns

### Pattern 1: Independent Tasks (Fully Parallel)

Two agents can work in parallel safely when:
- Their tasks modify different files.
- Neither task depends on the other (`depends_on: []`).

Process:
1. Human assigns tasks to agents (sets `status: in_progress`, different `owner` values).
2. Agents work in separate git branches: `agent-a/task-NNN` and `agent-b/task-NNN`.
3. Human reviews both outputs and merges to `main` sequentially.
4. **MANIFEST.md** is updated by the human during merge to avoid conflicts.

### Pattern 2: Sequential Tasks (Dependencies)

Use `depends_on` in task frontmatter to declare dependencies. Never start a task whose dependencies are not yet `status: done`.

Process:
1. Agent A completes task-063 (renames a directory).
2. Agent A sets task-063 to `status: done`.
3. Agent B reads task-064, sees `depends_on: [task-063]`, confirms task-063 is done, then starts.

### Pattern 3: Review Agent

Assign one agent as a "reviewer" whose sole responsibility is:
1. Reading output from implementation agents.
2. Applying rules from `ai/rules/coding.md` and `ai/rules/security.md`.
3. Flagging issues as new tasks.

---

## Files That Cause Merge Conflicts

These files are high-risk for concurrent modification. Coordinate carefully:

| File | Conflict Risk | Mitigation |
|---|---|---|
| `MANIFEST.md` | High | Update only during merge by the human or integration agent. |
| `tasks.md` | High | Each agent adds its task entry at the end; rebase to combine. |
| `CHANGELOG.md` | Medium | Each agent adds to `[Unreleased]`; combine during merge. |
| `ai/context/structure-map.md` | Medium | Architectural file -- require human approval before changes. |

---

## Handoff Between Agents

When one agent completes a task that feeds into another agent's work:
1. Mark the task `status: done` and write the verification walkthrough.
2. Create a brief summary file in `ai/history/` describing what was built and any important decisions made.
3. The next agent reads this history file before starting its dependent task.

---

## Recommended Tooling

- Use separate git branches per agent per task.
- Use `git rebase` (not `git merge`) when integrating agent branches to keep linear history.
- Use the `tasks/` directory as the coordination layer -- never use external chat or spreadsheets.
```

### Update `README.md`

In the Table of Contents, add:
```markdown
- [Multi-Agent Coordination Guide](docs/multi-agent-coordination.md)
```

## Verification

- `docs/multi-agent-coordination.md` exists.
- File covers: task ownership protocol, parallel patterns, sequential dependencies, high-risk files, and agent handoff.
- `README.md` contains a link to the guide.

## Walkthrough

- Created `docs/multi-agent-coordination.md` specifying rules for task claiming, parallel/sequential task configurations, merge conflict prevention, and agent handoffs.
- Linked `docs/multi-agent-coordination.md` in `README.md` and referenced it in `templates/AGENTS.md`.
- Confirmed no emojis are present in any of the created or modified files.
