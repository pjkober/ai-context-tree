---
id: task-079
tags:
  - tasks
status: todo
priority: low
type: feature
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on:
  - task-063
  - task-066
  - task-077
  - task-078
---

# Task-079: Create a Real-World Example Project in `examples/`

## Source
Report section 6.3 (Improvement).

## Location
- `examples/` directory (new, created on demand per incremental growth principle)

## Description

The documentation explains `ai-context-tree` in abstract terms. New adopters frequently struggle to translate abstract principles into concrete action. A minimal, realistic example project demonstrating the standard applied to a real codebase would dramatically accelerate adoption and reduce support questions.

The example should be minimal enough to be readable in under 10 minutes, but complete enough to illustrate all key concepts: AGENTS.md as hub, incremental structure, task-driven development, SSOT, and the AI rules files.

## What to Do

### Create `examples/minimal-nodejs-api/`

This is a synthetic minimal example of a Node.js REST API project applying the `ai-context-tree` standard. It contains no actual executable code, only the structural skeleton with populated, realistic content.

Structure:
```
examples/minimal-nodejs-api/
├── README.md           # "Example: Minimal Node.js API using ai-context-tree"
├── AGENTS.md           # Populated pointer file for this example project
├── MANIFEST.md         # Realistic manifest listing example files
├── ai/
│   ├── context/
│   │   ├── project.md      # Example: "User Authentication Service"
│   │   ├── stack.md        # Example: Node.js 20, Express 5, PostgreSQL, TypeScript
│   │   └── structure-map.md
│   ├── rules/
│   │   ├── coding.md       # Realistic populated rules (not placeholders)
│   │   ├── security.md     # Realistic populated rules
│   │   └── testing.md      # Realistic populated rules
│   └── workflows/
│       ├── new-feature.md  # Realistic workflow with SDD steps
│       └── bugfix.md       # Short realistic bugfix workflow
├── specs/
│   └── user-login/
│       ├── requirements.md  # Example requirements for login feature
│       └── acceptance.md   # Example acceptance criteria
├── tasks/
│   └── task-001-implement-login-endpoint.md  # Example populated task
└── docs/
    └── architecture.md     # Brief system overview
```

### Create `examples/README.md`

A top-level README explaining:
- What the examples directory contains.
- How to read the examples (read AGENTS.md first, then ai/context/, then the specs).
- How to use an example as a starting point.

## Verification

- `examples/minimal-nodejs-api/` exists with all listed files.
- Every file in the example is populated with realistic (non-placeholder) content.
- `examples/README.md` explains the purpose and how to use the examples.
- A reader can follow the information flow from `AGENTS.md` to `ai/context/project.md` to `specs/` to `tasks/` without encountering any stub content.
