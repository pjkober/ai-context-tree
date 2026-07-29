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

- **Rule:** Current tasks, bugs, and documentation changes must be tracked here, not in `ai/lessons/` (which is strictly for historical lessons).
- **Completed Task Lifecycle Rule:** When a task is completed, you must do more than just change its status to `done` in the frontmatter. The developer or agent **must** append a `## Verification` or `## Walkthrough` section directly to the bottom of that specific task file (`tasks/task-NNN-description.md`), detailing the changes made, verification results, and any test logs. This turns the task file into a permanent, self-contained record of execution (Task as SSOT).
- **Template:** [templates/tasks/task-001-example.md](../../templates/tasks/task-001-example.md)


---

[Home (README)](../../README.md) | [Next: AI Agent Rules and Workflows ->](ai-agents.md)

