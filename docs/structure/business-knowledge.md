[← Previous: 🤖 AI Agent Rules & Workflows](ai-agents.md) | [Home (README)](../../README.md) | [Next: 🛠️ Implementation Files →](implementation.md)

---

# Business and Knowledge Directories

These directories separate business requirements, domain knowledge, and architectural choices from the implementation code.

---

## specs/

Business specifications.

- **Role:** Describes functional requirements and acceptance criteria. Excludes implementation details.
- **Rule:** Must not contain active task checklists (those go in `task.md`) or field-level data schemas (those belong in `contracts/`).
- **Templates:** 
  - [file-templates/specs/requirements.md](../../file-templates/specs/requirements.md)
  - [file-templates/specs/acceptance.md](../../file-templates/specs/acceptance.md)

---

## knowledge/

The domain knowledge base.

- **Role:** Stores domain lexicon, FAQs, personas, edge-cases, and regulatory rules (e.g. GDPR). Organized into subdirectories: `business/`, `faq/`, `terminology/`, `edge-cases/`, `legal/`, `personas/`.
- **Rule:** One topic per file. No technical documentation is allowed here (technical docs go in `docs/`).
- **Template (terminology.md):** [file-templates/knowledge/terminology.md](../../file-templates/knowledge/terminology.md)

---

## checklists/

Verification checklists.

- **Role:** Simple, checklist-based verification lists for release, security, or testing (e.g. `release.md`).
- **Rule:** Contains only checkboxes and evaluation criteria, not procedural steps. Step-by-step instructions belong in `ai/workflows/`.
- **Template (release.md):** [file-templates/checklists/release.md](../../file-templates/checklists/release.md)

---

## decisions/

Architectural Decision Records (ADR).

- **Role:** Documents architectural decisions, rationales, alternatives, and consequences (e.g. choosing Postgres over MongoDB).
- **Benefit:** Prevents AI from guessing architecture choices and rewriting working structures.
- **Template:** [file-templates/decisions/001-example-adr.md](../../file-templates/decisions/001-example-adr.md)

---

## contracts/

Formal data structure specifications.

- **Role:** API definitions, data schemas, and interface descriptions (OpenAPI, GraphQL, Protobuf, JSON Schema).
- **Benefit:** Provides a strict boundary, preventing AI from guessing API request/response properties.
- **Template:** [file-templates/contracts/openapi.yaml](../../file-templates/contracts/openapi.yaml)

---

## docs/

System technical and architectural documentation.

- **Role:** High-level guides on how code modules interact, deployment flows, database schemas, and developer setup.
- **Rule:** Focuses on the *why* and *how* of the codebase. Code examples, templates, and configurations belong in `examples/`, `ai/templates/`, or `config/`.
- **Template (module-architecture.md):** [file-templates/docs/architecture/module-architecture.md](../../file-templates/docs/architecture/module-architecture.md)

---
[← Previous: 🤖 AI Agent Rules & Workflows](ai-agents.md) | [Home (README)](../../README.md) | [Next: 🛠️ Implementation Files →](implementation.md)

