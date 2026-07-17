[Home (README)](../../README.md) | [Next: AI Agent Rules and Workflows ->](ai-agents.md)

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

### When to Update

Update `MANIFEST.md` immediately (in the same commit) whenever:
- A new top-level directory is created.
- A key file (e.g., `AGENTS.md`, `README.md`, contract files, major docs) is added, renamed, or deleted.
- A directory is deleted or archived.

Do NOT update `MANIFEST.md` for:
- Files inside `tmp/` (excluded from git).
- Temporary or scratch files.
- Files added during testing that will be reverted.

### Multi-Agent Conflict Strategy

When multiple AI agents work in parallel on different tasks:

1. **Atomic updates:** Each agent must update `MANIFEST.md` in the same commit as the file creation it documents. Never defer MANIFEST updates to a separate commit.

2. **Rebase preferred over merge:** When integrating a branch that modified `MANIFEST.md`, always rebase (`git rebase main`) rather than merge. This preserves a linear history and makes MANIFEST conflicts easier to resolve.

3. **Conflict resolution rule:** If two agents create conflicting MANIFEST entries:
   - Both entries are correct -- they simply need to be combined.
   - Keep both new lines from both versions.
   - Sort the combined list alphabetically by directory name.
   - Do not delete any entry from either version.

4. **Agent coordination tip:** If a project uses a task queue, assign MANIFEST ownership to a single "integration agent" whose sole responsibility is merging outputs and updating MANIFEST after each parallel batch of work.

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
- **Rule:** Current tasks, bugs, and documentation changes must be tracked here, not in `ai/lessons/` (which is strictly for historical lessons).
- **Completed Task Lifecycle Rule:** When a task is completed, you must do more than just change its status to `done` in the frontmatter. The developer or agent **must** append a `## Verification` or `## Walkthrough` section directly to the bottom of that specific task file (`tasks/task-NNN-description.md`), detailing the changes made, verification results, and any test logs. This turns the task file into a permanent, self-contained record of execution (Task as SSOT).
- **Template:** [templates/tasks/task-001-example.md](../../templates/tasks/task-001-example.md)


---

## SECURITY.md

The vulnerability reporting and security disclosure policy for the project.

- **Role:** Defines which versions are supported with security updates, how to report vulnerabilities privately, and what is within the security scope of this repository. Follows the GitHub Security Advisory standard.
- **Rule:** Must not contain inline code, architecture details, or rules for AI agents. It is a human-facing governance document.
- **When to update:** Whenever supported versions change, maintainer contact details change, or the scope of the project changes significantly.
- **Template:** [templates/SECURITY.md](../../templates/SECURITY.md)

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
[Home (README)](../../README.md) | [Next: AI Agent Rules and Workflows ->](ai-agents.md)

