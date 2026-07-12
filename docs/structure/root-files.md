[Home (README)](../../README.md) | [Next: 🤖 AI Agent Rules & Workflows →](ai-agents.md)

---

# Root Directory Files

Files located directly in the root of the repository act as entry points and project-wide metadata.

---

## AGENTS.md

The most important entry point for AI agents. 

- **Role:** Purely an entry point containing links to high-level context, rules, and workflows.
- **Rule:** Must **never** contain inline business requirements, tech-stack details, code snippets, or rules. It only points to where this information is located in the repository.
- **Template:** [templates/AGENTS.md](../../templates/AGENTS.md)

---

## MANIFEST.md

The map of the entire repository.

- **Role:** A flat index listing directories and files that *currently exist* in the workspace.
- **Benefit:** Prevents AI agents from searching the filesystem blindly (reduces context consumption and runtime cost).
- **Rule:** Contains only paths and links — no textual descriptions or summaries.
- **Template:** [templates/MANIFEST.md](../../templates/MANIFEST.md)

---

## README.md

The human-centric entry point of the project.

- **Role:** Brief project description, installation instructions, execution steps, and references to documentation.
- **Rule:** Must not replace proper documentation; keeps it short and points to `docs/` and `AGENTS.md`.
- **Template:** [templates/README.md](../../templates/README.md)

---

## CHANGELOG.md

Version history.

- **Role:** Keeps track of changes made in each released version.
- **Template:** [templates/CHANGELOG.md](../../templates/CHANGELOG.md)

---

## ROADMAP.md

Development plan.

- **Role:** Outlines what features are planned for "Now", "Next", and "Later".
- **Template:** [templates/ROADMAP.md](../../templates/ROADMAP.md)

---

## tasks.md & tasks/

The single source of truth for the active task queue.

- **Role:** `tasks.md` serves as the index and convention reference for active tasks. The `tasks/` directory contains individual task files (e.g. `task-001-example.md`).
- **Rule:** Current tasks, bugs, and documentation changes must be tracked here, not in `ai/memory/` (which is strictly for historical lessons).
- **Completed Task Lifecycle Rule:** When a task is completed, you must do more than just change its status to `done` in the frontmatter. The developer or agent **must** append a `## Verification` or `## Walkthrough` section directly to the bottom of that specific task file (`tasks/task-NNN-description.md`), detailing the changes made, verification results, and any test logs. This turns the task file into a permanent, self-contained record of execution (Task as SSOT).
- **Template:** [templates/tasks/task-001-example.md](../../templates/tasks/task-001-example.md)


---

## LICENSE

The project license.

- **Role:** Standard unmodified text of the chosen open-source or commercial license.

---

## .gitignore

Controls file exclusion.

- **Role:** Specifies what build artifacts, hidden IDE logs, environment secrets (`.env`), and temporary directories (`tmp/`) are ignored.
- **Rule:** The `tmp/` exclusion must be mirrored in CI/CD configurations.
- **Template:** [templates/.gitignore](../../templates/.gitignore)

---

## .github/

GitHub-specific automation configuration.

- **Role:** CI/CD workflows (GitHub Actions) and pull request / issue templates.
- **Rule:** Workflows must not contain raw business or architecture explanations; refer to scripts in `scripts/` or rules in `ai/workflows/`.

---
[Home (README)](../../README.md) | [Next: 🤖 AI Agent Rules & Workflows →](ai-agents.md)

