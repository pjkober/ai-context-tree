[Previous: Root Files](root-files.md) | [Home (README)](../../README.md) | [Next: Business Specifications and Contracts ->](business-knowledge.md)

---

# ai/ — AI Agents Directory

The `ai/` directory contains guidelines, rules, deterministic workflows, templates, and prompts that govern AI client behavior. This directory is shared: humans can read it to learn project rules, and AI agents consult it to understand how to operate.

---

## ai/context/

Project description and stack entry points.

- **Role:** High-level project context files, including `project.md`, `stack.md`, `modules.md`, `glossary.md`, and `structure-map.md`.
- **Rule:** These files are entry points and must contain *only* high-level descriptions and links to actual detailed guides in `docs/`, `config/`, or `decisions/`. No duplication of technical details is allowed.
- **Template (project.md):** [templates/ai/context/project.md](../../templates/ai/context/project.md)
- **Template (stack.md):** [templates/ai/context/stack.md](../../templates/ai/context/stack.md)
- **Template (modules.md):** [templates/ai/context/modules.md](../../templates/ai/context/modules.md)
- **Template (glossary.md):** [templates/ai/context/glossary.md](../../templates/ai/context/glossary.md)

### structure-map.md
A crucial file that supports the incremental growth principle.
- **Role:** A flat catalog of all possible directories described in this standard, along with the conditions under which they should be created.
- **Rule:** The AI agent must consult this map before creating a new top-level directory.
- **Template:** [templates/ai/context/structure-map.md](../../templates/ai/context/structure-map.md)

---

## ai/rules/

Rules and conventions governing the AI's behavior.

- **Role:** Houses coding standards, style guidelines, security rules, and testing requirements (e.g. `coding.md`, `security.md`, `testing.md`).
- **Rule:** Files in `rules/` must contain *only* rules, not step-by-step procedures. Procedures belong in `workflows/`.
- **Template (coding.md):** [templates/ai/rules/coding.md](../../templates/ai/rules/coding.md)
- **Template (security.md):** [templates/ai/rules/security.md](../../templates/ai/rules/security.md)
- **Template (testing.md):** [templates/ai/rules/testing.md](../../templates/ai/rules/testing.md)



---

## ai/workflows/

Atomic, step-by-step procedures executed by both humans and AI.

- **Role:** Procedural steps for repeatable tasks like implementing features, fixing bugs, or running releases (e.g. `new-feature.md`, `bugfix.md`).
- **Rule:** Workflows must be deterministic and executed sequentially.
- **Template (new-feature.md):** [templates/ai/workflows/new-feature.md](../../templates/ai/workflows/new-feature.md)
- **Template (bugfix.md):** [templates/ai/workflows/bugfix.md](../../templates/ai/workflows/bugfix.md)
- **Template (release.md):** [templates/ai/workflows/release.md](../../templates/ai/workflows/release.md)

---

## ai/prompts/

Ready-to-use prompts for manual triggering.

- **Role:** Generic prompts (like `create-api.md`, `review.md`) that developers can feed to their AI assistant.
- **Rule:** Must not contain rules (e.g. "always", "never"). Rules belong in `rules/`.
- **Template (create-api.md):** [templates/ai/prompts/create-api.md](../../templates/ai/prompts/create-api.md)

---

## ai/templates/

Code scaffolding templates.

- **Role:** Standard design pattern code skeletons organized by architectural role (e.g. `service/`, `controller/`) as folders and technologies as files (e.g. `typescript.md`, `python.md`).
- **Rule:** Subdirectories represent patterns, files represent languages or frameworks.

---

## ai/lessons/

Role: Extracted knowledge -- what was learned from past mistakes or decisions.

- **Role:** Tracks historical lessons, post-mortems, known issues, and technical debt.
- **Rule:** Must only be used for historical knowledge. Active items and backlogs belong in `tasks.md`.
- **Question it answers:** "What should future agents know to avoid this mistake?"
- **Example:** `lesson-001-never-use-orm-transactions-with-queue.md` (e.g. detailed lesson learned from a webhook parsing issue).
- **Template:** [templates/ai/lessons/lesson-001-example.md](../../templates/ai/lessons/lesson-001-example.md)

---

## ai/skills/

Project-specific local agent skills.

- **Role:** Houses custom modular capabilities and tools built to extend the power of AI agents for this specific repository (e.g. specialized data scrapers, custom code analysis hooks, or interactive testing workflows).
- **Format:** Each skill should reside in its own folder or file (e.g. `ai/skills/my-skill/SKILL.md` or `ai/skills/my-skill.md`).
- **Rule:** Universal skills belong here so they are version-controlled and shared across the team. IDE-specific rules (like `.cursor/` or `.agents/`) must simply link back to files in `ai/skills/` to prevent duplication (SSOT).
- **Template:** [templates/ai/skills/example-skill.md](../../templates/ai/skills/example-skill.md)

---

## ai/history/

Role: Raw session logs -- what was said between the developer and the AI agent.

- **Role:** Stores transcript logs, session reviews, or conversation summaries between developers and AI agents (e.g. `conver-NNN-description.md`).
- **Question it answers:** "What was discussed in this session?"
- **Example:** `conver-001-setup-payments-api.md` (transcript/chat log of the session that designed the payments module).
- **Core Rules:**
  - **Descriptive Naming:** Files must be sequentially numbered and descriptively named (e.g. `conver-001-setup-payments-api.md`).
  - **Cleanliness (No Secrets Rule):** Absolutely zero hardcoded API keys, passwords, or secrets.
  - **Purpose:** Helps future agents understand the conversational context and "mental model" behind complex architectural decisions, preventing repetition of past errors.
- **Template:** [templates/ai/history/conver-001-example-transcript.md](../../templates/ai/history/conver-001-example-transcript.md)

---

## ai/runs/

Reusable agent execution scripts.

- **Role:** Stores bash or PowerShell automation scripts generated by AI agents to perform tasks (e.g. `run-001-migrate-database.sh`, `run-002-generate-mocks.ps1`).
- **Core Rules:**
  - **Descriptive Naming:** Files must be sequentially numbered and descriptively named (e.g. `run-001-seed-test-users.sh`).
  - **Cleanliness (No Secrets Rule):** Absolutely zero hardcoded API keys, passwords, or secrets. Must load environment variables from `.env`.
  - **Only Reusable Scripts:** Only store reusable scripts with automation value. Do not save logs of one-off throwaway commands.
- **Template:** [templates/ai/runs/run-001-example-automation.sh](../../templates/ai/runs/run-001-example-automation.sh)

### Script Header Convention

Every run script must begin with a metadata comment block immediately after the shebang line:

```bash
#!/usr/bin/env bash
# ---
# id: run-NNN
# description: [One sentence describing what this script does]
# created: YYYY-MM-DD
# last-run: YYYY-MM-DD
# reusable: true|false   # true = safe to run again; false = one-time-use, archive after use
# idempotent: true|false # true = running multiple times has the same effect as once
# author: [agent name or developer name]
# ---
```

**Lifecycle rules based on `reusable` field:**
- `reusable: true` -- Keep the script in `ai/runs/`. Update `last-run` date after each execution.
- `reusable: false` -- After successful execution, move the script to `archive/` or delete it. Do not leave one-time scripts accumulating in `ai/runs/`.

---
[Previous: Root Files](root-files.md) | [Home (README)](../../README.md) | [Next: Business Specifications and Contracts ->](business-knowledge.md)



