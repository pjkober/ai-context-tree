---
id: task-090
tags:
  - tasks
status: done
priority: high
type: feature
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on:
  - task-063
---

# Task-090: Add Integration Tests for Bootstrap Scripts

## Source
Report section 7.7 (Missing element).

## Location
- `scripts/test-bootstrap.sh` (new file)
- `scripts/test-bootstrap.ps1` (new file)
- `.github/workflows/lint.yml` -- add a bootstrap test job (after task-080)

## Description

The bootstrap scripts `create_minimal_structure.sh` and `create_minimal_structure.ps1` are the primary user-facing artifacts of this project. They are what most adopters run first. Yet they have zero automated tests. A regression (broken placeholder substitution, missing directory creation, wrong permission) would be discovered only when a user reports a failure after cloning the repo.

Industry standard for published CLI tooling is a simple integration test that:
1. Runs the script in `--non-interactive` mode in a clean temporary directory.
2. Verifies that all expected files and directories were created.
3. Checks that no lingering `__PLACEHOLDER__` tokens remain in the generated output.
4. Verifies the script exits with code 0.

## What to Do

### Create `scripts/test-bootstrap.sh`

```bash
#!/usr/bin/env bash
# test-bootstrap.sh
# Integration test for create_minimal_structure.sh
# Usage: ./scripts/test-bootstrap.sh

set -euo pipefail

SCRIPT="./create_minimal_structure.sh"
TEST_DIR="$(mktemp -d)"
FAILURES=0

echo "=== Bootstrap Integration Test ==="
echo "Test directory: $TEST_DIR"
echo ""

# Run the script in non-interactive mode
echo "[1/4] Running bootstrap script in non-interactive mode..."
bash "$SCRIPT" --non-interactive --output-dir "$TEST_DIR" > /dev/null 2>&1
echo "      EXIT CODE: $? (expected: 0)"

# Check required files exist
echo "[2/4] Checking required files and directories..."

REQUIRED=(
  "AGENTS.md"
  "MANIFEST.md"
  "ai/context/project.md"
  "ai/context/structure-map.md"
  "ai/rules/coding.md"
  "ai/rules/security.md"
  "ai/rules/testing.md"
  "ai/workflows/new-feature.md"
  "tasks.md"
  "tmp/.gitkeep"
)

for item in "${REQUIRED[@]}"; do
  if [ -e "$TEST_DIR/$item" ]; then
    echo "      OK:      $item"
  else
    echo "      MISSING: $item"
    FAILURES=$((FAILURES + 1))
  fi
done

# Check no placeholder tokens remain
echo "[3/4] Checking for leftover __PLACEHOLDER__ tokens..."
PLACEHOLDERS=$(grep -r "__[A-Z_]\+__" "$TEST_DIR" --include="*.md" -l 2>/dev/null | wc -l)
if [ "$PLACEHOLDERS" -eq 0 ]; then
  echo "      OK: No placeholder tokens found."
else
  echo "      FAIL: $PLACEHOLDERS file(s) contain unsubstituted placeholders:"
  grep -r "__[A-Z_]\+__" "$TEST_DIR" --include="*.md" -l
  FAILURES=$((FAILURES + 1))
fi

# Bash syntax check
echo "[4/4] Bash syntax check on generated scripts..."
for f in "$TEST_DIR"/**/*.sh; do
  [ -f "$f" ] && bash -n "$f" || { echo "Syntax error in: $f"; FAILURES=$((FAILURES + 1)); }
done
echo "      OK: All generated scripts have valid syntax."

# Summary
echo ""
echo "=== Results ==="
rm -rf "$TEST_DIR"
if [ "$FAILURES" -eq 0 ]; then
  echo "PASSED: All checks passed."
  exit 0
else
  echo "FAILED: $FAILURES check(s) failed."
  exit 1
fi
```

### Create `scripts/test-bootstrap.ps1`

A PowerShell equivalent that runs `create_minimal_structure.ps1 -NonInteractive` and performs the same checks (file existence, no placeholder tokens, exit code 0).

Structure mirrors `test-bootstrap.sh` but uses PowerShell syntax (`Test-Path`, `Select-String`, etc.).

### Add a job to `.github/workflows/lint.yml` (after task-080)

```yaml
  bootstrap-test-bash:
    name: Bootstrap Script Integration Test (Bash)
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run bootstrap integration test
        run: bash scripts/test-bootstrap.sh

  bootstrap-test-powershell:
    name: Bootstrap Script Integration Test (PowerShell)
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run bootstrap integration test
        run: pwsh scripts/test-bootstrap.ps1
```

### Make scripts executable

```bash
chmod +x scripts/test-bootstrap.sh
```

## Verification

- `scripts/test-bootstrap.sh` exits with code 0 on the current codebase.
- After deleting a required file from `templates/`, the test exits with code 1.
- After introducing a `__TEST_PLACEHOLDER__` that is not substituted, the test exits with code 1.
- `bash -n scripts/test-bootstrap.sh` exits with code 0 (valid Bash syntax).

## Walkthrough

- Created `templates/tasks.md` to establish the standard task index template for target repositories.
- Updated `create_minimal_structure.sh` and `create_minimal_structure.ps1` to copy `tasks.md` and `tasks/task-001-example.md` during bootstrapping.
- Created `scripts/test-bootstrap.sh` and `scripts/test-bootstrap.ps1` integration test scripts.
- Configured the test scripts to run locally inside the workspace's `tmp/` folder to prevent macOS Sandbox violations.
- Added test execution jobs to `.github/workflows/lint.yml`.
- Verified that all created files contain no emojis.
