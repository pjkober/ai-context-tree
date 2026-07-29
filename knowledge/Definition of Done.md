---
aliases:
  - DoD
  - task completion criteria
tags:
  - knowledge
  - workflow
  - task-lifecycle
  - quality
type: docs
---

# Definition of Done (DoD)

The **Definition of Done** (DoD) is a shared, formal agreement specifying the quality criteria and verification steps that a task or feature must satisfy before it can be marked as complete.

In the `ai-context-tree` standard, the DoD governs the final steps of an AI agent's task lifecycle:
- **Verification steps:** Typically includes running the linter, executing the configured test suite (e.g. [Unit Tests](Unit%20Tests.md) or [Integration Tests](Integration%20Tests.md)), checking for security flags, and updating documentation.
- **Enforcement:** By defining a clear DoD, the team prevents AI agents from presenting incomplete, unformatted, or broken code.
- **Workflow hook:** In `ai-context-tree`, the agent must verify all DoD criteria before changing a task's status to `done` and appending its walkthrough details.
