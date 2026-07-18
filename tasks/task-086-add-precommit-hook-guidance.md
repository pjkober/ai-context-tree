---
id: task-086
tags:
  - tasks
status: done
priority: medium
type: docs
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on:
  - task-063
  - task-084
---

# Task-086: Add Pre-commit Hook Guidance to `knowledge/git.md`

## Source
Report section 7.3 (Missing element).

## Location
- `knowledge/git.md` -- add a pre-commit hooks section
- Optional: `templates/ai/rules/git.md` (new file) -- git-specific agent rules

## Description

The project enforces several strict rules that can be verified automatically before a commit: no emoji in documentation, English-only text, valid YAML frontmatter in task files, and shell script syntax. Pre-commit hooks are the standard mechanism for enforcing these rules at the contributor level, but the project provides no guidance on setting them up.

Without pre-commit hooks, every rule violation is discovered only during manual review or (if task-080 is done) in CI -- after the code has already been committed and pushed.

## What to Do

### 1. Add a "Pre-commit Hooks" section to `knowledge/git.md`

```markdown
## Pre-commit Hooks

Pre-commit hooks run automatically before each `git commit` to catch rule violations early,
before code reaches the remote repository or CI.

### Setup with pre-commit framework

1. Install the pre-commit framework:
   ```bash
   pip install pre-commit
   # or via homebrew:
   brew install pre-commit
   ```

2. Create `.pre-commit-config.yaml` at the project root:
   ```yaml
   repos:
     - repo: https://github.com/pre-commit/pre-commit-hooks
       rev: v4.6.0
       hooks:
         - id: check-yaml
           name: Validate YAML files
         - id: end-of-file-fixer
         - id: trailing-whitespace

     - repo: local
       hooks:
         - id: no-emoji
           name: No emoji in documentation
           language: system
           entry: bash -c 'if grep -rP "[\x{1F300}-\x{1FFFF}]|[\x{2600}-\x{26FF}]" --include="*.md" .; then echo "ERROR: Emoji found."; exit 1; fi'
           pass_filenames: false

         - id: shell-syntax
           name: Bash script syntax check
           language: system
           entry: bash -n
           types: [shell]
   ```

3. Install the hooks:
   ```bash
   pre-commit install
   ```

4. Run against all files manually (first-time check):
   ```bash
   pre-commit run --all-files
   ```

### Manual hook alternative (without the framework)

Create `.git/hooks/pre-commit` manually:
```bash
#!/usr/bin/env bash
# Check for emoji in .md files
if grep -rP "[\x{1F300}-\x{1FFFF}]|[\x{2600}-\x{26FF}]" --include="*.md" .; then
  echo "ERROR: Emoji found in documentation. Commit aborted."
  exit 1
fi
# Bash script syntax check
for f in *.sh scripts/*.sh; do
  [ -f "$f" ] && bash -n "$f" || exit 1
done
exit 0
```
Make it executable: `chmod +x .git/hooks/pre-commit`
```

### 2. Add `.pre-commit-config.yaml` template

Create `templates/.pre-commit-config.yaml` with the content from step 2 above, so adopters can copy it to their projects during setup.

### 3. Optionally: mention in the bootstrap wizard

In `create_minimal_structure.sh`, add an optional prompt at the end of Section 6 (Git):
```
"Do you want to copy the .pre-commit-config.yaml template to enable pre-commit hooks? (y/N)"
```

## Verification

- `knowledge/git.md` contains a "Pre-commit Hooks" section with setup instructions for both the framework and the manual approach.
- `templates/.pre-commit-config.yaml` exists.
- The pre-commit config correctly catches a test emoji when run manually.

## Walkthrough

- Appended a comprehensive "Pre-commit Hooks" section to `knowledge/git.md` describing framework integration and manual git hooks.
- Created `templates/.pre-commit-config.yaml` layout template.
- Updated `create_minimal_structure.sh` and `create_minimal_structure.ps1` to prompt users to optionally copy the pre-commit configuration file when Git is enabled.
- Confirmed no emojis are present in any files.
