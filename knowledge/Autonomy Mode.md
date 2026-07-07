---
aliases: []
tags:
  - knowledge
type: docs
---

# Autonomy Mode

**Autonomy Mode** defines the level of decision-making authority granted to an AI coding agent within a repository. It governs how the agent acts when facing design alternatives, technical uncertainty, or incomplete requirements.

In the `ai-context-tree` standard, the user configures the Autonomy Mode to be one of the following:
1. **Consultative Mode (Ask-First):** The AI agent is instructed to stop and request clarification or approval from the developer immediately upon encountering any ambiguity or alternative solutions.
2. **Autonomous Mode (Proactive):** The AI agent uses its expertise to make the best implementation decisions independently, carrying them out and summarizing the rationale in its final report.
3. **Plan-First Mode:** The AI agent must first document an implementation plan (usually under the `plans/` or `tasks/` directory) and obtain approval from the developer before executing any code changes.
