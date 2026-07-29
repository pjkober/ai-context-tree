---
id: task-097
tags:
  - tasks
status: done
priority: high
type: refactor
owner: Antigravity
created: 2026-07-29
updated: 2026-07-29
depends_on: []
---

# Task-097: Rename `ai/` Directory to `.agents/`

**Description:** Rename the `ai/` directory structure to `.agents/` across the entire codebase, including project root, template directories, bootstrap scripts, documentation, and test assertions.

**Goal:** Ensure consistent `.agents/` directory structure usage throughout all standard templates, scripts, and documentation.

## Verification

- Renamed root `/ai` directory to `/.agents` and `/templates/ai` to `/templates/.agents` via `git mv`.
- Updated bootstrap scripts (`create_minimal_structure.sh`, `create_minimal_structure.ps1`) to target `.agents/`.
- Updated test scripts (`scripts/test-bootstrap.sh`, `scripts/test-bootstrap.ps1`) and verified test execution.
- Updated documentation files across `docs/`, `knowledge/`, `SECURITY.md`, `AGENTS.md`, `README.md`, `MANIFEST.md`, `CONTRIBUTING.md`, and `CHANGELOG.md`.
- Updated all template files in `templates/` and `templates/.agents/`.
- Updated `examples/` project structures and documentation.
- Verified test suite execution (`bash scripts/test-bootstrap.sh` passed cleanly).
