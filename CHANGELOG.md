# Changelog

All notable changes to this project will be documented in this file.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [Unreleased]

---

## [1.0.0] - 2026-07-17

### Added
- `SECURITY.md` at project root — GitHub Advisory standard vulnerability disclosure policy (task-091).
- 30 new task files (task-063 through task-092) derived from the comprehensive project analysis report (task-092).
- `templates/SECURITY.md` — root-level SECURITY.md template for adopting projects (task-093).
- Bootstrap wizard step 1.9: opt-in/out generation of `SECURITY.md` in new projects (task-093).
- `SECURITY.md` section in `docs/structure/root-files.md` (task-093).
- `SECURITY.md` to REQUIRED files list in bootstrap integration tests (task-093).
- Missing `ai/history/` session files: conver-025 through conver-028 (task-094).
- `ai/` and `examples/` directories added to `MANIFEST.md` (task-094).
- Real-world example project `examples/minimal-nodejs-api/` (task-079).
- CI/CD GitHub Actions lint pipeline (task-080).
- Semantic versioning standard and `VERSION` file (task-085).
- Pre-commit hook guidance in `knowledge/git.md` (task-086).
- Team onboarding template `templates/docs/onboarding.md` (task-087).
- Multi-agent coordination guide `docs/multi-agent-coordination.md` (task-088).
- `rollback.md` workflow template (task-089).
- Bootstrap integration test scripts `scripts/test-bootstrap.sh` and `.ps1` (task-090).

### Changed
- `tasks.md` updated with Completed Task Lifecycle Rule section and full task index (task-092).
- `MANIFEST.md` expanded to include all top-level directories and root files (task-094).

### Fixed
- `CHANGELOG.md` missing release entries filled in (task-094).

---

## [0.6.0] - 2026-07-16

### Added
- `bugfix.md` and `release.md` workflow templates (task-083).
- `ai/prompts/` templates: `create-api.md`, `review.md`, `debug.md` (task-084).
- `ai/templates/service/typescript.md` code scaffolding template (task-084).
- `CONTRIBUTING.md` with contribution guidelines and PR badge (task-078).
- Populated `CHANGELOG.md` for the project (task-077).
- `ai/runs/` lifecycle metadata convention (task-076).
- MANIFEST.md multi-agent conflict resolution strategy (task-075).
- File size enforcement mechanism in `docs/structure/` (task-074).
- Clear boundary definition between `plans/` and `specs/` (task-073).

### Changed
- `new-feature.md` workflow template expanded with pre/post steps (task-082).
- Knowledge files in `knowledge/` tagged with specific metadata (task-081).
- `ai/lessons/` clarified as distinct from `ai/history/` (task-072).

---

## [0.5.0] - 2026-07-12

### Added
- AI IDE pointer files generation in bootstrap wizard (Section 5).
- Git initialization option in bootstrap wizard (Section 6).
- Multi-select tech stack configuration in wizard (task-059).
- `templates/` directory with one-time and reusable templates (task-012, task-058).
- Knowledge files: `Autonomy Mode.md`, `Boy Scout Rule.md`, `Context Management.md`, etc.

### Changed
- Bootstrap wizard expanded with autonomy, dependency, git, safety, and security policies.
- Renamed `templates/` to `templates/` in all documentation (task-061).

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
