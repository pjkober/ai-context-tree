---
id: task-080
tags:
  - tasks
status: todo
priority: high
type: feature
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on:
  - task-063
  - task-066
  - task-067
---

# Task-080: Add CI/CD Pipeline to the Project

## Source
Report section 6.4 (Improvement).

## Location
- `.github/workflows/` (new directory and files)

## Description

The project has no GitHub Actions CI/CD pipeline. This means regressions like the emoji violations (issue 4.4), the broken wiki-link (issue 4.5), and broken script syntax go undetected until a human reviews manually. A project that prescribes best practices must demonstrate those same practices in its own infrastructure.

## What to Do

### Create `.github/workflows/lint.yml`

A lint workflow that runs on every push and pull request:

```yaml
name: Lint

on:
  push:
    branches: [main]
  pull_request:

jobs:
  markdown-links:
    name: Check Markdown Links
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Check Markdown links
        uses: gaurav-nelson/github-action-markdown-link-check@v1
        with:
          use-quiet-mode: 'yes'
          config-file: '.github/markdown-link-check.json'

  emoji-check:
    name: Check for Emoji
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Scan for emoji in documentation
        run: |
          if grep -rP "[\x{1F300}-\x{1FFFF}]|[\x{2600}-\x{26FF}]|[\x{2700}-\x{27BF}]" docs/ knowledge/ file-templates/ --include="*.md"; then
            echo "ERROR: Emoji found in documentation. Rule 2 prohibits emoji."
            exit 1
          fi
          echo "No emoji found."

  shell-syntax:
    name: Validate Shell Scripts
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Check Bash syntax
        run: bash -n create_minimal_structure.sh
      - name: ShellCheck
        uses: ludeeus/action-shellcheck@master
        with:
          scandir: '.'
          severity: error

  yaml-frontmatter:
    name: Validate Task Frontmatter
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install yamllint
        run: pip install yamllint
      - name: Extract and validate YAML frontmatter
        run: |
          for f in tasks/task-*.md; do
            awk '/^---$/{found++} found==1{print} found==2{exit}' "$f" > /tmp/frontmatter.yml
            yamllint -d relaxed /tmp/frontmatter.yml || { echo "Invalid YAML in $f"; exit 1; }
          done
          echo "All task frontmatter is valid YAML."
```

### Create `.github/markdown-link-check.json`

```json
{
  "ignorePatterns": [
    { "pattern": "^https://img.shields.io" },
    { "pattern": "^https://github.com/your-username" }
  ],
  "timeout": "20s",
  "retryOn429": true
}
```

### Update `README.md`

Add a CI badge next to the existing badges:
```markdown
[![CI](https://github.com/your-username/ai-context-tree/actions/workflows/lint.yml/badge.svg)](https://github.com/your-username/ai-context-tree/actions/workflows/lint.yml)
```

## Verification

- `.github/workflows/lint.yml` exists and is valid YAML.
- `.github/markdown-link-check.json` exists.
- The workflow runs successfully on the current codebase (after fixing issues 4.4 and 4.5 via tasks 066, 067).
- Intentionally introducing an emoji into a doc file causes the pipeline to fail.
