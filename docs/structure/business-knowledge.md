[Previous: AI Agent Rules and Workflows](ai-agents.md) | [Home (README)](../../README.md) | [Next: Implementation Files ->](implementation.md)

---

# Business and Knowledge Directories

These directories separate business requirements, domain knowledge, and architectural choices from the implementation code.

---

## specs/

Business specifications.

- **Role:** Describes functional requirements and acceptance criteria. Excludes implementation details.
- **Rule:** Must not contain active task checklists (those go in `tasks.md`) or field-level data schemas (those belong in `contracts/`).
- **Templates:** 
  - [templates/specs/requirements.md](../../templates/specs/requirements.md)
  - [templates/specs/acceptance.md](../../templates/specs/acceptance.md)

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

---

## knowledge/

The domain knowledge base.

- **Role:** Stores domain lexicon, FAQs, personas, edge-cases, and regulatory rules (e.g. GDPR). Organized into subdirectories: `business/`, `faq/`, `terminology/`, `edge-cases/`, `legal/`, `personas/`.
- **Rule:** One topic per file. No technical documentation is allowed here (technical docs go in `docs/`).
- **Template (terminology.md):** [templates/knowledge/terminology.md](../../templates/knowledge/terminology.md)

---

## checklists/

Verification checklists.

- **Role:** Simple, checklist-based verification lists for release, security, or testing (e.g. `release.md`).
- **Rule:** Contains only checkboxes and evaluation criteria, not procedural steps. Step-by-step instructions belong in `ai/workflows/`.
- **Template (release.md):** [templates/checklists/release.md](../../templates/checklists/release.md)

---

## decisions/

Architectural Decision Records (ADR).

- **Role:** Documents architectural decisions, rationales, alternatives, and consequences (e.g. choosing Postgres over MongoDB).
- **Benefit:** Prevents AI from guessing architecture choices and rewriting working structures.
- **Template:** [templates/decisions/001-example-adr.md](../../templates/decisions/001-example-adr.md)

---

## contracts/

Formal data structure specifications.

- **Role:** API definitions, data schemas, and interface descriptions (OpenAPI, GraphQL, Protobuf, JSON Schema).
- **Benefit:** Provides a strict boundary, preventing AI from guessing API request/response properties.
- **Template:** [templates/contracts/openapi.yaml](../../templates/contracts/openapi.yaml)

---

## docs/

System technical and architectural documentation.

- **Role:** High-level guides on how code modules interact, deployment flows, database schemas, and developer setup.
- **Rule:** Focuses on the *why* and *how* of the codebase. Code examples, templates, and configurations belong in `examples/`, `ai/templates/`, or `config/`.
- **Template (module-architecture.md):** [templates/docs/architecture/module-architecture.md](../../templates/docs/architecture/module-architecture.md)
- **Template (onboarding.md):** [templates/docs/onboarding.md](../../templates/docs/onboarding.md)

---
[Previous: AI Agent Rules and Workflows](ai-agents.md) | [Home (README)](../../README.md) | [Next: Implementation Files ->](implementation.md)

