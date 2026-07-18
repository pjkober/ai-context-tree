# Examples

This directory contains real-world application structures and skeletons illustrating the implementation of the `ai-context-tree` standard.

## Directory Contents

- [minimal-nodejs-api/](minimal-nodejs-api/) — A synthetic skeleton of a Node.js REST API using Express and TypeScript. It includes realistic file locations, rules, spec flows, and task files.

## How to Read the Examples

To understand how an AI agent interacts with a project structured under this standard, follow this reading sequence:

1. **Read [AGENTS.md](minimal-nodejs-api/AGENTS.md) first:** This is the entry point that guides the agent.
2. **Examine context and rules:** Check `ai/context/project.md` and `ai/rules/coding.md` to see how the stack and styling are defined.
3. **Follow the task flow:**
   - Look at the active task in `tasks/task-001-implement-login-endpoint.md`.
   - Read the spec file it references in `specs/user-login/requirements.md`.
   - Trace how the walkthrough/verification section is appended to the bottom of the task file upon completion.

## How to Use as a Template

Do not copy the example project directly. Instead:
1. Initialize a clean repository.
2. Run the `create_minimal_structure.sh` initialization wizard.
3. Use the templates in `templates/` and look at these examples to see how to populate requirements, ADRs, or rules.
