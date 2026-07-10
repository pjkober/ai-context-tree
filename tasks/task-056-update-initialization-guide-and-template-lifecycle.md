---
id: task-056
tags:
  - tasks
status: done
priority: medium
type: docs
owner: Antigravity
created: 2026-07-10
updated: 2026-07-10
depends_on: []
---

# Task-056: Update Initialization Guide with Section 6, Template Lifecycle, and Git.md Reference

**Description:**
Update `docs/06-initialization-guide.md` to:
1. Replace the flat bullet list of wizard options with a numbered Section 0–6 breakdown matching the actual script sections.
2. Add Section 6 (Git Version Control) to the wizard description.
3. Add a new "About the file-templates/ Directory" section documenting:
   - One-time templates (deleted after setup).
   - Reusable scaffolding templates (kept after setup, can be customized or extended).
4. Add a TIP callout explaining that `knowledge/git.md` can be copied manually if Git was skipped.
5. Add `knowledge/` entry to `file-templates/MANIFEST.md`.

## Verification Walkthrough
- `docs/06-initialization-guide.md` updated with all sections above.
- `file-templates/MANIFEST.md` now includes `knowledge/` entry.
- No duplicate content in the document.
