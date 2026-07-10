---
aliases: []
tags:
  - knowledge
type: docs
---

# Boy Scout Rule

The **Boy Scout Rule** in software development states: *"Always leave the campground cleaner than you found it."* Applied to coding with AI agents, it determines whether the agent is allowed to refactor and clean up minor issues in files it is already modifying for a task.

In the `ai-context-tree` standard, the developer configures the AI's refactoring policy:
1. **Strict Scope:** The AI agent is restricted to modifying only the lines and files directly necessary for the task, avoiding any unsolicited cleaning or formatting changes.
2. **Boy Scout Rule:** The AI agent is encouraged to proactively fix minor code smells, improve naming, add missing error handling, or fix typing issues in the files it is already touching, provided it does not expand the task's scope excessively.
