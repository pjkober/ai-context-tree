# Implementation Plan - Task-072: Clarify Distinction Between `ai/history/` and `ai/memory/`

This plan outlines the steps to rename the `ai/memory/` folder to `ai/lessons/` across all documentation, templates, and scripts, and to add a concrete example template to clearly differentiate "lessons learned" from conversational "history".

## User Review Required

> [!IMPORTANT]
> The folder `ai/memory/` will be renamed to `ai/lessons/` to avoid ambiguity with `ai/history/`.
> The following templates and configurations will be updated to reflect this name change:
> - `README.md`
> - `docs/structure/root-files.md`
> - `docs/structure/ai-agents.md`
> - `templates/AGENTS.md`
> - `templates/MANIFEST.md`
> - `templates/ai/context/structure-map.md`
> - `create_minimal_structure.sh`
> - `tasks/task-089-create-rollback-workflow.md`
> A new example template file `templates/ai/lessons/lesson-001-example.md` will be created.

## Open Questions

None. Renaming to `ai/lessons/` resolves the ambiguity and was the recommended option.

## Proposed Changes

---

### Scaffolding & Templates

#### [MODIFY] [AGENTS.md](file:///Users/pjk/code/ai-context-tree-new/templates/AGENTS.md)
Replace `ai/memory/` reference or add `ai/lessons/` under "Log history & runs" section.

#### [MODIFY] [MANIFEST.md](file:///Users/pjk/code/ai-context-tree-new/templates/MANIFEST.md)
Add `ai/lessons/` directory entry to `templates/MANIFEST.md`.

#### [MODIFY] [structure-map.md](file:///Users/pjk/code/ai-context-tree-new/templates/ai/context/structure-map.md)
Add `ai/lessons/` entry to the directory structure map table.

#### [NEW] [lesson-001-example.md](file:///Users/pjk/code/ai-context-tree-new/templates/ai/lessons/lesson-001-example.md)
Create a post-mortem/lessons learned template demonstrating expected format.

#### [MODIFY] [create_minimal_structure.sh](file:///Users/pjk/code/ai-context-tree-new/create_minimal_structure.sh)
Add copying code for `ai/lessons/lesson-001-example.md`.

---

### Documentation

#### [MODIFY] [README.md](file:///Users/pjk/code/ai-context-tree-new/README.md)
Update the project tree structure diagram to replace `memory/` with `lessons/`.

#### [MODIFY] [root-files.md](file:///Users/pjk/code/ai-context-tree-new/docs/structure/root-files.md)
Update rule under `tasks.md` section to refer to `ai/lessons/` instead of `ai/memory/`.

#### [MODIFY] [ai-agents.md](file:///Users/pjk/code/ai-context-tree-new/docs/structure/ai-agents.md)
Rename `## ai/memory/` section to `## ai/lessons/` and rewrite both `history` and `lessons` descriptions to include the clear disambiguation notes and concrete examples.

---

### Task Tracking

#### [MODIFY] [task-089-create-rollback-workflow.md](file:///Users/pjk/code/ai-context-tree-new/tasks/task-089-create-rollback-workflow.md)
Update directory reference from `ai/memory/` to `ai/lessons/`.

#### [MODIFY] [tasks.md](file:///Users/pjk/code/ai-context-tree-new/tasks.md)
Update status of task-072 to `done`.

#### [MODIFY] [task-072-clarify-history-vs-memory-distinction.md](file:///Users/pjk/code/ai-context-tree-new/tasks/task-072-clarify-history-vs-memory-distinction.md)
Set status to `done` and record the verification details.

## Verification Plan

### Automated Tests
- Validate script syntax:
  ```bash
  bash -n create_minimal_structure.sh
  ```

### Manual Verification
- Review updated markdown files to ensure all links render and directories are correctly referenced.
