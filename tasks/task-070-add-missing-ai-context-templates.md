---
id: task-070
tags:
  - tasks
status: done
priority: low
type: docs
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on:
  - task-063
---

# Task-070: Add Missing `ai/context/` Companion Templates

## Source
Report section 4.8 (LOW).

## Location
- `templates/ai/context/` (after rename from task-063)

## Description

`docs/structure/ai-agents.md` explicitly lists the following expected files in `ai/context/`:
- `project.md` -- exists, template available.
- `structure-map.md` -- exists, template available.
- `stack.md` -- referenced in docs, **no template exists**.
- `modules.md` -- referenced in docs, **no template exists**.
- `glossary.md` -- referenced in docs, **no template exists**.

A developer following the documentation expects to find templates for all listed files. Without these templates, they must create the files from scratch with no guidance on expected format or content.

## What to Do

### Create `templates/ai/context/stack.md`

```markdown
# Tech Stack

## Language & Runtime
- Language: [e.g. TypeScript, Python, Go]
- Runtime / Version: [e.g. Node.js 20+, Python 3.11+]

## Frameworks & Libraries
- [Framework name and version] -- [brief role, e.g. "HTTP server"]
- [Framework name and version] -- [brief role]

## Infrastructure & Tooling
- Database: [e.g. PostgreSQL 16]
- Cache: [e.g. Redis 7]
- CI/CD: [e.g. GitHub Actions]
- Containerization: [e.g. Docker + Compose]

## Related
- [ai/rules/coding.md](../rules/coding.md)
- [decisions/](../../decisions/)
```

### Create `templates/ai/context/modules.md`

```markdown
# Module Map

A high-level overview of the main logical modules and their responsibilities.

| Module | Directory | Responsibility |
|---|---|---|
| [ModuleName] | `src/[path]` | [One sentence description] |
| [ModuleName] | `src/[path]` | [One sentence description] |

## Module Dependency Diagram

[Optional: add a Mermaid diagram here showing inter-module dependencies]

## Related
- [architecture.md](../../docs/architecture.md)
- [contracts/](../../contracts/)
```

### Create `templates/ai/context/glossary.md`

```markdown
# Technical Glossary

This file contains technical terms used in this codebase. One sentence per term.
Business domain terms belong in `knowledge/terminology/`.

| Term | Definition |
|---|---|
| [Term] | [One sentence definition. Link to business concept if applicable.] |

## Related
- [knowledge/terminology/](../../knowledge/terminology/)
- [decisions/](../../decisions/)
```

### Update `docs/structure/ai-agents.md`

Add template links for `stack.md`, `modules.md`, and `glossary.md` under the `ai/context/` section (analogous to how `project.md` has a template link).

## Verification

- Created `stack.md`, `modules.md`, and `glossary.md` under `templates/ai/context/`.
- Verified that `docs/structure/ai-agents.md` contains the template links for all five files.

### Walkthrough of Changes
1. Created `templates/ai/context/stack.md` to define tech stack template.
2. Created `templates/ai/context/modules.md` to define module map template.
3. Created `templates/ai/context/glossary.md` to define technical glossary template.
4. Modified `docs/structure/ai-agents.md` to include links to `stack.md`, `modules.md`, and `glossary.md` templates under the `ai/context/` description.
5. Staged and committed changes.
