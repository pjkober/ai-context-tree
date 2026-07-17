---
aliases:
  - integration test
  - testy integracyjne
tags:
  - knowledge
  - testing
  - integration
  - strategy
type: docs
---

# Integration Tests

**Integration Tests** (Testy integracyjne) verify that multiple software modules or components function correctly together. Unlike [Unit Tests](Unit%20Tests.md), integration tests do not isolate the target components from each other; instead, they check the flow of data and control between subsystems, such as database integrations, API endpoints, or file storage layers.

In the `ai-context-tree` standard, the developer configures when the AI agent should execute integration tests:
- **Scope:** The agent runs integration tests that cover the module or package containing the modified code.
- **Goal:** To ensure that changes to modular components do not disrupt communication, data schemas, or contracts between different layers of the application.
- **Relations:** See also [API Contracts](API%20Contracts.md).
