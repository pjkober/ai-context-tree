# Implementation Plan - Tasks 079 to 083

This plan covers implementing tasks 079 through 083 to add a real-world example project skeleton, establish a CI/CD pipeline, add metadata tags to all 16 knowledge base files, and define comprehensive workflow templates for new features, bug fixes, and releases.

## User Review Required

> [!NOTE]
> All changes are local configuration and documentation files. The example project is a skeleton in `examples/` and does not run execution code, but contains realistic and compliant templates.

## Proposed Changes

We will group the changes into four main categories:
1. **Example Project** (Task 079)
2. **CI/CD Pipeline** (Task 080)
3. **Knowledge Tags** (Task 081)
4. **Workflow Templates** (Tasks 082, 083)

---

### Example Project

#### [NEW] [examples/README.md](file:///Users/pjk/code/ai-context-tree-new/examples/README.md) (Task-079)
- Explain the purpose of the example directory and how to read the minimal Node.js example.

#### [NEW] Example Project Files under `examples/minimal-nodejs-api/` (Task-079)
Create the skeleton for the example project with realistic, compliant contents:
- `README.md`
- `AGENTS.md`
- `MANIFEST.md`
- `ai/context/project.md`
- `ai/context/stack.md`
- `ai/context/structure-map.md`
- `ai/rules/coding.md`
- `ai/rules/security.md`
- `ai/rules/testing.md`
- `ai/workflows/new-feature.md`
- `ai/workflows/bugfix.md`
- `specs/user-login/requirements.md`
- `specs/user-login/acceptance.md`
- `tasks/task-001-implement-login-endpoint.md`
- `docs/architecture.md`

---

### CI/CD Pipeline

#### [NEW] [.github/workflows/lint.yml](file:///Users/pjk/code/ai-context-tree-new/.github/workflows/lint.yml) (Task-080)
- Define a GitHub Actions workflow that runs on push and PR to check Markdown links, scan for emojis in docs, run ShellCheck on `create_minimal_structure.sh`, and validate task frontmatter YAML.

#### [NEW] [.github/markdown-link-check.json](file:///Users/pjk/code/ai-context-tree-new/.github/markdown-link-check.json) (Task-080)
- Add configuration file to ignore badge patterns and define timeouts for Markdown link checks.

#### [MODIFY] [README.md](file:///Users/pjk/code/ai-context-tree-new/README.md) (Task-080)
- Add the CI status badge to the top section of the main README.

---

### Knowledge Tags

#### [MODIFY] Files in `knowledge/` (Task-081)
Add 1-3 specific tags to the YAML frontmatter in all 16 files:
- `API Contracts.md`
- `Autonomy Mode.md`
- `Boy Scout Rule.md`
- `Context Management.md`
- `Critical Path.md`
- `Definition of Done.md`
- `Full Coverage.md`
- `Integration Tests.md`
- `Living Specifications.md`
- `Spec-Driven Development.md`
- `Test-Driven Development.md`
- `Unit Tests.md`
- `Vibe Coding.md`
- `git.md` (add full frontmatter block)
- `gitignore.md`
- `licenses.md`

---

### Workflow Templates

#### [MODIFY] [new-feature.md](file:///Users/pjk/code/ai-context-tree-new/templates/ai/workflows/new-feature.md) (Task-082)
- Replace the minimal new feature workflow with the comprehensive 15-step template covering pre-implementation, implementation, and DoD verification.

#### [NEW] [bugfix.md](file:///Users/pjk/code/ai-context-tree-new/templates/ai/workflows/bugfix.md) (Task-083)
- Create a 10-step bug fix workflow covering diagnosis, TDD reproduction, fixing, and task closure.

#### [NEW] [release.md](file:///Users/pjk/code/ai-context-tree-new/templates/ai/workflows/release.md) (Task-083)
- Create a 10-step release workflow covering pre-release checks, docs updates, and tagging/publishing.

#### [MODIFY] [ai-agents.md](file:///Users/pjk/code/ai-context-tree-new/docs/structure/ai-agents.md) (Task-083)
- Link the new workflow templates in the `ai/workflows/` section.

---

### Task Management and History Files

#### [MODIFY] Tasks files in `tasks/` (Tasks Metadata)
- Set status of tasks 079 through 083 to `in_progress` / `done`.
- Append verification walkthroughs to each file as they are completed.

#### [MODIFY] [tasks.md](file:///Users/pjk/code/ai-context-tree-new/tasks.md)
- Update indices of tasks 079-083 to `(done)`.

#### [NEW] Project History Files
- Write the approved implementation plan to `ai/history/conver-016-implementation-plan-tasks-079-083.md`.
- Write the final walkthrough to `ai/history/conver-017-session-walkthrough-tasks-079-083.md`.

---

## Verification Plan

### Automated Checks
- Validate Shell scripts syntax: `bash -n create_minimal_structure.sh`
- Verify no emojis are present across all modified files.

### Manual Verification
- Verify link paths in the generated example files and workflows.
- Confirm all files in the example project are correctly populated.
