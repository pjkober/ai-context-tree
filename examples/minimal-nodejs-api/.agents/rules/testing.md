# Testing Requirements

Our goal is code reliability and correctness. Follow these testing rules.

## Core Rules

- **Coverage Target:** Maintain 100% test coverage for the critical path (user signup, login, password comparison). Overall code coverage must exceed 90%.
- **Test Locations:** Keep tests in the `tests/` directory. Mimic the file tree structure of `src/` inside `tests/` (e.g. `src/controllers/auth.ts` -> `tests/controllers/auth.test.ts`).
- **TDD:** Write unit and integration tests before implementing changes when executing feature tasks.
- **Verification:** Execute `npm test` before committing to confirm that all tests pass successfully.
