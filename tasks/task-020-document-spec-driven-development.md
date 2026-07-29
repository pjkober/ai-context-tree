---
id: task-020
tags:
  - tasks
status: done
priority: high
type: docs
owner: Antigravity
created: 2026-07-07
updated: 2026-07-07
depends_on: []
---

# Task-020: Document Spec-Driven Development in knowledge/Spec-Driven Development.md

**Location:** `knowledge/Spec-Driven Development.md`

**Description:**
Create a comprehensive domain knowledge file explaining Spec-Driven Development (SDD) in the context of our standard. The document must:
- Use the requested frontmatter structure:
  ```md
  ---
  aliases:
    - SDD
  tags:
    - knowledge
    - sdd
  type: docs
  ---
  ```
- Explain what Spec-Driven Development is and how `ai-context-tree` implements its goals.
- Include definitions of important domain terms for junior developers (max. 2-3 paragraphs per heading):
  - **Vibe Coding** (what it is, the risks of code-first development with AI, and why it degrades projects).
  - **Living Specifications** (how `specs/` requirements and acceptance criteria act as executable sources of truth).
  - **API Contracts & Boundaries** (how `contracts/` prevent LLM hallucination of data schemas).
  - **Context Pollution & Context Window** (the mechanics of LLM memory limits and how file size affects reasoning).

**Justification:**
Enables beginners and junior developers to understand the conceptual framework behind our project structure without needing to search online, establishing a shared lexicon.
