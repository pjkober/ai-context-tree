---
id: task-040
tags:
  - tasks
status: done
priority: medium
type: refactor
owner: Antigravity
created: 2026-07-09
updated: 2026-07-09
depends_on: []
---

# Task-040: Translate and Add Navigation

**Location:** `knowledge/*.md`, `docs/*.md`, `docs/structure/*.md`, `file-templates/ai/runs/run-001-example-automation.sh`

**Description:**
1. Translate all remaining Polish words/labels/aliases in the documentation and template files to English.
2. Add navigation bars at the top and bottom of sequentially ordered files under `docs/` and `docs/structure/` to allow seamless reading.

## Verification Walkthrough

1. **Language Standardization (Polish to English):**
   * Modified headers and descriptions in `knowledge/licenses.md`, `knowledge/Full Coverage.md`, `knowledge/Definition of Done.md`, and `knowledge/Critical Path.md` to remove Polish translations/aliases and replace them with standard English terms.
   * Replaced bolded Polish guidelines labels (`Nazewnictwo z opisem`, `Zasada czystości`, `Tylko przydatne skrypty`) with English equivalents (`Descriptive Naming`, `Cleanliness`, `Only Reusable Scripts`) in `docs/structure/ai-agents.md`.
   * Translated comments in `file-templates/ai/runs/run-001-example-automation.sh` (Zasada czystości -> Cleanliness).

2. **Sequential Navigation Bars:**
   * Added top and bottom navigation bars to all 6 files in `docs/` and all 5 files in `docs/structure/`.
   * The navigation links allow the reader to click "Next" or "Previous" (or return to the "Home (README)") to read the entire documentation standard continuously.
