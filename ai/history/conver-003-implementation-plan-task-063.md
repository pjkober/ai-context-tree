# Implementation Plan - Task-063: Rename `file-templates/` to `templates/`

This plan outlines the steps to resolve the naming discrepancy between the `file-templates/` directory on disk and the `templates/` directory referenced in scripts and documentation.

## User Review Required

> [!IMPORTANT]
> This change modifies the folder name from `file-templates/` to `templates/` on disk, which aligns it with the bootstrap scripts `create_minimal_structure.sh` and `create_minimal_structure.ps1`.
> We will also recursively replace all documentation links referencing `file-templates` to `templates`.

## Open Questions

None. The task is straightforward and critical to fix bootstrapping failures.

## Proposed Changes

---

### Scaffolding & Directory Structure

#### [NEW] [templates](file:///Users/pjk/code/ai-context-tree-new/templates)
We will rename the directory `/Users/pjk/code/ai-context-tree-new/file-templates` to `/Users/pjk/code/ai-context-tree-new/templates`.

#### [DELETE] [file-templates](file:///Users/pjk/code/ai-context-tree-new/file-templates)
The old directory `/Users/pjk/code/ai-context-tree-new/file-templates` will be deleted/renamed.

---

### Configuration & Templates

#### [MODIFY] [MANIFEST.md](file:///Users/pjk/code/ai-context-tree-new/templates/MANIFEST.md)
Update the `MANIFEST.md` template file to list `templates/` instead of `file-templates/`.

---

### Documentation & Reference Updates

#### [MODIFY] [README.md](file:///Users/pjk/code/ai-context-tree-new/README.md)
#### [MODIFY] [06-initialization-guide.md](file:///Users/pjk/code/ai-context-tree-new/docs/06-initialization-guide.md)
#### [MODIFY] [ai-agents.md](file:///Users/pjk/code/ai-context-tree-new/docs/structure/ai-agents.md)
#### [MODIFY] [business-knowledge.md](file:///Users/pjk/code/ai-context-tree-new/docs/structure/business-knowledge.md)
#### [MODIFY] [implementation.md](file:///Users/pjk/code/ai-context-tree-new/docs/structure/implementation.md)
#### [MODIFY] [root-files.md](file:///Users/pjk/code/ai-context-tree-new/docs/structure/root-files.md)
#### [MODIFY] [supporting.md](file:///Users/pjk/code/ai-context-tree-new/docs/structure/supporting.md)
All files referencing `file-templates` in their markdown links or descriptions will be updated to point to `templates`.

---

### Task Management

#### [MODIFY] [tasks.md](file:///Users/pjk/code/ai-context-tree-new/tasks.md)
Update the task-063 status to `done`.

#### [MODIFY] [task-063-rename-file-templates-to-templates.md](file:///Users/pjk/code/ai-context-tree-new/tasks/task-063-rename-file-templates-to-templates.md)
Set status to `done` and append the verification walkthrough details.

## Verification Plan

### Automated Tests
- Syntax check on shell scripts:
  ```bash
  bash -n create_minimal_structure.sh
  ```
- Check for remaining references:
  ```bash
  /usr/bin/git grep "file-templates"
  ```
  *(Expecting 0 matches in active tracked codebase except in the task-063 documentation)*

### Manual Verification
- Verify directory presence:
  ```bash
  ls -la templates
  ```
