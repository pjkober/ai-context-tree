---
aliases:
  - SDD
tags:
  - knowledge
  - sdd
<<<<<<< HEAD
=======
  - methodology
  - specs
>>>>>>> dev
type: docs
---

# Spec-Driven Development

**Spec-Driven Development (SDD)** is a software development methodology where design requirements, interfaces, and testing criteria are formally specified *before* any implementation code is written. In AI-First engineering, SDD provides a structured interface that prevents agents from "guessing" how to implement code.

Instead of writing code first, developers define specifications in `specs/` (see [Living Specifications](Living%20Specifications.md)) and API structures in `contracts/` (see [API Contracts](API%20Contracts.md)). The AI agent then uses these documents to generate the tests and implementation, ensuring strict compliance and avoiding the common pitfalls of [Vibe Coding](Vibe%20Coding.md).
