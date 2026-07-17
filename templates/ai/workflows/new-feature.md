# Workflow: New Feature Implementation

Follow these steps sequentially. Do not skip steps or reorder them.

## Pre-Implementation (Plan)

1. **Read project context:** Open and read `ai/context/project.md` and `ai/context/stack.md` to understand project scope and technology constraints.

2. **Read the task:** Open the corresponding task file in `tasks/task-NNN-description.md`. Confirm you understand the goal, location, and acceptance criteria.

3. **Check the structure map:** Before creating any new directory, open `ai/context/structure-map.md` and confirm the directory you need is listed. If you need a directory not listed in the map, stop and raise a question to the developer before proceeding.

4. **Read specifications:** Open `specs/<feature>/requirements.md` if it exists. If it does not exist, create it before writing any code (Spec-Driven Development principle).

5. **Check API contracts:** If the feature involves external interfaces, open the relevant file in `contracts/`. Do not guess request/response shapes.

## Implementation

6. **Follow coding rules:** Implement according to `ai/rules/coding.md`. Keep every function under 40 lines and every file under 300 lines.

7. **Add tests first (if TDD):** If `ai/rules/testing.md` specifies TDD, write the tests in `tests/` before writing implementation code.

8. **Implement the feature:** Write the production code in `src/`. Do not add any documentation or `.md` files inside `src/`.

9. **Add or update tests:** If not using TDD, add tests in `tests/` after implementation. Follow the structure of `ai/rules/testing.md`.

## Post-Implementation (Verify and Close)

10. **Check file sizes:** Run `./scripts/check-file-sizes.sh` (if available) or manually confirm no modified file exceeds 300 lines.

11. **Update `MANIFEST.md`:** If any new directories or key files were created during this task, add them to `MANIFEST.md`.

12. **Update `CHANGELOG.md`:** Add a brief entry under `[Unreleased]` describing the change.

13. **Verify the Definition of Done:** Review `knowledge/Definition of Done.md`. Confirm all required steps have been completed (linting, tests passing, security check if applicable).

14. **Update the task file:** Change the task frontmatter `status` from `in_progress` to `done`. Append a `## Verification` section at the bottom of the task file documenting: changes made, test results, and any notable decisions.

15. **Update `tasks.md` index:** Add or update the task entry in the `tasks.md` index if required by the project convention.
