---
aliases: []
tags:
  - knowledge
  - context
  - llm
  - performance
type: docs
---

# Context Management

**Context Management** is the practice of controlling the amount and structure of the information fed to an AI agent to optimize its reasoning capabilities. It addresses the limits of the AI's **Context Window** (the maximum text it can read at once) and prevents **Context Pollution** (filling the window with redundant or irrelevant files).

Poor context management degrades AI performance, leading to hallucinations or forgotten instructions. Our standard manages context by enforcing short files (100–300 lines) and using `MANIFEST.md` to load only the relevant files. This ensures that the AI stays focused on the active task in [Spec-Driven Development](Spec-Driven%20Development.md).
