---
tags:
  - knowledge
  - git
  - version-control
---

# Git - Version Control System

Git is a distributed version control system that tracks the history of changes in project files, enables collaboration between multiple developers on the same codebase, and allows easy rollback to previous versions when issues occur. Since history is stored locally, most operations execute instantly, and the branching mechanism allows safe testing of new features without affecting the stable version of the code.

## Essential Git Commands

### Help & Status
* `git -h` or `git --help` — displays general help and a list of commonly used commands.
* `git status` — shows the current state of the project: which files have been modified, which are tracked/untracked, and which changes are staged for the next commit.

### Staging Files
* `git add <filename>` — stages a specific file for inclusion in the next commit.
* `git add <directory>` — stages all files within a given directory.
* `git add .` or `git add -A` — stages all modified and new files across the entire project.

### Undoing Changes & Removing from Stage
* `git reset HEAD <filename>` (or `git restore --staged <filename>`) — removes a file from the staging area (undoes `git add`), so it will not be included in the next commit.
* `git rm --cached <filename>` — removes a file from Git's index (stops tracking it), but keeps the file on disk.
* `git rm <filename>` — removes a file from both Git's index and from the disk.

### Committing Changes
* `git commit -m "description of changes"` — commits all staged changes and creates a new point in the project history with the provided description.
