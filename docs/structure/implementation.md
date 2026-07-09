[← Previous: 📘 Business Specifications & Contracts](business-knowledge.md) | [Home (README)](../../README.md) | [Next: 📂 Supporting Directories →](supporting.md)

---

# Implementation Directories

These directories contain executable code, tests, developer scripts, and environment configuration.

---

## src/

Application source code.

- **Role:** Actual production code written in the chosen language/framework.
- **Rule:** Contains *only* source code files. Textual documentation files (`.md`) are prohibited and must reside in `docs/` or `knowledge/`.

---

## tests/

The test suite.

- **Role:** Unit, integration, and end-to-end tests.
- **Rule:** Structured analogously to the `src/` directory for predictability.

---

## config/

Centralized project configuration.

- **Role:** Configuration files for toolchains, linters, and compilers (e.g. ESLint, Prettier, TypeScript, Vite, Docker, Nginx).
- **Rule:** If toolchains require configuration files to be at the root directory, place a minimal 1–5 line file there extending the configuration from `config/` (or use symlinks).
- **Template:** [file-templates/config/tsconfig-base.json](../../file-templates/config/tsconfig-base.json)

---

## scripts/

Automation and helper scripts.

- **Role:** Shell scripts or simple utility scripts for building, testing, database seeding, database migrations, or linting.
- **Template:** [file-templates/scripts/script-header.sh](../../file-templates/scripts/script-header.sh)

---

## infrastructure/

DevOps and infrastructure configuration.

- **Role:** Infrastructure-as-Code (IaC) files, including Terraform, Docker Compose, Kubernetes manifests, Helm charts, or Ansible playbooks.

---

## tools/

Local utility helpers.

- **Role:** Custom generators, parser scripts, CLI utilities, and converters built specifically to support development on the project.

---
[← Previous: 📘 Business Specifications & Contracts](business-knowledge.md) | [Home (README)](../../README.md) | [Next: 📂 Supporting Directories →](supporting.md)

