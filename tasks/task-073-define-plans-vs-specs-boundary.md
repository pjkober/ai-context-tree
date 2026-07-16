---
id: task-073
tags:
  - tasks
status: todo
priority: medium
type: docs
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on: []
---

# Task-073: Define Clear Boundary Between `plans/` and `specs/`

## Source
Report section 5.3 (Ambiguity).

## Location
- `docs/structure/business-knowledge.md` -- sections for `specs/` and `plans/`

## Description

The current documentation describes:
- `specs/` as housing "functional requirements and acceptance criteria."
- `plans/` as housing "epic planning docs, database migration strategies, or caching refactoring plans."

In practice, a feature plan frequently contains acceptance criteria, and a spec often includes implementation steps. There is no clear, memorable rule that tells a developer or AI agent which directory to use for a given document.

## What to Do

### Update `docs/structure/business-knowledge.md`

In the `specs/` section, add a decision rule block:

```markdown
### Decision Rule: specs/ vs. plans/

Use this rule to determine where a document belongs:

| Question | Answer | Use |
|---|---|---|
| Does the document describe *what the system must do* (requirements, acceptance criteria, user stories)? | Yes | `specs/` |
| Does the document describe *how the change will be executed* (steps, migration strategy, refactoring approach)? | Yes | `plans/` |
| Does the document mix both? | Yes | Split it: requirements go in `specs/`, execution steps go in `plans/`. Link between them. |

**Good examples:**
- `specs/payment-checkout/requirements.md` -- describes what checkout must do (user story, acceptance criteria).
- `specs/payment-checkout/acceptance.md` -- the test criteria for the checkout feature.
- `plans/payment-checkout-migration.md` -- describes HOW to migrate from legacy checkout to the new flow (step-by-step plan with rollback strategy).

**Bad example:**
- `specs/payment-checkout/implementation-plan.md` -- mixing requirements with implementation steps. Split this file.
```

### Add a disambiguation note to `plans/` description in the same file

```markdown
Note: `plans/` documents answer "how" (execution strategy, sequence of steps, technical approach).
`specs/` documents answer "what" (requirements, expected behavior, acceptance criteria).
Cross-link between related plan and spec files using Markdown links.
```

## Verification

- `docs/structure/business-knowledge.md` contains the decision rule table under the `specs/` or `plans/` section.
- At least two concrete "good examples" and one "bad example" are provided.
- A developer reading only this section can make the decision for a new document without consulting other files.
