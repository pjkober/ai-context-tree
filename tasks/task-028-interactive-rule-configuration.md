---
id: task-028
tags:
  - tasks
status: done
priority: high
type: feature
owner: Antigravity
created: 2026-07-07
updated: 2026-07-07
depends_on: []
---

# Task-028: Interactive Rule Configuration in Setup Scripts

**Location:**
- `create_minimal_structure.sh`
- `create_minimal_structure.ps1`
- `templates/ai/rules/coding.md`
- `templates/ai/rules/security.md`
- `docs/05-ai-integration.md` (or a new guide describing configuration options)

**Description:**
Extend the minimal structure initialization scripts to offer interactive configuration for AI rules and preferences. 
Specifically, ask the user:
1. **Decision-making / Autonomy Style:**
   - 1) Consultative / Ask-First (If you don't know: ask, don't guess)
   - 2) Autonomous / Proactive (If you don't know: decide what's best, implement and explain)
   - 3) Plan-First (Write a plan first, wait for approval)
2. **Refactoring Policy:**
   - 1) Strict Scope (Only touch lines directly related to the task)
   - 2) Boy Scout Rule (Clean up minor code smells and inconsistencies in modified files)
3. **Dependency Policy:**
   - 1) Strict / Ask-First (Never install new libraries without permission)
   - 2) Proactive (Allowed to install standard packages)
4. **Tech Stack / Frameworks:**
   - 1) Node.js / TypeScript
   - 2) Python
   - 3) Go
   - 4) React / Next.js
   - 5) Decide later / I'll customize it later (default fallback)

Write these choices dynamically into `ai/rules/coding.md` and `ai/rules/security.md` (or create a dedicated `ai/rules/autonomy.md`). Ensure the scripts run in non-interactive fallback mode if a flag (e.g., `--non-interactive`) is provided or stdin is not a TTY.

**Justification:**
Provides developers with a customized, AI-native setup experience, ensuring immediate alignment between the developer's preferences and the agent's behavior.

## Verification Walkthrough

1. **Rule Templates Updated:** Updated `coding.md` and added `security.md` templates under `templates/ai/rules/` to contain custom preference placeholders.
2. **Bash Setup Script Extended:** Modified `create_minimal_structure.sh` to prompt the user with interactive choice menus for all four categories. Implemented `--non-interactive` flag checks to default to consultative/strict/decide later modes.
3. **PowerShell Setup Script Extended:** Modified `create_minimal_structure.ps1` with equivalent interactive prompts using `Read-Host` and headless mode using `-NonInteractive` flag.
4. **Placeholder Substitution Verified:** Tested placeholder replacement via Python inline parser scripts and confirmed the correct markdown snippets are generated.
5. **Documentation Updated:** Documented the new rules files and configuration process in `docs/structure/ai-agents.md`.

