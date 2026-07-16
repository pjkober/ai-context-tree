---
id: task-066
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

# Task-066: Remove Remaining Emoji from Navigation Breadcrumbs in `docs/`

## Source
Report section 4.4 (MEDIUM).

## Location
Navigation breadcrumbs in:
- `docs/01-philosophy.md` (lines 1 and 38)
- `docs/02-core-principles.md` (lines 1 and 49)
- `docs/03-incremental-growth.md` (lines 1 and 61)
- `docs/04-terminology-management.md` (lines 1 and 31)
- `docs/05-ai-integration.md` (lines 1 and 131-132)
- `docs/06-initialization-guide.md` (lines 1, 11, 19, 88, 110 -- section headings AND breadcrumbs)
- `docs/structure/ai-agents.md` (lines 1 and 115)
- `docs/structure/business-knowledge.md` (lines 1 and 72)
- `docs/structure/implementation.md` (lines 1 and 63)
- `docs/structure/supporting.md` (lines 1 and 73)

## Description

Rule 2 in `AGENTS.md` explicitly states: "Never use emojis anywhere in the documentation, rules, or codebase." Despite task `task-057` being filed and marked `done`, emoji characters remain throughout the navigation breadcrumbs and section headings in `docs/`. This is an active violation of the project's own rules.

Examples of current breadcrumbs (with emoji):
- `[Next: Core Principles ->]` contains wrench emoji before "Core Principles"
- `[Next: Incremental Growth ->]` contains seedling emoji
- Section headings in `docs/06-initialization-guide.md` use warning and rocket emoji

## What to Do

1. Find all remaining emoji in `docs/`:
   ```bash
   grep -rP "[\x{1F300}-\x{1FFFF}]|[\x{2600}-\x{26FF}]|[\x{2700}-\x{27BF}]" docs/ --include="*.md"
   ```
2. For each breadcrumb link, replace the emoji with a plain text arrow or remove it entirely. Examples:
   - `[Next: 🛠️ Core Principles →]` becomes `[Next: Core Principles ->]`
   - `[← Previous: 📖 Philosophy]` becomes `[Previous: Philosophy]`
   - `## ⚠️ Prerequisites & Dependencies` becomes `## Prerequisites and Dependencies`
   - `## 🚀 How to Setup` becomes `## How to Setup`
3. Check the `docs/structure/` subdirectory as well.
4. After replacing, re-run the emoji search to confirm zero results in `docs/`.
5. Update `tasks.md` index to reference this task.

## Verification

```bash
grep -rP "[\x{1F300}-\x{1FFFF}]|[\x{2600}-\x{26FF}]|[\x{2700}-\x{27BF}]" docs/ --include="*.md"
```
Must return zero results.
