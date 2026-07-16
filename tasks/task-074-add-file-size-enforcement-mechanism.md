---
id: task-074
tags:
- tasks
status: todo
priority: medium
type: feature
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on:
- task-063
---

# Task-074: Add File Size Rule Enforcement Mechanism

## Source

Report section 5.4 (Ambiguity).

## Location

- `file-templates/ai/workflows/new-feature.md` -- add a Definition of Done check step
- `file-templates/ai/rules/coding.md` -- reinforce the 300-line rule
- `scripts/` (new file) -- `check-file-sizes.sh`

## Description

Core Principle 3 states files must be kept between 100-300 lines. This rule currently has no enforcement mechanism: no CI check, no linter integration, no mention in the Definition of Done. An AI agent has no automated way to know it violated this rule until a human reviews its output.

## What to Do

### 1. Create `scripts/check-file-sizes.sh`

A lightweight shell script that reports any tracked file exceeding 300 lines:

```bash
#!/usr/bin/env bash
# check-file-sizes.sh
# Reports files exceeding the 300-line limit defined in Core Principle 3.
# Usage: ./scripts/check-file-sizes.sh [directory] (default: project root)

set -euo pipefail

LIMIT=300
SEARCH_DIR="${1:-.}"
VIOLATIONS=0

echo "Checking file sizes (limit: $LIMIT lines) in: $SEARCH_DIR"
echo "---"

while IFS= read -r -d '' file; do
  lines=$(wc -l < "$file")
  if [ "$lines" -gt "$LIMIT" ]; then
    echo "OVER LIMIT: $file ($lines lines)"
    VIOLATIONS=$((VIOLATIONS + 1))
  fi
done < <(git ls-files -z "$SEARCH_DIR" 2>/dev/null || find "$SEARCH_DIR" -name "*.md" -print0)

echo "---"
if [ "$VIOLATIONS" -gt 0 ]; then
  echo "Found $VIOLATIONS file(s) exceeding $LIMIT lines."
  exit 1
else
  echo "All files are within the $LIMIT-line limit."
  exit 0
fi
```

Make the script executable and add it to the `scripts/` directory.

### 2. Add a Definition of Done step to `file-templates/ai/workflows/new-feature.md`

Add a final step:

```markdown
7. Verify file sizes: Run `./scripts/check-file-sizes.sh` and confirm no modified files exceed 300 lines. If a file exceeds the limit, split it following the single-responsibility principle before marking the task as done.
```

### 3. Reinforce the rule in `file-templates/ai/rules/coding.md`

Under "General Guidelines", replace or augment the existing line:

```markdown
- Keep files under 300 lines. If a file exceeds this limit, split it into focused sub-files following the single-responsibility principle. Run `./scripts/check-file-sizes.sh` to detect violations.
```

## Verification

- `scripts/check-file-sizes.sh` exists, is executable, exits 0 when no files exceed 300 lines, exits 1 when violations are found.
- `file-templates/ai/workflows/new-feature.md` contains a file-size check step.
- `file-templates/ai/rules/coding.md` references the script.
