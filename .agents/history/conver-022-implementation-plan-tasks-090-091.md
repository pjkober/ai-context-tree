# Implementation Plan - Tasks 090 to 091

This plan covers implementing tasks 090 and 091 to add integration tests for bootstrap scripts (Bash & PowerShell) and create a security policy document at the project root.

## User Review Required

> [!NOTE]
> All changes are test scripts, CI configurations, and security documentation.

## Proposed Changes

We will group the changes into two main categories:
1. **Bootstrap Script Integration Tests** (Task 090)
2. **Security Policy** (Task 091)

---

### Bootstrap Script Integration Tests

#### [NEW] [test-bootstrap.sh](file:///Users/pjk/code/ai-context-tree-new/scripts/test-bootstrap.sh) (Task-090)
- Create a test script that runs the bootstrap script in a temp directory, checks that all required files and folders are present, checks for leftover placeholder tokens, and verifies syntax of generated scripts.

#### [NEW] [test-bootstrap.ps1](file:///Users/pjk/code/ai-context-tree-new/scripts/test-bootstrap.ps1) (Task-090)
- Create a PowerShell equivalent test script validating the same steps on Windows/PowerShell environments.

#### [MODIFY] [lint.yml](file:///Users/pjk/code/ai-context-tree-new/.github/workflows/lint.yml) (Task-090)
- Add GitHub Actions jobs `bootstrap-test-bash` (runs-on: ubuntu-latest) and `bootstrap-test-powershell` (runs-on: windows-latest).

---

### Security Policy

#### [NEW] [SECURITY.md](file:///Users/pjk/code/ai-context-tree-new/SECURITY.md) (Task-091)
- Create a security policy detailing supported versions, vulnerability reporting instructions, user-level best practices, and scope.

#### [MODIFY] [MANIFEST.md](file:///Users/pjk/code/ai-context-tree-new/MANIFEST.md) (Task-091)
- Add `SECURITY.md` to the manifest listing.

---

### Task Management and History Files

#### [MODIFY] Tasks files in `tasks/` (Tasks Metadata)
- Set status of tasks 090 and 091 to `in_progress` / `done`.
- Append verification walkthroughs to each file as they are completed.

#### [MODIFY] [tasks.md](file:///Users/pjk/code/ai-context-tree-new/tasks.md)
- Update indices of tasks 090-091 to `(done)`.

#### [NEW] Project History Files
- Write the approved implementation plan to `ai/history/conver-022-implementation-plan-tasks-090-091.md`.
- Write the final walkthrough to `ai/history/conver-023-session-walkthrough-tasks-090-091.md`.

---

## Verification Plan

### Automated Checks
- Run the new `scripts/test-bootstrap.sh` locally to ensure the Bash bootstrap script works correctly.
- Verify no emojis are present across all modified and newly created files.

### Manual Verification
- Check paths and links.
