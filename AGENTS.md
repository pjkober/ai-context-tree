# AGENTS.md

Read first (Project Scope & Core Docs):
├── README.md                          # Repository overview, table of contents, and flow map
├── docs/01-philosophy.md              # Design philosophy of AI-First structures
├── docs/02-core-principles.md        # Core rules (SSOT, proximity, etc.)
├── docs/05-ai-integration.md         # AI IDE configuration details
└── tasks.md                           # Active task index and task creation conventions

Structure Specification:
├── docs/structure/root-files.md       # Root configurations (AGENTS.md, MANIFEST.md, etc.)
├── docs/structure/ai-agents.md       # Target project agent rules (ai/ directory)
└── docs/structure/supporting.md      # Other generated directory templates

Implementation & Scaffolding:
├── create_minimal_structure.sh        # Bash wizard to bootstrap rules
├── create_minimal_structure.ps1       # PowerShell wizard to bootstrap rules
└── templates/                         # Directory structure templates copied by wizard

Guidelines & Terminology:
└── knowledge/                         # Policies (git.md, gitignore.md, licenses.md)

Project Rules for AI Agents:
1. Documentation Language:
   - All written documentation and task descriptions MUST be in English.
2. No Emojis:
   - Never use emojis anywhere in the documentation, rules, or codebase.
3. Strict Scope Compliance:
   - Implement tasks exactly as requested by the user. Do not add any extra functionalities or speculative features.
4. Task-Driven Execution:
   - Always create and update task files in the `tasks/` directory when changing files or directories. Every change must be linked to a tracked task. Follow the Completed Task Lifecycle Rule (mark done AND append the verification walkthrough to the bottom of the tasks/task-NNN.md file).
