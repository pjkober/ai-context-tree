---
id: task-053
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

# Task-053: Add Git Initialization Prompt

**Description:**
1. Create `templates/knowledge/git.md` template file containing a Polish explanation of Git and basic commands (status, add, restore, commit).
2. Add a new prompt in `create_minimal_structure.sh` and `create_minimal_structure.ps1` (after cleanup prompt) asking if they want to initialize Git repository tracking.
3. If they select Option 2:
   - Run `git init`.
   - Copy `knowledge/git.md` template to the project.
   - Run `git add .` to stage files.
4. Default to Option 1 (No Git init) in non-interactive mode.

## Verification Walkthrough
- Created `templates/knowledge/git.md` template file containing standard Git help documentation in Polish.
- Verified that both `.sh` and `.ps1` prompt for Git tracking, run `git init`, copy the template, and run `git add .` if accepted.
- Verified that both scripts reset/unstage themselves from the staged index so as not to track the setup scripts.
