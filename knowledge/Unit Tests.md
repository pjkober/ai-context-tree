---
aliases:
  - unit test
  - testy jednostkowe
tags:
  - knowledge
<<<<<<< HEAD
=======
  - testing
  - unit-tests
  - strategy
>>>>>>> dev
type: docs
---

# Unit Tests

**Unit Tests** (Testy jednostkowe) verify the correctness of individual, isolated pieces of code in isolation—typically functions, methods, classes, or small modules. They isolate the target code from external dependencies (such as databases, network services, or filesystem access) using mocks, stubs, or fakes.

In the `ai-context-tree` standard, the developer configures the AI agent's test execution scope. Unit testing represents the lightest test execution level:
- **Scope:** The agent executes only unit tests directly related to the code files it has modified or created.
- **Goal:** Fast feedback loop during local iterations, ensuring that modifications do not break basic functions and logic boundaries.
- **Relations:** Compare with [Integration Tests](Integration%20Tests.md) and [Test-Driven Development](Test-Driven%20Development.md).
