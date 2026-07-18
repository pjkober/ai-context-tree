---
id: task-081
tags:
  - tasks
status: done
priority: low
type: refactor
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on: []
---

# Task-081: Add Specific Tags to Knowledge Files

## Source
Report section 6.5 (Improvement).

## Location
- All 16 files in `knowledge/`

## Description

Every knowledge file currently uses `tags: [knowledge]` as its only tag. This is equivalent to having no tags at all -- every file has the same tag, so the tag system provides zero filtering value. An AI agent or developer trying to find "all testing-related knowledge" cannot use tags to retrieve them.

## What to Do

For each file in `knowledge/`, update the YAML frontmatter to add 1-3 specific tags in addition to the base `knowledge` tag.

Suggested tag assignments:

| File | Current Tags | Suggested Tags to Add |
|---|---|---|
| `API Contracts.md` | `[knowledge]` | `contracts`, `specs`, `ssot` |
| `Autonomy Mode.md` | `[knowledge]` | `autonomy`, `agent-behavior`, `configuration` |
| `Boy Scout Rule.md` | `[knowledge]` | `refactoring`, `coding-standards`, `agent-behavior` |
| `Context Management.md` | `[knowledge]` | `context`, `llm`, `performance` |
| `Critical Path.md` | `[knowledge]` | `testing`, `coverage`, `strategy` |
| `Definition of Done.md` | `[knowledge]` | `workflow`, `task-lifecycle`, `quality` |
| `Full Coverage.md` | `[knowledge]` | `testing`, `coverage`, `strategy` |
| `Integration Tests.md` | `[knowledge]` | `testing`, `integration`, `strategy` |
| `Living Specifications.md` | `[knowledge]` | `specs`, `sdd`, `documentation` |
| `Spec-Driven Development.md` | `[knowledge]` | `sdd`, `methodology`, `specs` |
| `Test-Driven Development.md` | `[knowledge]` | `tdd`, `testing`, `methodology` |
| `Unit Tests.md` | `[knowledge]` | `testing`, `unit-tests`, `strategy` |
| `Vibe Coding.md` | `[knowledge]` | `methodology`, `agent-behavior`, `anti-pattern` |
| `git.md` | none (no frontmatter) | Add frontmatter: `git`, `version-control` |
| `gitignore.md` | `[knowledge]` | `git`, `configuration`, `version-control` |
| `licenses.md` | `[knowledge]` | `licensing`, `legal`, `dependencies` |

## What to Do Step by Step

1. Open each file listed above.
2. In the YAML frontmatter block (between `---` delimiters), find the `tags:` list.
3. Add the suggested tags. Example change for `Autonomy Mode.md`:
   ```yaml
   # Before:
   tags:
     - knowledge

   # After:
   tags:
     - knowledge
     - autonomy
     - agent-behavior
     - configuration
   ```
4. For `git.md` which lacks frontmatter, add a complete frontmatter block at the top.

## Verification

- Every file in `knowledge/` has at least 2 tags (the base `knowledge` tag plus at least 1 specific tag).
- `grep -l "tags:" knowledge/*.md | wc -l` equals 16 (all files have a tags field).
- Tags use lowercase, hyphen-separated naming consistently.

## Walkthrough

- Modified the frontmatter of all 16 files in the `knowledge/` directory to add 1-3 specific, lowercase, hyphen-separated tags.
- Created and formatted the frontmatter block for `git.md`.
- Verified that all 16 files are successfully found by `grep -l "tags:"` and that they contain no emojis.
