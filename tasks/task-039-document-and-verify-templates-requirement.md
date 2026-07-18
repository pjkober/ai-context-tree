---
id: task-039
tags:
  - tasks
status: done
priority: medium
type: refactor
owner: Antigravity
created: 2026-07-09
updated: 2026-07-09
depends_on: []
---

# Task-039: Document and Verify templates requirement

**Location:** `create_minimal_structure.sh`, `create_minimal_structure.ps1`, `README.md`, `docs/06-initialization-guide.md`

**Description:**
1. Move the check for `templates/` to the very beginning of `create_minimal_structure.sh` and `create_minimal_structure.ps1` scripts, showing a helpful warning/error message.
2. Add a post-setup cleanup prompt wizard at the end of both scripts to offer moving, deleting, or keeping the generator script and `templates/` directory.
3. Create `docs/06-initialization-guide.md` to explain how to initialize structures, copy scripts along with `templates/`, run them, and use the automated cleanup.
4. Update `README.md` to document the scripts' usage and copy requirements, linking to the new guide.
5. Verify the changes.

## Verification Walkthrough

1. **Script Check Relocation:**
   * In `create_minimal_structure.sh`, moved directory validation of `templates/` right after `TEMPLATES_DIR` variable initialization (lines 11-18).
   * In `create_minimal_structure.ps1`, moved the folder container validation right after `$TemplatesDir` initialization (lines 15-22).
   * If `templates/` is missing, the script terminates immediately with a descriptive warning telling the user to copy both the script and the `templates/` directory.

2. **Interactive Cleanup Wizard:**
   * In `create_minimal_structure.sh`, appended a cleanup wizard prompting the user to Move to `tmp/` (via `exec mv`), Delete permanently (via `exec rm`), or Keep files.
   * In `create_minimal_structure.ps1`, appended the same cleanup wizard utilizing try/catch blocks to gracefully handle file lock errors on Windows.

3. **Documentation Integration:**
   * Added `docs/06-initialization-guide.md` containing full instructions on prerequisites, copying steps, running scripts, and post-initialization cleanup.
   * Linked the guide in `README.md` and added a warning block highlighting the directory dependency.

