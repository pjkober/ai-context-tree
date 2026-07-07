# ai/ — AI Agents Directory

The `ai/` directory contains guidelines, rules, deterministic workflows, templates, and prompts that govern AI client behavior. This directory is shared: humans can read it to learn project rules, and AI agents consult it to understand how to operate.

---

## ai/context/

Project description and stack entry points.

- **Role:** High-level project context files, including `project.md`, `stack.md`, `modules.md`, `glossary.md`, and `structure-map.md`.
- **Rule:** These files are entry points and must contain *only* high-level descriptions and links to actual detailed guides in `docs/`, `config/`, or `decisions/`. No duplication of technical details is allowed.
- **Template (project.md):** [file-templates/ai/context/project.md](../../file-templates/ai/context/project.md)

### structure-map.md
A crucial file that supports the incremental growth principle.
- **Role:** A flat catalog of all possible directories described in this standard, along with the conditions under which they should be created.
- **Rule:** The AI agent must consult this map before creating a new top-level directory.
- **Template:** [file-templates/ai/context/structure-map.md](../../file-templates/ai/context/structure-map.md)

---

## ai/rules/

Rules and conventions governing the AI's behavior.

- **Role:** Houses coding standards, style guidelines, security rules, and testing requirements (e.g. `coding.md`, `testing.md`).
- **Rule:** Files in `rules/` must contain *only* rules, not step-by-step procedures. Procedures belong in `workflows/`.
- **Template (coding.md):** [file-templates/ai/rules/coding.md](../../file-templates/ai/rules/coding.md)

---

## ai/workflows/

Atomic, step-by-step procedures executed by both humans and AI.

- **Role:** Procedural steps for repeatable tasks like implementing features, fixing bugs, or running releases (e.g. `new-feature.md`, `bugfix.md`).
- **Rule:** Workflows must be deterministic and executed sequentially.
- **Template (new-feature.md):** [file-templates/ai/workflows/new-feature.md](../../file-templates/ai/workflows/new-feature.md)

---

## ai/prompts/

Ready-to-use prompts for manual triggering.

- **Role:** Generic prompts (like `create-api.md`, `review.md`) that developers can feed to their AI assistant.
- **Rule:** Must not contain rules (e.g. "always", "never"). Rules belong in `rules/`.
- **Template (create-api.md):** [file-templates/ai/prompts/create-api.md](../../file-templates/ai/prompts/create-api.md)

---

## ai/templates/

Code scaffolding templates.

- **Role:** Standard design pattern code skeletons organized by architectural role (e.g. `service/`, `controller/`) as folders and technologies as files (e.g. `typescript.md`, `python.md`).
- **Rule:** Subdirectories represent patterns, files represent languages or frameworks.

---

## ai/memory/

Project historical memory.

- **Role:** Tracks historical lessons, post-mortems, known issues, and technical debt (e.g. `known-problems.md`).
- **Rule:** Must only be used for historical knowledge. Active items and backlogs belong in `task.md`.

---

## ai/skills/

Project-specific local agent skills.

- **Role:** Houses custom modular capabilities and tools built to extend the power of AI agents for this specific repository (e.g. specialized data scrapers, custom code analysis hooks, or interactive testing workflows).
- **Format:** Each skill should reside in its own folder or file (e.g. `ai/skills/my-skill/SKILL.md` or `ai/skills/my-skill.md`).
- **Rule:** Universal skills belong here so they are version-controlled and shared across the team. IDE-specific rules (like `.cursor/` or `.agents/`) must simply link back to files in `ai/skills/` to prevent duplication (SSOT).
- **Template:** [file-templates/ai/skills/example-skill.md](../../file-templates/ai/skills/example-skill.md)

