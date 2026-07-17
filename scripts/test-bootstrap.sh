#!/usr/bin/env bash
# test-bootstrap.sh
# Integration test for create_minimal_structure.sh
# Usage: ./scripts/test-bootstrap.sh

set -euo pipefail

# Get absolute path of standard project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

SCRIPT="$ROOT_DIR/create_minimal_structure.sh"
TEST_DIR="$ROOT_DIR/tmp/test-bootstrap-temp"
rm -rf "$TEST_DIR"
mkdir -p "$TEST_DIR"
FAILURES=0

echo "=== Bootstrap Integration Test ==="
echo "Test directory: $TEST_DIR"
echo ""

# Copy script and templates to test directory (simulating user setup)
echo "[1/4] Copying script and templates to test directory..."
cp "$SCRIPT" "$TEST_DIR/"
cp "$ROOT_DIR/VERSION" "$TEST_DIR/"
cp -r "$ROOT_DIR/templates" "$TEST_DIR/"

# Run the script in non-interactive mode inside the test directory
echo "[2/4] Running bootstrap script in non-interactive mode..."
(
  cd "$TEST_DIR"
  bash ./create_minimal_structure.sh --non-interactive > /dev/null 2>&1
)
echo "      EXIT CODE: $? (expected: 0)"

# Check required files exist
echo "[3/4] Checking required files and directories..."

REQUIRED=(
  "AGENTS.md"
  "MANIFEST.md"
  "VERSION"
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
echo "[4/4] Checking for leftover __PLACEHOLDER__ tokens..."
PLACEHOLDERS=$(grep -r "__[A-Z_]\+__" "$TEST_DIR" --include="*.md" -l 2>/dev/null | wc -l || true)
if [ "$PLACEHOLDERS" -eq 0 ]; then
  echo "      OK: No placeholder tokens found."
else
  echo "      FAIL: $PLACEHOLDERS file(s) contain unsubstituted placeholders:"
  grep -r "__[A-Z_]\+__" "$TEST_DIR" --include="*.md" -l
  FAILURES=$((FAILURES + 1))
fi

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
