# Project Structure Map
# This file is a living index. Update it as new directories and files are added to the project.

├── [ai/context/](ai/context/)           # Project goals, tech stack, and directory structure map (read by AI first)
├── [ai/rules/](ai/rules/)               # Coding, testing, security, and git conventions for the AI agent
├── [ai/workflows/](ai/workflows/)       # Step-by-step procedures for recurring tasks (e.g. new feature, bugfix)
├── [ai/skills/](ai/skills/)             # Project-specific agent skills and reusable prompt templates
├── [ai/history/](ai/history/)           # Conversation memory logs (conver-NNN-desc.md)
├── [ai/runs/](ai/runs/)                 # Reusable automation script logs (run-NNN-desc.sh/.ps1)
├── [docs/](docs/)                       # System and technical architecture documentation
├── [knowledge/](knowledge/)             # Domain knowledge base (terminology, FAQ, personas, guides)
├── [specs/](specs/)                     # Business requirements, user stories, and acceptance criteria
├── [contracts/](contracts/)             # API contracts (OpenAPI, Protobuf, GraphQL schemas)
├── [decisions/](decisions/)             # Architecture Decision Records (ADRs)
├── [src/](src/)                         # Application source code
├── [tests/](tests/)                     # Test suites (unit, integration, e2e)
├── [scripts/](scripts/)                 # Build, seed, and automation scripts
├── [config/](config/)                   # Centralized tool and environment configurations
└── [tmp/](tmp/)                         # Temporary files and scratch space (excluded from git/CI)
