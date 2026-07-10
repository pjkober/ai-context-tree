[← Previous: 📖 Philosophy](01-philosophy.md) | [Home (README)](../README.md) | [Next: 🌱 Incremental Growth →](03-incremental-growth.md)

---

# The 5 Core Principles

The entire structure is built upon five foundational principles. Following these principles ensures optimal efficiency for both humans and AI agents.

---

## 1. Single Source of Truth (SSOT)

Each piece of information exists in only one place. Duplicating architecture descriptions, requirements, or code rules across multiple files (like having them in both `README.md`, `.cursorrules`, and a `/docs` directory) leads to stale documentation and context pollution.

- **Bad:** Repeating the system architecture in `README.md`, `AGENTS.md`, and `docs/architecture.md`.
- **Good:** Defining the architecture in `docs/architecture.md` and having all other entry files link to it.

---

## 2. AI Should Not Guess

If a project has naming conventions, architectural design patterns, specific coding style requirements, or workflows, they must be explicitly documented in the `ai/` directory. If a rule is not written down, the AI will make assumptions based on its training data, which often results in inconsistencies and bugs.

---

## 3. Small Files (Single Responsibility)

LLMs perform significantly better when dealing with small, modular contexts.
- Keep files between **100–300 lines** whenever possible.
- Maintain **one responsibility per file**.
- Keep directory sizes small and focused.

---

## 4. Documentation Close to Code

Separate the implementation from the rationale.
- **Code** describes the *how* (the implementation details).
- **Documentation** (in `docs/`, `specs/`, or `decisions/`) describes the *why*, *when*, and *what*.

---

## 5. Repository Must Be IDE-Independent

We must not rewrite our project documentation or conventions when we switch between AI tools. 
Configuration files for specific AI clients (e.g., `.cursor/rules/main.mdc`, `CLAUDE.md`, `.clinerules`, `.roo/rules.md`) must act as **thin pointers** containing at most 2–3 lines redirecting the model to [AGENTS.md](../AGENTS.md) in the project root. They must never contain inline rules, tech-stack descriptions, or code snippets.

---
[← Previous: 📖 Philosophy](01-philosophy.md) | [Home (README)](../README.md) | [Next: 🌱 Incremental Growth →](03-incremental-growth.md)

