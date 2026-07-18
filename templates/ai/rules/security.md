# Security & Autonomy Guidelines

Always act as a **Senior Software Engineer and AI Expert**, implementing robust, production-grade patterns.

## General Security Rules
- Never expose API keys, passwords, or secrets in code or commits.
- Copy `.env.example` to create local `.env` and load all credentials from environment variables.
- Ensure all temporary logs and debug outputs are stored in `tmp/` and excluded from Git.

## Autonomy Mode
<!-- AUTONOMY_MODE: Define the AI agent's allowed level of autonomy.
     Options:
     - "Full Autonomy: The agent can run setup and installation commands freely."
     - "Semi-Autonomous: The agent must ask for permission before running critical commands."
     Example: "Semi-Autonomous: The agent must ask for permission before running commands that make network requests or run code." -->
__AUTONOMY_MODE__

## Dependency Policy
<!-- DEPENDENCY_POLICY: Define how dependencies should be added.
     Example: "Never install dependencies globally. Always use project-level dependency managers (npm, pip, cargo) and verify version compatibility before upgrading." -->
__DEPENDENCY_POLICY__

## Architecture & Scope Policy
<!-- ARCHITECTURE_POLICY: Define constraints on changes to the system architecture.
     Example: "Do not deviate from the layered architecture (UI, logic, data). Avoid adding new core abstractions without an approved ADR." -->
__ARCHITECTURE_POLICY__

## License Policy
<!-- LICENSE_POLICY: Define permitted software licenses.
     Example: "Ensure all newly added third-party packages use permissive licenses (MIT, Apache 2.0, BSD). Do not use GPL or copyleft dependencies." -->
__LICENSE_POLICY__

## Git & Version Control Autonomy
<!-- GIT_POLICY: Define Git usage guidelines.
     Example: "Always perform Git operations in the appropriate branch. Commits must follow the Conventional Commits specification. Rebase instead of merge where possible." -->
__GIT_POLICY__

## Safety & Destructive Actions Policy
<!-- SAFETY_POLICY: Define safety policies for destructive actions.
     Example: "Always obtain explicit user confirmation before running any destructive commands, database drops, or file deletes outside of tmp/." -->
__SAFETY_POLICY__

## Task Management & Boundaries
<!-- TASK_MANAGEMENT_POLICY: Define task boundaries and progression.
     Example: "Do not start a new task until the current one is fully completed, verified, and committed. Tasks must be tracked in the tasks/ directory." -->
__TASK_MANAGEMENT_POLICY__

## Context & Cost Control
<!-- CONTEXT_MANAGEMENT_POLICY: Define guidelines for context preservation and cost control.
     Example: "Minimize context window size by keeping lines short, deleting temporary files, and avoiding redundant reads of large directories." -->
__CONTEXT_MANAGEMENT_POLICY__

## Secrets & Security Policy
<!-- SECRETS_POLICY: Define policy for credentials and secrets.
     Example: "Never commit API keys, passwords, or credentials. Load all config from .env files, which must be listed in .gitignore." -->
__SECRETS_POLICY__
