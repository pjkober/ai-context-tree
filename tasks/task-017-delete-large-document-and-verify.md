---
id: task-017
tags:
  - tasks
status: done
priority: high
type: chore
owner: Antigravity
created: 2026-07-07
updated: 2026-07-07
depends_on:
  - task-012
  - task-013
  - task-014
  - task-015
  - task-016
---

# Task-017: Delete Old Document and Verify Relative Links

**Location:** Repository Root

**Description:**
1. Delete the old document `Universal Project Structure for AI-First Development & Multi-Agent Collaboration.md` to prevent duplication (SSOT).
2. Perform a comprehensive check of all markdown links (`[text](url)`) in:
   - `README.md`
   - `docs/*.md`
   - `docs/structure/*.md`
   - `templates/**/*.md` (if applicable)
   Make sure all links point to existing files relative to their directories and are not broken.

**Justification:**
Ensures repository cleanliness and validates link integrity so that both humans and LLM agents can navigate without hitting dead ends.
