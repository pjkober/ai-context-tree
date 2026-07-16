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
4. The index must be kept complete. Add every new task as a line entry when it is created.

---

## Task Index

To search for tasks by status: `grep -l "status: todo" tasks/*.md`

- [task-001](tasks/task-001-duplicate-knowledge-section.md) — Duplicate knowledge Section (done)
- [task-002](tasks/task-002-agents-md-template-contradicts-scope-rule.md) — AGENTS.md Minimal Template Contradicts Its Own Scope Rule (done)
- [task-003](tasks/task-003-research-experiments-conflicts-with-top-level-experiments.md) — research-experiments Conflicts with Top-Level experiments (done)
- [task-004](tasks/task-004-ai-templates-unresolved-design-decision.md) — ai-templates Contains an Unresolved Design Decision (done)
- [task-005](tasks/task-005-todo-md-rules-internal-contradiction.md) — TODO.md Rules Contain an Internal Contradiction (done)
- [task-006](tasks/task-006-structure-map-template-incomplete.md) — structure-map.md Minimal Template Is Incomplete (done)
- [task-007](tasks/task-007-principle-5-incomplete-rule-qualified-later.md) — Principle 5 States an Incomplete Rule Qualified 1000 Lines Later (done)
- [task-008](tasks/task-008-minimal-snapshot-omits-mandatory-files.md) — MINIMAL Snapshot Omits Files Described as Mandatory Elsewhere (done)
- [task-009](tasks/task-009-optimal-level-never-defined.md) — OPTIMAL Level Referenced Once But Never Defined (done)
- [task-010](tasks/task-010-docs-code-snippet-rule-covers-workflows.md) — docs Code Snippet Rule May Unintentionally Cover ai-workflows (done)
- [task-011](tasks/task-011-document-contradicts-no-preset-levels-principle.md) — Document Contradicts Its Own No-Preset-Levels Principle (done)
- [task-012](tasks/task-012-extract-file-templates.md) — Extract File Templates to templates/ (done)
- [task-013](tasks/task-013-create-docs-topic-files.md) — Create Docs Topic Files (done)
- [task-014](tasks/task-014-create-docs-structure-files.md) — Create Docs Structure Files (done)
- [task-015](tasks/task-015-update-root-readme.md) — Update Root README.md (done)
- [task-016](tasks/task-016-update-initialization-script.md) — Update Minimal Structure Initialization Script (done)
- [task-017](tasks/task-017-delete-large-document-and-verify.md) — Delete Old Document and Verify Relative Links (done)
- [task-018](tasks/task-018-document-local-skills-in-structure.md) — Document Local Skills in ai/skills/ and IDE Pointer Linking (done)
- [task-019](tasks/task-019-update-initialization-scripts-with-skills.md) — Update Initialization Scripts and Templates with ai/skills/ (done)
- [task-020](tasks/task-020-document-spec-driven-development.md) — Document Spec-Driven Development in knowledge/Spec-Driven Development.md (done)
- [task-021](tasks/task-021-update-readme-to-reference-sdd-and-verify.md) — Update README to Reference SDD Guide and Verify Links (done)
- [task-022](tasks/task-022-split-sdd-knowledge-into-separate-files.md) — Split Spec-Driven Development Knowledge into Separate Term Files (done)
- [task-023](tasks/task-023-update-links-and-verify.md) — Update Links in Files and Verify All Markdown References (done)
- [task-024](tasks/task-024-document-task-ssot-and-history-runs-dirs.md) — Document Task Lifecycle (Walkthrough in File) and ai/history/, ai/runs/ Directories (done)
- [task-025](tasks/task-025-update-templates-and-scripts-with-history-runs.md) — Update Templates and Scripts with ai/history/ and ai/runs/ (done)
- [task-026](tasks/task-026-update-agents-md.md) — Update Root AGENTS.md and Its Template File (done)
- [task-027](tasks/task-027-add-tmp-directory-exclusion-rule.md) — Add tmp/ directory exclusion rule and explanation (done)
- [task-028](tasks/task-028-interactive-rule-configuration.md) — Interactive Rule Configuration in Setup Scripts (done)
- [task-029](tasks/task-029-interactive-testing-rules.md) — Add Interactive Testing Strategy Questions to Config Scripts (done)
- [task-030](tasks/task-030-add-testing-terminology-files.md) — Add Testing Terminology Files to Knowledge Base (done)
- [task-031](tasks/task-031-align-readme-minimal-snapshot.md) — Align README.md Minimal Snapshot with create_minimal_structure.sh (done)
- [task-032](tasks/task-032-verify-skills-and-workflows-documentation.md) — Verify Skills and Workflows in Minimal Structure and Documentation (done)
- [task-033](tasks/task-033-add-git-knowledge-file.md) — Add Git and .gitignore Policy to Knowledge Base (done)
- [task-034](tasks/task-034-link-security-testing-rules-in-agents-md.md) — Link Security/Autonomy and Testing Rules in AGENTS.md (done)
- [task-035](tasks/task-035-implement-architecture-policy.md) — Implement Architecture & Scope Policy in creative_minimal_structure Scripts (done)
- [task-036](tasks/task-036-implement-license-policy-and-knowledge.md) — Implement Dependency License Policy and Licenses Knowledge Document (done)
- [task-037](tasks/task-037-implement-git-autonomy-policy.md) — Implement Git Autonomy Policy in creative_minimal_structure Scripts (done)
- [task-038](tasks/task-038-implement-safety-policy.md) — Implement Safety & Destructive Actions Policy in creative_minimal_structure Scripts (done)
- [task-039](tasks/task-039-document-and-verify-templates-requirement.md) — Document and Verify templates requirement (done)
- [task-040](tasks/task-040-translate-and-add-navigation.md) — Translate and Add Navigation (done)
- [task-041](tasks/task-041-add-ai-ide-selection-to-scripts.md) — Add AI IDE Selection to Initialization Scripts (done)
- [task-042](tasks/task-042-implement-communication-explanation-policy.md) — Implement Communication & Explanation Style Policy Configuration (done)
- [task-043](tasks/task-043-implement-code-quality-linting-policy.md) — Implement Code Quality & Linting Policy Configuration (done)
- [task-044](tasks/task-044-implement-task-management-boundaries-policy.md) — Implement Task Management & Boundaries Policy Configuration (done)
- [task-045](tasks/task-045-implement-context-cost-control-policy.md) — Implement Context & Cost Control Policy Configuration (done)
- [task-046](tasks/task-046-implement-secrets-security-policy.md) — Implement Secrets & Security Policy Configuration (done)
- [task-047](tasks/task-047-expand-explanations-in-bootstrap-scripts.md) — Expand Explanations in Bootstrap Scripts (done)
- [task-048](tasks/task-048-show-selection-confirmation-in-bootstrap-scripts.md) — Show Selection Confirmation in Bootstrap Scripts (done)
- [task-049](tasks/task-049-clarify-custom-ai-ide-config-option.md) — Clarify Custom AI IDE Config Option (done)
- [task-050](tasks/task-050-refactor-post-setup-cleanup.md) — Refactor Post-Setup Cleanup (done)
- [task-051](tasks/task-051-integrate-default-tmp-directory.md) — Integrate Default Tmp Directory (done)
- [task-052](tasks/task-052-add-framed-status-message.md) — Add Framed Status Message (done)
- [task-053](tasks/task-053-add-git-initialization-prompt.md) — Add Git Initialization Prompt (done)
- [task-054](tasks/task-054-fix-readme-section-2-description.md) — Fix README.md Section 2 Structure Description (done)
- [task-055](tasks/task-055-remove-polish-language-from-all-files.md) — Remove Polish Language from All Project Files (done)
- [task-056](tasks/task-056-update-initialization-guide-and-template-lifecycle.md) — Update Initialization Guide with Section 6, Template Lifecycle, and Git.md Reference (done)
- [task-057](tasks/task-057-remove-emoji-from-all-documentation.md) — Remove Emoji from All Documentation Files (done)
- [task-058](tasks/task-058-add-file-templates-to-manifest.md) — Add templates/ to MANIFEST.md and Handle Cleanup Removal (done)
- [task-059](tasks/task-059-multi-select-tech-stack-and-input-validation.md) — Multi-Select Tech Stack and CLI Input Validation (done)
- [task-060](tasks/task-060-update-root-agents-md.md) — Update Root AGENTS.md (done)
- [task-061](tasks/task-061-rename-file-templates-to-templates.md) — Rename templates to templates (done)
- [task-062](tasks/task-062-proofread-english-text-for-consistency-and-clarity.md) — Proofread English Text for Consistency and Clarity (done)
- [task-063](tasks/task-063-rename-file-templates-to-templates.md) — Rename `file-templates/` to `templates/` (done)
- [task-064](tasks/task-064-remove-duplicate-mermaid-diagram.md) — Remove Duplicate Mermaid Diagram (SSOT Violation) (done)
- [task-065](tasks/task-065-fix-incomplete-task-index.md) — Fix Incomplete Task Index in `tasks.md` (done)
- [task-066](tasks/task-066-remove-emoji-from-docs-navigation.md) — Remove Remaining Emoji from Navigation Breadcrumbs in `docs/` (done)
- [task-067](tasks/task-067-fix-broken-wiki-link-gitignore.md) — Fix Broken Obsidian Wiki-Link in `knowledge/gitignore.md` (done)
- [task-068](tasks/task-068-add-comments-to-rule-template-placeholders.md) — Add Instructive Comments to Rule Template Placeholders (todo)
- [task-069](tasks/task-069-cleanup-tmp-directory.md) — Clean Up `tmp/` Directory and Add `.gitkeep` (todo)
- [task-070](tasks/task-070-add-missing-ai-context-templates.md) — Add Missing `ai/context/` Companion Templates (todo)
- [task-071](tasks/task-071-document-manifest-update-trigger-rule.md) — Document MANIFEST.md Update Trigger Rule (todo)
- [task-072](tasks/task-072-clarify-history-vs-memory-distinction.md) — Clarify Distinction Between `ai/history/` and `ai/memory/` (todo)
- [task-073](tasks/task-073-define-plans-vs-specs-boundary.md) — Define Clear Boundary Between `plans/` and `specs/` (todo)
- [task-074](tasks/task-074-add-file-size-enforcement-mechanism.md) — Add File Size Rule Enforcement Mechanism (todo)
- [task-075](tasks/task-075-document-manifest-multi-agent-conflict-strategy.md) — Document MANIFEST.md Conflict Resolution for Multi-Agent Scenarios (todo)
- [task-076](tasks/task-076-add-runs-script-lifecycle-metadata.md) — Add Lifecycle Metadata Convention for `ai/runs/` Scripts (todo)
- [task-077](tasks/task-077-create-project-changelog.md) — Create Populated `CHANGELOG.md` for the Project (todo)
- [task-078](tasks/task-078-create-contributing-md.md) — Create `CONTRIBUTING.md` (todo)
- [task-079](tasks/task-079-create-real-world-example-project.md) — Create a Real-World Example Project in `examples/` (todo)
- [task-080](tasks/task-080-add-cicd-pipeline.md) — Add CI/CD Pipeline to the Project (todo)
- [task-081](tasks/task-081-add-specific-tags-to-knowledge-files.md) — Add Specific Tags to Knowledge Files (todo)
- [task-082](tasks/task-082-expand-new-feature-workflow.md) — Expand `new-feature.md` Workflow Template (todo)
- [task-083](tasks/task-083-add-bugfix-and-release-workflows.md) — Add `bugfix.md` and `release.md` Workflow Templates (todo)
- [task-084](tasks/task-084-add-prompts-and-templates-dir.md) — Add Templates for `ai/prompts/` and `ai/templates/` (todo)
- [task-085](tasks/task-085-add-semantic-versioning.md) — Add Semantic Versioning to the Standard (todo)
- [task-086](tasks/task-086-add-precommit-hook-guidance.md) — Add Pre-commit Hook Guidance to `knowledge/git.md` (todo)
- [task-087](tasks/task-087-create-onboarding-template.md) — Create Team Onboarding Template (todo)
- [task-088](tasks/task-088-create-multi-agent-coordination-guide.md) — Create Multi-Agent Coordination Guidelines (todo)
- [task-089](tasks/task-089-create-rollback-workflow.md) — Create `rollback.md` Workflow Template (todo)
- [task-090](tasks/task-090-add-bootstrap-integration-tests.md) — Add Integration Tests for Bootstrap Scripts (todo)
- [task-091](tasks/task-091-create-security-md.md) — Create `SECURITY.md` at the Project Root (todo)
- [task-092](tasks/task-092-update-tasks-index-with-analysis-tasks.md) — Update `tasks.md` Index with All 30 Tasks from Analysis Report (done)
