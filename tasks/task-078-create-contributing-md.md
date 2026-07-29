---
id: task-078
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

# Task-078: Create `CONTRIBUTING.md`

## Source
Report section 6.2 (Improvement).

## Location
- Root directory: `CONTRIBUTING.md` (new file)

## Description

The `README.md` displays a "PRs Welcome" badge but the repository has no `CONTRIBUTING.md` file. Without it, potential contributors have no guidance on:
- How to report bugs or suggest improvements.
- How to structure a contribution (task-driven development).
- The English-only and no-emoji rules that apply to all contributions.
- How to run and test the bootstrap scripts locally.

This is a significant barrier to community adoption of the standard.

## What to Do

Create `CONTRIBUTING.md` at the project root with the following content structure:

```markdown
# Contributing to ai-context-tree

Thank you for your interest in contributing. This document explains the process for submitting improvements, bug fixes, and new features.

## Language Rule

All contributions (documentation, code comments, task descriptions, commit messages) must be written in English.
Emoji are not allowed anywhere in documentation or code.

## How to Report Issues

1. Check existing tasks in `tasks/` to confirm the issue is not already tracked.
2. Open a GitHub Issue with:
   - A clear title describing the problem.
   - The specific file and line number affected.
   - What the current behavior is and what the expected behavior should be.

## How to Contribute Changes

All changes are task-driven. Every pull request must be linked to a task.

### Step 1: Create a task file

Follow the convention in `tasks.md`:
- File: `tasks/task-NNN-short-description.md`
- YAML frontmatter with: id, status, priority, type, owner, created, updated, depends_on.
- Body: description, location of change, what to do, verification steps.

### Step 2: Implement the change

- Follow all rules in the project's own `templates/ai/rules/coding.md`.
- Keep files under 300 lines (see Core Principle 3).
- Do not duplicate information that already exists elsewhere (SSOT rule).

### Step 3: Verify

- Run `bash -n create_minimal_structure.sh` if the script was modified.
- Check for broken Markdown links in any modified `.md` files.
- Confirm no emoji were added: `grep -rP "[\x{1F300}-\x{1FFFF}]" .`
- Append a verification walkthrough to the bottom of your task file.

### Step 4: Submit a pull request

- Reference the task ID in the PR title (e.g., `task-078: add CONTRIBUTING.md`).
- Mark the task as `review` in its frontmatter.

## Project Structure

See `README.md` and `AGENTS.md` for an overview of the repository structure.
```

Add `CONTRIBUTING.md` to the project's `MANIFEST.md`.

## Verification

- `CONTRIBUTING.md` exists at the project root.
- File covers: language rule, issue reporting, task creation, change process, and verification steps.
- `MANIFEST.md` includes `CONTRIBUTING.md`.
- The `README.md` badge area can optionally be updated to link to `CONTRIBUTING.md`.

## Walkthrough

- Created `CONTRIBUTING.md` at the project root defining developer guidelines, language rule (English-only, no emojis), issue reporting, and the task-driven contribution flow.
- Added `CONTRIBUTING.md` to `MANIFEST.md`.
- Updated the "PRs Welcome" badge in `README.md` to point to `CONTRIBUTING.md`.
- Verified that all modified sections contain no emojis.
