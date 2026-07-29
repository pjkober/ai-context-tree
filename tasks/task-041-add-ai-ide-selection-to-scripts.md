---
id: task-041
tags:
  - tasks
status: done
priority: medium
type: feature
owner: Antigravity
created: 2026-07-09
updated: 2026-07-09
depends_on: []
---

# Task-041: Add AI IDE Selection to Initialization Scripts

**Location:** `create_minimal_structure.sh`, `create_minimal_structure.ps1`, `docs/06-initialization-guide.md`, `docs/05-ai-integration.md`

**Description:**
1. Update `create_minimal_structure.sh` and `create_minimal_structure.ps1` to ask the user which AI IDE thin pointer files to generate.
2. Standardize prompts to support default parameters (so pressing Enter accepts the default value).
3. Expand Section 5 selections to support 9 custom pointer files (representing 10 popular tools, with Antigravity and OpenCode natively supported): Claude Code, Cursor, Cline/Roo Code, Windsurf, GitHub Copilot, JetBrains AI Assistant, Aider, Tabnine, and Cody.
4. Set the default wizard option for Section 5 to `1. Standard (only AGENTS.md)` which outputs no additional custom configurations.
5. Document all tools and their configurations in `docs/05-ai-integration.md` and `docs/06-initialization-guide.md`.
6. Verify the changes.

## Verification Walkthrough

1. **Default Option Selection:**
   * Modified all prompts in both scripts to explicitly include a default value in the prompt text (e.g. `[Default: 1]`).
   * Used parameter expansion (`opt=${opt:-1}`) in Bash and check conditionals (`if ([string]::IsNullOrWhiteSpace($opt)) { $opt = "1" }`) in PowerShell to ensure pressing Enter falls back to the default choice.

2. **AI IDE Integration Selection Menu:**
   * Added Section 5 to the interactive wizards with options:
     - `1. Standard (only AGENTS.md) [Default]` (keeps all GEN_* variables false, listing tools like Antigravity, OpenCode, Gemini CLI, etc. that do not require custom configs).
     - `2. Custom (Choose individually)` (includes a descriptive subtext listing all 9 custom configuration tools, prompting for each file).
     - `3. All (Generate files for all 10 popular AI IDEs)` (activates all 9 configuration files).

   * Verified directory and file creation logic for `.github/copilot-instructions.md`, `.aiassistant/rules/main.md`, `CONVENTIONS.md`, `.aider.conf.yml`, `.tabnine/guidelines/main.md`, and `.cody/rules.md` in addition to the root rules files (`CLAUDE.md`, `.cursorrules`, `.clinerules`, `.windsurfrules`).

3. **Documentation:**
   * Updated `docs/05-ai-integration.md` to document the 10 popular AI tools, their pointer files, and native support details (grouping Antigravity & OpenCode).
   * Updated `docs/06-initialization-guide.md` to document the new Section 5 options and natively supported tools (Antigravity & OpenCode).


