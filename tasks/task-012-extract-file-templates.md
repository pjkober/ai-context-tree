---
id: task-012
tags:
  - tasks
status: done
priority: high
type: docs
owner: Antigravity
created: 2026-07-07
updated: 2026-07-07
depends_on: []
---

# Task-012: Extract File Templates to templates/

**Location:** `templates/` directory

**Description:**
Extract all inline code block templates from the main document `Universal Project Structure for AI-First Development & Multi-Agent Collaboration.md` into actual, usable files under `templates/`. The files must mirror the recommended directory structure of an AI-First project:

- `templates/AGENTS.md`
- `templates/MANIFEST.md`
- `templates/README.md`
- `templates/CHANGELOG.md`
- `templates/ROADMAP.md`
- `templates/.gitignore`
- `templates/tasks/task-001-example.md`
- `templates/ai/context/project.md`
- `templates/ai/context/structure-map.md`
- `templates/ai/rules/coding.md`
- `templates/ai/workflows/new-feature.md`
- `templates/ai/prompts/create-api.md`
- `templates/specs/requirements.md`
- `templates/specs/acceptance.md`
- `templates/knowledge/terminology.md`
- `templates/checklists/release.md`
- `templates/decisions/001-example-adr.md`
- `templates/contracts/openapi.yaml`
- `templates/docs/architecture/module-architecture.md`
- `templates/config/tsconfig-base.json`
- `templates/scripts/script-header.sh`
- `templates/plans/plan-template.md`
- `templates/prototypes/prototype-template.md`

**Justification:**
Exposing these templates as real files in `templates/` makes them immediately usable (e.g., they can be copied to a new project) and removes large code block clutter from the documentation.
