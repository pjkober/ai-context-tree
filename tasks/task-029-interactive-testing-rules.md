---
id: task-029
tags:
  - tasks
status: todo
priority: high
type: feature
owner: Antigravity
created: 2026-07-07
updated: 2026-07-07
depends_on: []
---

# Task-029: Add Interactive Testing Strategy Questions to Config Scripts

**Location:**
- `create_minimal_structure.sh`
- `create_minimal_structure.ps1`
- `file-templates/ai/rules/testing.md` (New template)
- `docs/structure/ai-agents.md`

**Description:**
Add a new category of questions to the setup scripts to define the AI's testing rules:
1. **Testing Coverage:**
   - 1) None (Skip tests for maximum development speed)
   - 2) Critical Path only (Write tests only for key logic/critical paths) [Default]
   - 3) Full Coverage (Feature is only complete when fully covered and all tests pass)
2. **Testing Approach:**
   - 1) TDD / Test-First (Write tests before implementation)
   - 2) Write-After / Post-Implementation (Write tests after implementation) [Default]
3. **Test Execution Scope:**
   - 1) Unit Tests (Run only single unit tests related to changed code) [Default]
   - 2) Module / Integration Tests (Run unit and integration tests for the module)
   - 3) Full Suite (Run the entire test suite on every change)

Generate `ai/rules/testing.md` from a new template `file-templates/ai/rules/testing.md` with these choices. Arrange all questions in setup scripts in a logical category order:
1. Autonomy & Decisions
2. Coding & Refactoring
3. Testing Strategy
4. Tech Stack

**Justification:**
Ensures that the AI has clear boundaries regarding when to write tests, how to write them (TDD or not), and how/when to run them, preventing testing-related disagreements or unnecessary execution loops.
