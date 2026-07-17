# Workflow: New Feature Implementation

Follow these steps sequentially:

1. **Read Context:** Open `ai/context/project.md` and `ai/context/stack.md` to review objectives and constraints.
2. **Review task:** Open `tasks/task-NNN-description.md` to understand requirements and DoD.
3. **Read spec:** Read `specs/<feature>/requirements.md` and `specs/<feature>/acceptance.md`.
4. **Implement:** Write unit tests first in `tests/`, then write production code in `src/`.
5. **Verify:** Run linter and tests. Ensure files modified remain under 300 lines.
6. **Update indices:** Add new directories/files to `MANIFEST.md` and version changes to `CHANGELOG.md`.
7. **Complete task:** Change task status to `done` in frontmatter and append the verification walkthrough to the bottom of the task file.
