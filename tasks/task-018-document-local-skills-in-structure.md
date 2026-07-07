---
id: task-018
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

# Task-018: Document Local Skills in ai/skills/ and IDE Pointer Linking

**Location:** `docs/structure/ai-agents.md` and `docs/05-ai-integration.md`

**Description:**
1. Document the addition of `ai/skills/` directory in `docs/structure/ai-agents.md`. Define its purpose: storing project-specific agent skills (e.g. `ai/skills/my-skill/SKILL.md` or `.md` files) to ensure they are versioned, shared, and accessible to any AI agent.
2. In `docs/05-ai-integration.md`, add guidelines and examples on how to link tool-specific config (like `.cursor/rules/my-skill.mdc` or `.agents/skills/`) back to the universal skills in `ai/skills/` to preserve the Single Source of Truth (SSOT) principle.
3. Update `file-templates/ai/context/structure-map.md` and `docs/03-incremental-growth.md` to include `ai/skills/` in the structure map with its appropriate creation conditions.

**Justification:**
Formalizes the location of project-scoped AI skills within the universal structure and prevents duplication of skill content in tool-specific configuration formats.
