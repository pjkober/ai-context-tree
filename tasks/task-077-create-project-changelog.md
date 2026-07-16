---
id: task-077
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

# Task-077: Create Populated `CHANGELOG.md` for the Project

## Source
Report section 6.1 (Improvement).

## Location
- Root directory: `CHANGELOG.md` (does not currently exist at the project root -- only in `file-templates/`)

## Description

The `file-templates/CHANGELOG.md` template exists for target projects, but the `ai-context-tree` project itself does not have a `CHANGELOG.md` in its root. For an open-source standard that has gone through 62+ tracked tasks and multiple structural refactors, the absence of a changelog:
- Makes it impossible for adopters to know what changed between versions.
- Creates uncertainty about whether the project is actively maintained.
- Prevents consumers from doing a quick "what's new" scan before adopting a new version.

## What to Do

1. Create `CHANGELOG.md` at the project root.
2. Use [Keep a Changelog](https://keepachangelog.com) format with sections: `Added`, `Changed`, `Fixed`, `Removed`.
3. Reconstruct the main changelog entries from the task history in `tasks/`. Use task status `done` and `created` dates to group entries by approximate release period.

Suggested initial structure:

```markdown
# Changelog

All notable changes to this project will be documented in this file.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [Unreleased]

### Added
- 30 new tasks from project analysis report (task-063 through task-092).

---

## [0.5.0] - 2026-07-12

### Added
- AI IDE pointer files generation in bootstrap wizard (Section 5).
- Git initialization option in bootstrap wizard (Section 6).
- Multi-select tech stack configuration in wizard (task-059).
- `file-templates/` directory with one-time and reusable templates (task-012, task-058).
- Knowledge files: `Autonomy Mode.md`, `Boy Scout Rule.md`, `Context Management.md`, etc.

### Changed
- Bootstrap wizard expanded with autonomy, dependency, git, safety, and security policies.
- Renamed `file-templates/` to `templates/` in all documentation (task-061, pending execution).

### Fixed
- Removed Polish language from all files (task-055).
- Removed emoji from documentation (task-057).

---

## [0.4.0] - 2026-07-08

### Added
- Spec-Driven Development knowledge file and README reference (task-020, task-021).
- `ai/history/` and `ai/runs/` directories in minimal structure (task-024).
- Local skills documentation in structure guides (task-018).

### Changed
- Split SDD knowledge into separate files (task-022).
- Updated structure map template with `history/` and `runs/` (task-025).
```

4. Add `CHANGELOG.md` to `MANIFEST.md` (the project's own manifest).
5. Commit with a descriptive message: `docs: add project CHANGELOG.md`.

## Verification

- `CHANGELOG.md` exists at project root.
- File follows Keep a Changelog format.
- At least 3 past milestones are documented with grouped entries.
- `MANIFEST.md` includes `CHANGELOG.md`.
