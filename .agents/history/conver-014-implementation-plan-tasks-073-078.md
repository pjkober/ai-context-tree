# Implementation Plan - Tasks 073 to 078

This plan covers implementing tasks 073 through 078 to address ambiguities in documentation, introduce file-size rules and validation scripts, establish lifecycle metadata conventions, and add standard documentation files (`CHANGELOG.md` and `CONTRIBUTING.md`).

## User Review Required

> [!IMPORTANT]
> The git commands in this workspace will be executed using the macOS system git (`/usr/bin/git`) directly instead of Homebrew's git wrapper to prevent dyld library loading issues caused by the App Sandbox.

## Proposed Changes

We will group the changes into three main categories:
1. **Directory Boundary and Metadata Rules** (Tasks 073, 075, 076)
2. **File Size Enforcement Mechanism** (Task 074)
3. **Core Project Documentation** (Tasks 077, 078)

---

### Directory Boundary and Metadata Rules

#### [MODIFY] [business-knowledge.md](file:///Users/pjk/code/ai-context-tree-new/docs/structure/business-knowledge.md) (Task-073)
- Under the `specs/` section, add the decision rule table comparing `specs/` and `plans/`.

#### [MODIFY] [supporting.md](file:///Users/pjk/code/ai-context-tree-new/docs/structure/supporting.md) (Task-073)
- Under the `plans/` section, add the disambiguation note referencing `specs/`.

#### [MODIFY] [root-files.md](file:///Users/pjk/code/ai-context-tree-new/docs/structure/root-files.md) (Task-075)
- Under the `MANIFEST.md` section, add the "Multi-Agent Conflict Strategy" subsection.

#### [MODIFY] [ai-agents.md](file:///Users/pjk/code/ai-context-tree-new/docs/structure/ai-agents.md) (Task-076)
- Under the `ai/runs/` section, add the "Script Header Convention" and lifecycle rules.

#### [MODIFY] [run-001-example-automation.sh](file:///Users/pjk/code/ai-context-tree-new/templates/ai/runs/run-001-example-automation.sh) (Task-076)
- Replace the legacy header with the new script header convention.

---

### File Size Enforcement Mechanism

#### [NEW] [check-file-sizes.sh](file:///Users/pjk/code/ai-context-tree-new/scripts/check-file-sizes.sh) (Task-074)
- Create a lightweight shell script to report any tracked file exceeding the 300-line limit.

#### [MODIFY] [new-feature.md](file:///Users/pjk/code/ai-context-tree-new/templates/ai/workflows/new-feature.md) (Task-074)
- Add a Step 7 to the Definition of Done requiring verification of file sizes.

#### [MODIFY] [coding.md](file:///Users/pjk/code/ai-context-tree-new/templates/ai/rules/coding.md) (Task-074)
- Reinforce the 300-line limit rule in the general guidelines and link to the new script.

---

### Core Project Documentation

#### [NEW] [CHANGELOG.md](file:///Users/pjk/code/ai-context-tree-new/CHANGELOG.md) (Task-077)
- Add `CHANGELOG.md` at the project root following the [Keep a Changelog](https://keepachangelog.com) format.

#### [NEW] [CONTRIBUTING.md](file:///Users/pjk/code/ai-context-tree-new/CONTRIBUTING.md) (Task-078)
- Add `CONTRIBUTING.md` at the project root detailing instructions on English-only, no-emoji, task-driven workflows, and issue reporting.

---

### Task Management

#### [MODIFY] [task-073-define-plans-vs-specs-boundary.md](file:///Users/pjk/code/ai-context-tree-new/tasks/task-073-define-plans-vs-specs-boundary.md) (Tasks Metadata)
- Set status to `in_progress` / `done`.
- Append verification section.

#### [MODIFY] [task-074-add-file-size-enforcement-mechanism.md](file:///Users/pjk/code/ai-context-tree-new/tasks/task-074-add-file-size-enforcement-mechanism.md) (Tasks Metadata)
- Set status to `in_progress` / `done`.
- Append verification section.

#### [MODIFY] [task-075-document-manifest-multi-agent-conflict-strategy.md](file:///Users/pjk/code/ai-context-tree-new/tasks/task-075-document-manifest-multi-agent-conflict-strategy.md) (Tasks Metadata)
- Set status to `in_progress` / `done`.
- Append verification section.

#### [MODIFY] [task-076-add-runs-script-lifecycle-metadata.md](file:///Users/pjk/code/ai-context-tree-new/tasks/task-076-add-runs-script-lifecycle-metadata.md) (Tasks Metadata)
- Set status to `in_progress` / `done`.
- Append verification section.

#### [MODIFY] [task-077-create-project-changelog.md](file:///Users/pjk/code/ai-context-tree-new/tasks/task-077-create-project-changelog.md) (Tasks Metadata)
- Set status to `in_progress` / `done`.
- Append verification section.

#### [MODIFY] [task-078-create-contributing-md.md](file:///Users/pjk/code/ai-context-tree-new/tasks/task-078-create-contributing-md.md) (Tasks Metadata)
- Set status to `in_progress` / `done`.
- Append verification section.

#### [MODIFY] [tasks.md](file:///Users/pjk/code/ai-context-tree-new/tasks.md)
- Update indices of tasks 073-078 to `(done)`.

---

## Verification Plan

### Automated Tests
- Validate shell script functionality on current files:
  `bash ./scripts/check-file-sizes.sh`
- Confirm check-file-sizes.sh returns 0 for all current files (they should be under 300 lines).

### Manual Verification
- Check all modified markdown links to verify they resolve correctly.
- Verify that no emoji are introduced.
- Review git diffs before final commit.
