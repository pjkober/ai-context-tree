---
aliases:
  - full coverage tests
  - full test coverage
tags:
  - knowledge
type: docs
---

# Full Coverage

**Full Coverage** (Full test coverage) is a testing rigor strategy where the AI agent is instructed to write comprehensive unit and integration tests covering all new and modified logical paths. A task or feature is not considered complete unless it meets high-quality coverage thresholds.

In the `ai-context-tree` standard, the developer configures the testing coverage policy:
- **Rule:** The AI agent must cover all new classes, utility functions, edge cases, and code branches with tests before presenting the changes for review.
- **Rigor:** This mode is best suited for production-grade databases, payment APIs, core libraries, and mission-critical applications where regression prevention outweighs development speed.
- **Relations:** Compare with [Critical Path](Critical%20Path.md) (prioritizing critical workflows) and [Definition of Done](Definition%20of%20Done.md).
