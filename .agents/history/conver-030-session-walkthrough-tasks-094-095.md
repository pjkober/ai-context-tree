# Walkthrough - Completed Tasks 094 and 095

Session date: 2026-07-17

## Task 094 - Fix CHANGELOG, MANIFEST, and ai/history Numbering

### Changes Made

#### CHANGELOG.md
Expanded [Unreleased] with all missing entries:
- task-091: SECURITY.md at project root.
- task-092: 30 task files from analysis report.
- task-093: templates/SECURITY.md, wizard step 1.9, docs update, integration test update.
- task-094: ai/history conver-025 to conver-028, MANIFEST.md expansion.

#### MANIFEST.md
- Added ai/ directory entry.
- Added examples/ directory entry.
- Added MANIFEST.md self-entry.
- Fixed VERSION alignment and ordering.

#### ai/history gap (conver-024)
Already resolved in prior session by git rename (conver-024 -> conver-028, commit a6e7f19). No additional action required.

### Commit
7d0c3d2 - chore(task-094): fix CHANGELOG, MANIFEST, and ai/history numbering

---

## Task 095 - Release v1.0.0

### Changes Made

#### CHANGELOG.md
- Promoted [Unreleased] to [1.0.0] - 2026-07-17.
- Added [0.6.0] - 2026-07-16 block for the prior batch (tasks 073-084).
- Left empty [Unreleased] header for future work.

#### VERSION
- Updated from 0.6.0 to 1.0.0.

#### Git Tag
- Created annotated tag: v1.0.0 - Release v1.0.0 - first stable release of ai-context-tree standard.

### Verification

- VERSION contains: 1.0.0
- git tag v1.0.0 exists.
- CHANGELOG.md [1.0.0] section present with full changelog.
- MANIFEST.md lists all top-level directories.

### Commits
a72c643 - chore(task-095): release v1.0.0
v1.0.0 tag -> a72c643
