# Implementation Plan - Task-071: Document MANIFEST.md Update Trigger Rule

This plan outlines the steps to document the trigger conditions and requirements for updating `MANIFEST.md` to ensure consistency.

## User Review Required

> [!IMPORTANT]
> The following files will be modified:
> 1. `templates/AGENTS.md` - Add tree entry for the MANIFEST.md Update Rule under the "Follow" guidelines section.
> 2. `docs/structure/root-files.md` - Add a "When to Update" subsection with explicit triggers for `MANIFEST.md`.
> 3. `templates/ai/workflows/new-feature.md` - Add a workflow step to update the manifest when directories or key files are created.

## Open Questions

None. The trigger rules resolve manifest staleness/inconsistency as specified.

## Proposed Changes

---

### Scaffolding & Templates

#### [MODIFY] [AGENTS.md](file:///Users/pjk/code/ai-context-tree-new/templates/AGENTS.md)
Add the `MANIFEST.md Update Rule` in the "Follow (Rules & Guidelines)" section.

#### [MODIFY] [new-feature.md](file:///Users/pjk/code/ai-context-tree-new/templates/ai/workflows/new-feature.md)
Add step 6: `6. Update MANIFEST.md if any new directories or key files were created during this task.`

---

### Documentation

#### [MODIFY] [root-files.md](file:///Users/pjk/code/ai-context-tree-new/docs/structure/root-files.md)
Add the "When to Update" subsection to `MANIFEST.md` section specifying when updates are required and when they are not.

---

### Task Tracking

#### [MODIFY] [tasks.md](file:///Users/pjk/code/ai-context-tree-new/tasks.md)
Update status of task-071 to `done`.

#### [MODIFY] [task-071-document-manifest-update-trigger-rule.md](file:///Users/pjk/code/ai-context-tree-new/tasks/task-071-document-manifest-update-trigger-rule.md)
Set status to `done` and record the verification walkthrough.

## Verification Plan

### Automated Tests
None.

### Manual Verification
- Review the modified templates (`templates/AGENTS.md` and `templates/ai/workflows/new-feature.md`) and documentation (`docs/structure/root-files.md`) to verify markdown structure and clarity of instructions.
