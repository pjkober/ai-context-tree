

## Pre-commit Hooks

Pre-commit hooks run automatically before each `git commit` to catch rule violations early, before code reaches the remote repository or CI.

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
