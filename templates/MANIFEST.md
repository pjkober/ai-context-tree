# Project Structure Map
# This file is a living index. Update it as new directories and files are added to the project.

├── [.agents/context/](.agents/context/)           # Project goals, tech stack, and directory structure map (read by AI first)
├── [.agents/history/](.agents/history/)           # Conversation memory logs (conver-NNN-desc.md)
├── [.agents/lessons/](.agents/lessons/)           # Extracted post-mortems, lessons learned, and known issues
├── [.agents/rules/](.agents/rules/)               # Coding, testing, security, and git conventions for the AI agent
├── [.agents/runs/](.agents/runs/)                 # Reusable automation script logs (run-NNN-desc.sh/.ps1)
├── [.agents/skills/](.agents/skills/)             # Project-specific agent skills and reusable prompt templates
├── [.agents/workflows/](.agents/workflows/)       # Step-by-step procedures for recurring tasks (e.g. new feature, bugfix)
├── [config/](config/)                   # Centralized tool and environment configurations
├── [contracts/](contracts/)             # API contracts (OpenAPI, Protobuf, GraphQL schemas)
├── [decisions/](decisions/)             # Architecture Decision Records (ADRs)
├── [docs/](docs/)                       # System and technical architecture documentation
├── [templates/](templates/)             # Templates and blueprints for future project scaffolding
├── [knowledge/](knowledge/)             # Domain knowledge base (terminology, FAQ, personas, guides)
├── [scripts/](scripts/)                 # Build, seed, and automation scripts
├── [specs/](specs/)                     # Business requirements, user stories, and acceptance criteria
├── [src/](src/)                         # Application source code
├── [tests/](tests/)                     # Test suites (unit, integration, e2e)
└── [tmp/](tmp/)                         # Temporary files and scratch space (excluded from git/CI)
