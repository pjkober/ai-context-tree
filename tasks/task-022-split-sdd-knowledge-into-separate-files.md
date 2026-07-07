---
id: task-022
tags:
  - tasks
status: done
priority: high
type: refactor
owner: Antigravity
created: 2026-07-07
updated: 2026-07-07
depends_on: []
---

# Task-022: Split Spec-Driven Development Knowledge into Separate Term Files

**Location:** `knowledge/` directory

**Description:**
Split the overly large `knowledge/Spec-Driven Development.md` file into individual term-focused files (one topic = one file). Each file must be short (max 2-3 paragraphs total) and have the H1 header matching its filename exactly:

1. **`knowledge/Spec-Driven Development.md`** (H1: `# Spec-Driven Development` - definition, how `ai-context-tree` implements it, linking to other terms like [Living Specifications](Living%20Specifications.md) and [API Contracts](API%20Contracts.md), and contrasting with [Vibe Coding](Vibe%20Coding.md)).
2. **`knowledge/Vibe Coding.md`** (H1: `# Vibe Coding` - definition, risks, and how [Spec-Driven Development](Spec-Driven%20Development.md) prevents it).
3. **`knowledge/Living Specifications.md`** (H1: `# Living Specifications` - definition, role of `specs/` requirements, and integration in [Spec-Driven Development](Spec-Driven%20Development.md)).
4. **`knowledge/API Contracts.md`** (H1: `# API Contracts` - definition, role of `contracts/`, and integration in [Spec-Driven Development](Spec-Driven%20Development.md)).
5. **`knowledge/Context Management.md`** (H1: `# Context Management` - definition of context window and context pollution, and how our layout manages it).

**Justification:**
Aligns the terminology documentation with our core principles of "One topic = one file" and "Small files" (max 300 lines), facilitating better LLM context loading and human readability.
