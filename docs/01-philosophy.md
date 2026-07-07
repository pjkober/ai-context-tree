# Philosophy of AI-First Project Design

A modern software repository is no longer designed solely for human developers. It is a shared space co-inhabited by:

- Human Developers
- AI Assistants & Autocomplete Engines
- Autonomous AI Agents (e.g. Claude Code, Cline, Antigravity)
- Specialized Agents (Code Review, DevOps, Testing, Security)

## Context Management: The Primary Constraint

The primary limitation of modern Large Language Models (LLMs) is not code generation, but **Context Management**. Large files, dispersed rules, and duplicated documentation waste context tokens, lead to hallucinations, and degrade agent performance.

## The Overriding Principle of Context Access

The repository has a **single, completely shared structure** for both humans and AI agents. Both parties use the same directories and files. Every file is an equal source of information for humans and AI alike — there are no "for humans only" or "for AI only" directories.

## Core Rules for Predictability

To minimize guesswork by AI agents and optimize human readability, a project structure must satisfy the following:

1. **Predictability:** The structure should be consistent and intuitive.
2. **Single Source of Truth (SSOT):** No duplication of documentation or configuration logic.
3. **Knowledge separation:** Separate business logic and domain knowledge from technical implementation details.
4. **Tool Independence:** Facilitate switching or using multiple AI clients simultaneously without reorganizing the repository structure.

## Directory Naming & Organization Rules

- **Strict naming uniformity:** Every directory in the repository must have a single, official name. Creating aliases, abbreviations, or alternative directory names in documentation or examples is prohibited.
- **Full and unambiguous names:** Directory names must be full and unambiguous (e.g., `config/` instead of `cfg/`, `infrastructure/` instead of `infra/`). Abbreviations are forbidden.
- **One knowledge category = one directory; one topic = one file.** This prevents cross-contamination of contexts.
