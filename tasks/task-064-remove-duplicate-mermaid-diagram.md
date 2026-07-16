---
id: task-064
tags:
  - tasks
status: done
priority: high
type: docs
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on: []
---

# Task-064: Remove Duplicate Mermaid Diagram (SSOT Violation)

## Source
Report section 4.2 (HIGH).

## Location
- `README.md` lines 39-51 (duplicate — to be replaced with a link)
- `docs/05-ai-integration.md` lines 117-129 (canonical — keep as-is)

## Description

The identical Mermaid `flowchart TD` context-flow diagram appears verbatim in both `README.md` and `docs/05-ai-integration.md`. This is a direct violation of the project's SSOT principle (Principle 1). If the diagram is updated in one file, it must be manually updated in the other, creating a maintenance hazard and a risk of drift.

## What to Do

1. Confirm the canonical location is `docs/05-ai-integration.md` (the more detailed context document).
2. In `README.md`, delete the Mermaid code block (the section between the opening ` ```mermaid ` and closing ` ``` `).
3. Replace it with a prose sentence linking to the canonical diagram, for example:
   ```markdown
   For a detailed diagram of the context flow, see the [Context Flow section](docs/05-ai-integration.md#context-flow) in the AI Client Integration Guide.
   ```
4. Ensure the heading `## Context Flow` exists in `docs/05-ai-integration.md` as an anchor target (currently present at line 113).
5. Update `tasks.md` index to reference this task.

## Verification

- `README.md` contains no Mermaid code block.
- `docs/05-ai-integration.md` still contains the full diagram.
- The link from `README.md` to `docs/05-ai-integration.md#context-flow` resolves correctly in a Markdown renderer.

### Walkthrough of Changes
1. Removed the duplicate Mermaid diagram block from `README.md`.
2. Replaced the diagram block in `README.md` with a link directly pointing to the canonical `Context Flow` section in `docs/05-ai-integration.md#context-flow`.
3. Verified that `docs/05-ai-integration.md` contains the canonical `Context Flow` heading and diagram.
4. Staged and committed the changes.
