---
id: task-067
tags:
  - tasks
status: todo
priority: medium
type: bug
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on: []
---

# Task-067: Fix Broken Obsidian Wiki-Link in `knowledge/gitignore.md`

## Source
Report section 4.5 (MEDIUM).

## Location
- `knowledge/gitignore.md` line 15

## Description

Line 15 of `knowledge/gitignore.md` contains the text:

```
[git.md|Git]
```

This is Obsidian wiki-link syntax. It is not valid standard Markdown. In every standard Markdown renderer -- GitHub, VS Code preview, browser-based viewers, and AI agent parsers -- this string renders as the literal text `[git.md|Git]` rather than a hyperlink. The link is broken in the project's primary rendering environments.

## What to Do

1. Open `knowledge/gitignore.md`.
2. Locate line 15 (current content likely reads: `This document defines the project's policy for [git.md|Git] version control...`).
3. Replace the Obsidian wiki-link with standard Markdown syntax:
   - From: `[git.md|Git]`
   - To: `[Git](git.md)`
4. Verify the full sentence still reads correctly in context.
5. Update `tasks.md` index to reference this task.

## Verification

- Open `knowledge/gitignore.md` in a standard Markdown renderer (GitHub or VS Code preview).
- Confirm line 15 renders the word "Git" as a clickable hyperlink pointing to `git.md`.
- `grep "\[git.md|Git\]" knowledge/gitignore.md` returns zero results.
