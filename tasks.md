# Tasks

This file is the index and convention reference for the `tasks/` directory.
Individual tasks are stored as separate Markdown files in `tasks/`.

---

## Convention

### File Location

All task files are placed in the `tasks/` directory at the project root.
Do not place task content directly in this file.

### File Naming

```
task-NNN-short-description.md
```

- `NNN` — zero-padded sequential number (e.g., `001`, `012`)
- `short-description` — lowercase, words separated by hyphens, no special characters
- No backticks, colons, slashes, or other characters invalid in file names

**Examples:**

```
task-001-duplicate-knowledge-section.md
task-002-agents-md-template-contradicts-scope-rule.md
task-011-document-contradicts-no-preset-levels-principle.md
```

### Frontmatter Schema

Every task file must begin with a YAML frontmatter block:

```yaml
---
id: task-NNN
tags:
  - tasks
status: todo          # todo | in_progress | blocked | review | done | cancelled
priority: medium      # low | medium | high | critical
type: docs            # docs | bug | feature | refactor | chore
owner: <name>
created: YYYY-MM-DD
updated: YYYY-MM-DD
depends_on:
  - task-NNN          # list of blocking task IDs, or [] if none
---
```

### Status Values

| Status | Meaning |
|---|---|
| `todo` | Task is waiting to be started |
| `in_progress` | Currently being worked on (WIP) |
| `blocked` | Blocked by another task or external problem |
| `review` | Complete, awaiting review |
| `done` | Completed and accepted |
| `cancelled` | Deliberately cancelled, will not be implemented |

### Priority Values

| Priority | Meaning |
|---|---|
| `low` | Nice to have, no urgency |
| `medium` | Should be done in the current cycle |
| `high` | Important, do soon |
| `critical` | Must be resolved immediately — blocks other work |

### Type Values

| Type | Meaning |
|---|---|
| `docs` | Documentation change |
| `bug` | Something is broken or incorrect |
| `feature` | New functionality |
| `refactor` | Code or structure improvement without behavior change |
| `chore` | Maintenance, tooling, or housekeeping |

---

## Completed Task Lifecycle Rule

After completing a task, the agent must:
1. Set `status: done` in the task frontmatter.
2. Append a `## Verification` section at the bottom of the task file documenting changes made, test results, and decisions.
3. Add or update the task entry in the index below.

---

## Task Index

To search for tasks by status: `grep -l "status: todo" tasks/*.md`

- [task-058](tasks/task-058-add-file-templates-to-manifest.md) — Add templates/ to MANIFEST.md and handle dynamic cleanup removal (done)
- [task-059](tasks/task-059-multi-select-tech-stack-and-input-validation.md) — Multi-select Tech Stack and CLI input validation (done)
- [task-060](tasks/task-060-update-root-agents-md.md) — Update root AGENTS.md (done)
- [task-061](tasks/task-061-rename-file-templates-to-templates.md) — Rename templates to templates (done)
- [task-062](tasks/task-062-proofread-english-text-for-consistency-and-clarity.md) — Proofread English text for consistency and clarity (done)
- [task-063](tasks/task-063-rename-file-templates-to-templates.md) — [CRITICAL] Rename `file-templates/` directory to `templates/` (done)
- [task-064](tasks/task-064-remove-duplicate-mermaid-diagram.md) — [HIGH] Remove duplicate Mermaid diagram from README.md (SSOT violation) (todo)
- [task-065](tasks/task-065-fix-incomplete-task-index.md) — [HIGH] Fix incomplete task index in tasks.md (todo)
- [task-066](tasks/task-066-remove-emoji-from-docs-navigation.md) — [MEDIUM] Remove remaining emoji from navigation breadcrumbs in docs/ (todo)
- [task-067](tasks/task-067-fix-broken-wiki-link-gitignore.md) — [MEDIUM] Fix broken Obsidian wiki-link in knowledge/gitignore.md (todo)
- [task-068](tasks/task-068-add-comments-to-rule-template-placeholders.md) — [MEDIUM] Add instructive comments to rule template placeholders (todo)
- [task-069](tasks/task-069-cleanup-tmp-directory.md) — [MEDIUM] Clean up tmp/ directory leftover test artifacts (todo)
- [task-070](tasks/task-070-add-missing-ai-context-templates.md) — [LOW] Add missing ai/context/ companion templates (stack, modules, glossary) (todo)
- [task-071](tasks/task-071-document-manifest-update-trigger-rule.md) — Document MANIFEST.md update trigger rule (todo)
- [task-072](tasks/task-072-clarify-history-vs-memory-distinction.md) — Clarify distinction between ai/history/ and ai/memory/ directories (todo)
- [task-073](tasks/task-073-define-plans-vs-specs-boundary.md) — Define clear boundary between plans/ and specs/ directories (todo)
- [task-074](tasks/task-074-add-file-size-enforcement-mechanism.md) — Add file size rule enforcement mechanism and check script (todo)
- [task-075](tasks/task-075-document-manifest-multi-agent-conflict-strategy.md) — Document MANIFEST.md conflict resolution for multi-agent scenarios (todo)
- [task-076](tasks/task-076-add-runs-script-lifecycle-metadata.md) — Add lifecycle metadata convention for ai/runs/ scripts (todo)
- [task-077](tasks/task-077-create-project-changelog.md) — Create populated CHANGELOG.md for the project itself (todo)
- [task-078](tasks/task-078-create-contributing-md.md) — Create CONTRIBUTING.md for community contribution guidance (todo)
- [task-079](tasks/task-079-create-real-world-example-project.md) — Create a real-world example project in examples/ directory (todo)
- [task-080](tasks/task-080-add-cicd-pipeline.md) — Add CI/CD GitHub Actions pipeline with lint, emoji, and YAML checks (todo)
- [task-081](tasks/task-081-add-specific-tags-to-knowledge-files.md) — Add specific semantic tags to all knowledge files (todo)
- [task-082](tasks/task-082-expand-new-feature-workflow.md) — Expand new-feature.md workflow template to 15 comprehensive steps (todo)
- [task-083](tasks/task-083-add-bugfix-and-release-workflows.md) — Add bugfix.md and release.md workflow templates (todo)
- [task-084](tasks/task-084-add-prompts-and-templates-dir.md) — Add templates for ai/prompts/ and ai/templates/ directories (todo)
- [task-085](tasks/task-085-add-semantic-versioning.md) — Add semantic versioning (VERSION file) to the standard (todo)
- [task-086](tasks/task-086-add-precommit-hook-guidance.md) — Add pre-commit hook guidance to knowledge/git.md (todo)
- [task-087](tasks/task-087-create-onboarding-template.md) — Create team onboarding template at templates/docs/onboarding.md (todo)
- [task-088](tasks/task-088-create-multi-agent-coordination-guide.md) — Create multi-agent coordination guidelines document (todo)
- [task-089](tasks/task-089-create-rollback-workflow.md) — Create rollback.md workflow template for agent mistake recovery (todo)
- [task-090](tasks/task-090-add-bootstrap-integration-tests.md) — Add integration tests for bootstrap scripts (todo)
- [task-091](tasks/task-091-create-security-md.md) — Create SECURITY.md at the project root (todo)
- [task-092](tasks/task-092-update-tasks-index-with-analysis-tasks.md) — Update tasks.md index with all 30 tasks from analysis report (done)
