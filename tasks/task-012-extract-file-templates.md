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

# Task-012: Extract File Templates to file-templates/

**Location:** `file-templates/` directory

**Description:**
Extract all inline code block templates from the main document `Universal Project Structure for AI-First Development & Multi-Agent Collaboration.md` into actual, usable files under `file-templates/`. The files must mirror the recommended directory structure of an AI-First project:

- `file-templates/AGENTS.md`
- `file-templates/MANIFEST.md`
- `file-templates/README.md`
- `file-templates/CHANGELOG.md`
- `file-templates/ROADMAP.md`
- `file-templates/.gitignore`
- `file-templates/tasks/task-001-example.md`
- `file-templates/ai/context/project.md`
- `file-templates/ai/context/structure-map.md`
- `file-templates/ai/rules/coding.md`
- `file-templates/ai/workflows/new-feature.md`
- `file-templates/ai/prompts/create-api.md`
- `file-templates/specs/requirements.md`
- `file-templates/specs/acceptance.md`
- `file-templates/knowledge/terminology.md`
- `file-templates/checklists/release.md`
- `file-templates/decisions/001-example-adr.md`
- `file-templates/contracts/openapi.yaml`
- `file-templates/docs/architecture/module-architecture.md`
- `file-templates/config/tsconfig-base.json`
- `file-templates/scripts/script-header.sh`
- `file-templates/plans/plan-template.md`
- `file-templates/prototypes/prototype-template.md`

**Justification:**
Exposing these templates as real files in `file-templates/` makes them immediately usable (e.g., they can be copied to a new project) and removes large code block clutter from the documentation.
