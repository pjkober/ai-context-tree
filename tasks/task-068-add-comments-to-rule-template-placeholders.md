---
id: task-068
tags:
  - tasks
status: done
priority: medium
type: docs
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on:
  - task-063
---

# Task-068: Add Instructive Comments to Rule Template Placeholders

## Source
Report section 4.6 (MEDIUM).

## Location
- `templates/ai/rules/coding.md` (after rename from `templates/`, see task-063)
- `templates/ai/rules/security.md`
- `templates/ai/rules/testing.md`

## Description

The three rule templates (`coding.md`, `security.md`, `testing.md`) contain `__PLACEHOLDER__` tokens that the bootstrap script replaces during setup. However, when a developer creates these files manually (without running the wizard), the placeholders are meaningless -- there is no inline guidance on what valid content looks like.

Additionally, if the script fails mid-run or a developer inherits a project without the setup wizard, they are left with raw placeholder strings like `__TECH_STACK__` in their rules files with no indication of what to write.

## What to Do

For each placeholder in each file, add an HTML comment block immediately above it that:
1. Explains what the placeholder represents.
2. Gives a short example of valid content.

### `coding.md` placeholders:

**`__REFACTORING_POLICY__`** -- replace with comment:
```markdown
<!-- REFACTORING_POLICY: Define the agent's refactoring scope.
     Options:
     - "Strict Scope: Modify only the lines directly required by the task."
     - "Boy Scout Rule: Fix minor code smells in files already being touched."
     Example: "Strict Scope: Do not refactor or rename symbols outside the direct task scope." -->
__REFACTORING_POLICY__
```

**`__TECH_STACK__`** -- replace with comment:
```markdown
<!-- TECH_STACK: List the languages and frameworks used, with key conventions.
     Example:
     - Language: TypeScript (strict mode)
     - Runtime: Node.js 20+
     - Framework: Express 5
     - Style: ESLint + Prettier, tabs, double quotes -->
__TECH_STACK__
```

**`__COMMUNICATION_POLICY__`** -- replace with comment:
```markdown
<!-- COMMUNICATION_POLICY: Define how the agent should communicate its work.
     Options:
     - "Brief: Summarize changes in 3-5 bullet points."
     - "Detailed: Explain every decision with rationale."
     Example: "Brief: Summarize only what changed and why. No step-by-step narration." -->
__COMMUNICATION_POLICY__
```

**`__LINTING_POLICY__`** -- replace with comment:
```markdown
<!-- LINTING_POLICY: Define linting behavior.
     Options:
     - "Auto-fix: Run linter with --fix before committing."
     - "Report-only: Run linter but do not auto-fix."
     Example: "Auto-fix: Run `npm run lint --fix` after every code change." -->
__LINTING_POLICY__
```

### `security.md` -- add comments above each of its 9 placeholders following the same pattern.

### `testing.md` -- add comments above each of its 3 placeholders following the same pattern.

## Verification

- Every `__PLACEHOLDER__` token in all three files has an HTML comment block above it.
- The comments provide a clear example of valid replacement content.
- The bootstrap script still works correctly (the comment lines are not affected by placeholder replacement):
  ```bash
  bash -n create_minimal_structure.sh
  ```

### Walkthrough of Changes
1. Added detailed, descriptive HTML comments explaining the expected values and providing examples above all 4 placeholders in `templates/ai/rules/coding.md`.
2. Added detailed, descriptive HTML comments explaining the expected values and providing examples above all 9 placeholders in `templates/ai/rules/security.md`.
3. Added detailed, descriptive HTML comments explaining the expected values and providing examples above all 3 placeholders in `templates/ai/rules/testing.md`.
4. Verified that the `create_minimal_structure.sh` script is syntactically correct (`bash -n` exited with 0).
5. Staged and committed changes.
