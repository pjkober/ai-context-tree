[← Previous: 🛠️ Implementation Files](implementation.md) | [Home (README)](../../README.md)

---

# Supporting Directories

These directories are optional, supporting parts of the repository created incrementally as the project scales.

---

## examples/

Code usage examples.

- **Role:** Sample requests, response JSON payloads, webhook triggers, and code integration examples.
- **Benefit:** LLMs learn very well from example data (Few-Shot Learning), leading to highly accurate code generation.

---

## plans/

Design plans for large changes.

- **Role:** Epic planning docs, database migration strategies, or caching refactoring plans. Linked from `tasks.md`.
- **Template:** [templates/plans/plan-template.md](../../templates/plans/plan-template.md)

---

## prototypes/

PoC and sandbox experiments.

- **Role:** Independent directories containing sandbox research code, benchmarking scripts, and draft RAG pipelines.
- **Rule:** Kept completely separate from production `src/` to prevent LLMs from confusing experiments with production logic.
- **Template:** [templates/prototypes/prototype-template.md](../../templates/prototypes/prototype-template.md)

---

## research/

Analytical research materials.

- **Role:** Pre-development materials, including competitor reviews, market analysis, spikes, and user research interviews.
- **Rule:** Research materials are not active requirements. Findings that lead to decisions should be migrated to `specs/` or `decisions/`.

---

## archive/

Legacy code and deprecated documentation.

- **Role:** Safely stores inactive code modules or old docs that might be useful for history but should not be analyzed as active codebase elements.
- **Benefit:** Hiding legacy files here prevents AI agents from importing deprecated classes or using stale logic.

---

## assets/

Static design files.

- **Role:** Images, icons, fonts, branding documents, and design assets.

---

## tmp/
 
Temporary working directory.
 
- **Role:** A local scratchpad for automatically generated logs, temporary build artifacts, or AI tutoring cache files.
- **Rule:** Created at project start containing a `.gitkeep` file. All contents are ignored via `.gitignore` (`tmp/*`), but the directory itself is tracked. Must be excluded from CI/CD pipeline steps.

---
[← Previous: 🛠️ Implementation Files](implementation.md) | [Home (README)](../../README.md)

