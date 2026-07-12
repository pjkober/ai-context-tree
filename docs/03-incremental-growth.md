[← Previous: 🛠️ Core Principles](02-core-principles.md) | [Home (README)](../README.md) | [Next: 🏷️ Terminology Management →](04-terminology-management.md)

---

# The Principle of Incremental Structure Growth

A common pitfall is over-engineering a repository structure before writing actual code. The `ai-context-tree` is built around dynamic growth based on immediate needs.

## Starting Structure: The Minimal Tree

Every project starts with the absolute minimum set of directories and files. The structure expands directory by directory only when a concrete, real need arises.

### Minimal Structure Snapshot:
```txt
project/
├── .gitignore
├── AGENTS.md
├── MANIFEST.md
├── README.md
├── ai/
│   ├── context/
│   │   ├── project.md
│   │   └── structure-map.md
│   ├── rules/
│   ├── workflows/
│   │   └── new-feature.md
│   ├── skills/
│   │   └── example-skill.md
│   ├── history/
│   │   └── conver-001-example-transcript.md
│   └── runs/
│       └── run-001-example-automation.sh
├── docs/
├── src/
└── tests/
```

## How the Structure Grows

When a new requirement emerges, the team (human or AI) creates the corresponding directory. For example:
- `decisions/` is created only when the first Architectural Decision Record (ADR) needs to be written.
- `specs/` is created when the first feature requires documented business specifications and acceptance criteria.
- `contracts/` is created when the project starts exposing APIs or exchanging structured data between modules.

## The Role of `structure-map.md`

How do humans and AI agents know what folder names to use and when to create them? 

This is governed by the [structure-map.md](../templates/ai/context/structure-map.md) file, which acts as a full catalog of all officially named directories. Before creating a new top-level directory, the AI **must** consult the map to retrieve the official directory name and its creation conditions.

### Rules for adding directories:
1. Check `ai/context/structure-map.md` to see if there is an official name and definition for the folder you need.
2. If it exists, create the directory with that exact name and add it to [MANIFEST.md](../templates/MANIFEST.md).
3. If the directory is not listed in `structure-map.md`, **do not create it on your own**. Adding a new top-level directory is an architectural decision that must be approved by a human (e.g. raised as a task in `tasks.md` or a direct question).

## Shrinking the Structure

If a directory is no longer needed (for example, a prototype folder `prototypes/` after a sandbox experiment is finished), it should be deleted or moved to `archive/`. Keeping inactive, obsolete directories in the active workspace pollutes the AI's file-system search results and wastes context.

---
[← Previous: 🛠️ Core Principles](02-core-principles.md) | [Home (README)](../README.md) | [Next: 🏷️ Terminology Management →](04-terminology-management.md)

