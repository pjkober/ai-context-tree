---
id: task-031
tags:
  - tasks
status: done
priority: medium
type: docs
owner: Antigravity
created: 2026-07-09
updated: 2026-07-09
depends_on: []
---

# Task-031: Align README.md Minimal Snapshot with create_minimal_structure.sh

**Location:** `README.md`

**Description:**
The Minimal Structure snapshot in `README.md` (lines 61-74) does not list `MANIFEST.md` or `ai/workflows/` (and its contained `new-feature.md`), even though both `create_minimal_structure.sh` and `create_minimal_structure.ps1` copy these files when initializing the minimal structure.

This task will:
1. Update the Minimal Structure snapshot in `README.md` to display `MANIFEST.md` and the `ai/workflows/` directory structure.
2. Ensure that both `README.md` and the initialization scripts are fully in sync regarding the files copied in the minimal setup.

**Justification:**
Ensures that the documentation accurately reflects the files and folders generated when a user runs the bootstrap/initialization scripts, resolving discrepancy and inconsistency in project setup guidance.

## Verification Walkthrough

1. **Identified Discrepancies:**
   - Both `create_minimal_structure.sh` and `create_minimal_structure.ps1` copy `MANIFEST.md` and `ai/workflows/new-feature.md` templates into the minimal setup.
   - However, the Minimal Structure snapshot in the main `README.md` omitted them.
2. **Updated Documentation:**
   - Modified `README.md` to include `MANIFEST.md` and `ai/workflows/` folder structure in the Minimal Structure tree layout.
   - Verified that the updated tree snapshot matches exactly what the initialization scripts copy and construct during workspace bootstrapping.

