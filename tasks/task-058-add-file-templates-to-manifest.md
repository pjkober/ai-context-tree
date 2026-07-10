# Task-058: Add file-templates/ to MANIFEST.md and Handle Cleanup Removal

## Goal
Add `file-templates/` to the template `MANIFEST.md` file, and implement dynamic removal of this line from the generated `MANIFEST.md` during setup script execution if the user selects Cleanup Option 2 (permanently deleting `file-templates/`).

## Proposed Changes
- [x] Modify `file-templates/MANIFEST.md` to add `file-templates/` line before `tmp/`
- [x] Update `create_minimal_structure.sh` to remove `file-templates/` from `MANIFEST.md` if cleanup option 2 is chosen
- [x] Update `create_minimal_structure.ps1` to remove `file-templates/` from `MANIFEST.md` if cleanup option 2 is chosen

## Verification
- Checked bash syntax: `SH: Syntax OK`
- Ensured file matches the structure and logic correctly.
