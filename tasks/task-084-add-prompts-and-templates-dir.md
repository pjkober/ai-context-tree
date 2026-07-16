---
id: task-084
tags:
  - tasks
status: todo
priority: medium
type: docs
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on:
  - task-063
---

# Task-084: Add Templates for `ai/prompts/` and `ai/templates/`

## Source
Report section 6.8 (Improvement).

## Location
- `templates/ai/prompts/` (new directory with example files)
- `templates/ai/templates/` (new directory with example files)
- `docs/structure/ai-agents.md` -- update `ai/prompts/` and `ai/templates/` sections with template links

## Description

`docs/structure/ai-agents.md` describes both `ai/prompts/` and `ai/templates/` in detail, with role definitions and rules. However, neither directory has any corresponding templates in `templates/ai/`. This creates a gap between documented structure and scaffolded reality: a developer following the documentation expects template files to exist, but they do not.

## What to Do

### Create `templates/ai/prompts/review.md`

```markdown
# Prompt: Code Review

Use this prompt to ask your AI assistant to perform a structured code review of recently changed files.

---

Review the following files that were changed in this task: [list file paths].

Apply all rules from `ai/rules/coding.md` and `ai/rules/security.md`.

For each file, report:
1. Any violations of the coding standards.
2. Any security concerns (hardcoded secrets, SQL injection risks, missing input validation).
3. Any functions exceeding 40 lines that should be split.
4. Any missing or insufficient test coverage for the changed logic.

Output a bullet list of findings, grouped by file. If there are no findings, state "No issues found."
```

### Create `templates/ai/prompts/debug.md`

```markdown
# Prompt: Debug Failing Test

Use this prompt when a test is failing and the cause is unclear.

---

The following test is failing: [test name and file path].

Error output:
```
[paste error message here]
```

1. Identify the root cause of the failure.
2. Do NOT modify the test unless it is provably incorrect.
3. Propose a minimal fix to the production code.
4. Explain your reasoning before making any changes.
```

### Create `templates/ai/templates/service/typescript.md`

```markdown
# Code Template: Service (TypeScript)

Use this template when creating a new service class in `src/services/`.

```typescript
// src/services/[name].service.ts

export class [Name]Service {
  constructor(
    private readonly [dependency]: [DependencyType]
  ) {}

  async [methodName]([params]: [ParamType]): Promise<[ReturnType]> {
    // Implementation
  }
}
```

**Naming convention:** `[name].service.ts`, class name `[Name]Service`.
**Rule:** Keep the class under 40 lines per method and under 300 lines total.
**Location:** `src/services/[name].service.ts`
**Test location:** `tests/unit/services/[name].service.test.ts`
```

### Update `docs/structure/ai-agents.md`

In the `ai/prompts/` section, add:
```markdown
- **Template (review.md):** [templates/ai/prompts/review.md](../../templates/ai/prompts/review.md)
- **Template (debug.md):** [templates/ai/prompts/debug.md](../../templates/ai/prompts/debug.md)
```

In the `ai/templates/` section, add:
```markdown
- **Template (service/typescript.md):** [templates/ai/templates/service/typescript.md](../../templates/ai/templates/service/typescript.md)
```

## Verification

- `templates/ai/prompts/review.md` exists with a usable prompt structure.
- `templates/ai/prompts/debug.md` exists with a usable prompt structure.
- `templates/ai/templates/service/typescript.md` exists.
- `docs/structure/ai-agents.md` contains template links for all three new files.
