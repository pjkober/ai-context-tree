# Implementation Plan - Task-064: Remove Duplicate Mermaid Diagram

This plan outlines the steps to resolve the Single Source of Truth (SSOT) violation caused by the identical Mermaid context-flow diagram being present in both `README.md` and `docs/05-ai-integration.md`.

## User Review Required

> [!IMPORTANT]
> The Mermaid diagram in `README.md` will be replaced with a link pointing directly to the canonical diagram in `docs/05-ai-integration.md#context-flow`.

## Open Questions

None. The task is straightforward and aligns with project Principle 1 (SSOT).

## Proposed Changes

---

### Documentation

#### [MODIFY] [README.md](file:///Users/pjk/code/ai-context-tree-new/README.md)
Remove lines 39-51 containing the duplicate Mermaid diagram block and replace it with a text reference and link pointing to `docs/05-ai-integration.md#context-flow`.

---

### Task Tracking

#### [MODIFY] [tasks.md](file:///Users/pjk/code/ai-context-tree-new/tasks.md)
Update status of task-064 to `done`.

#### [MODIFY] [task-064-remove-duplicate-mermaid-diagram.md](file:///Users/pjk/code/ai-context-tree-new/tasks/task-064-remove-duplicate-mermaid-diagram.md)
Set status to `done` and record the verification details at the bottom of the file.

## Verification Plan

### Automated Tests
None.

### Manual Verification
- View `README.md` to ensure the Mermaid block has been replaced with the link:
  `For a detailed diagram of the context flow, see the [Context Flow section](docs/05-ai-integration.md#context-flow) in the AI Client Integration Guide.`
- Click the link to ensure it successfully navigates to the target header in `docs/05-ai-integration.md`.
