# Developer Onboarding Guide

Welcome to this project. This guide explains how the project is structured and how to work effectively with AI coding assistants.

---

## How AI Agents Are Configured

This project uses the `ai-context-tree` standard. All AI coding assistants (Claude Code, Cursor, Cline, Windsurf, etc.) are configured to read the same central file:

- **`AGENTS.md`** -- The entry point for all AI agents. Read this first.

IDE-specific config files (`.cursorrules`, `CLAUDE.md`, etc.) contain only 2-3 lines pointing to `AGENTS.md`. Do not add rules or conventions to those files.

---

## What to Read First (Recommended Order)

1. `AGENTS.md` -- Project rules and entry points (5 minutes)
2. `ai/context/project.md` -- What this project does and its tech stack (5 minutes)
3. `ai/context/structure-map.md` -- Official directory catalog (2 minutes)
4. `ai/rules/coding.md` -- Coding conventions your AI agent will follow (5 minutes)
5. `tasks.md` -- Active task queue and conventions (5 minutes)

---

## How to Create a Task

All work is tracked via task files in `tasks/`. Before starting any code change:

1. Create a new file: `tasks/task-NNN-short-description.md` (use the next available number).
2. Copy the template from `templates/tasks/task-001-example.md`.
3. Fill in the YAML frontmatter (id, status, priority, type, owner, created, depends_on).
4. Write a clear description, location of change, and verification steps.
5. After completing the task: set `status: done` and append a `## Verification` section.

---

## How to Work with AI Agents

- Always start a session by telling the agent to read `AGENTS.md`.
- If the agent suggests creating a new directory, ask it to check `ai/context/structure-map.md` first.
- Conversation summaries and key decisions can be saved in `ai/history/`.
- Reusable automation scripts generated during a session can be saved in `ai/runs/`.

---

## Project-Specific Notes

[Add project-specific notes here: deployment commands, local setup steps, key contacts, etc.]
