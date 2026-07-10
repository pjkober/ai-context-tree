---
id: task-050
tags:
  - tasks
status: done
priority: medium
type: feature
owner: Antigravity
created: 2026-07-10
updated: 2026-07-10
depends_on: []
---

# Task-050: Refactor Post-Setup Cleanup

**Description:**
1. Update `create_minimal_structure.sh` and `create_minimal_structure.ps1`.
2. Modify the post-setup cleanup menu to:
   - Always delete the setup scripts (`create_minimal_structure.sh` and `create_minimal_structure.ps1`).
   - Offer an option to clean up one-time templates in `file-templates/` (deleting `README.md`, `AGENTS.md`, `MANIFEST.md`, `.gitignore`, `ai/` folder) while keeping the remaining templates (e.g. `specs/`, `decisions/`, etc.) in `file-templates/` for future project growth.
   - Offer an option to permanently delete the entire `file-templates/` directory.
   - Offer an option to keep everything untouched.
3. Automatically perform the default cleanup (Option 1) in non-interactive mode.
4. Update `docs/06-initialization-guide.md` with the new cleanup process.

## Verification Walkthrough
- Checked `create_minimal_structure.sh` syntax: `bash -n create_minimal_structure.sh` passed.
- Verified that both `.sh` and `.ps1` implement the updated 3-option cleanup process.
- Updated `docs/06-initialization-guide.md` to reflect the new cleanup behavior.
