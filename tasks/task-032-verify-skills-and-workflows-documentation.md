---
id: task-032
tags:
  - tasks
status: done
priority: medium
type: docs
owner: Antigravity
created: 2026-07-09
updated: 2026-07-09
depends_on: []
---

# Task-032: Verify Skills and Workflows in Minimal Structure and Documentation

**Location:** `docs/`, `tasks/`

**Description:**
1. Verify if `ai/skills/` is included in the starting (minimal) structure and in all repository documentation descriptions.
2. Align the minimal structure tree snapshot in `docs/03-incremental-growth.md` to include `ai/workflows/` (and its contained `new-feature.md`), ensuring consistency across `README.md`, `docs/03-incremental-growth.md`, and the initialization scripts.

**Justification:**
Ensures complete alignment and consistency across all documentation snapshots of the minimal project structure.

## Verification Walkthrough

1. **Verified `ai/skills/` Inclusion:**
   - **Minimal Structure Setup:** Verified that the initialization scripts copy `ai/skills/example-skill.md` template file using `copy_template_file`, meaning it is bootstrapped at start.
   - **README.md Snapshot:** Verified `ai/skills/` is listed in the `README.md` minimal structure tree.
   - **Documentation Descriptions:** Verified that `docs/structure/ai-agents.md` contains a dedicated section detailing `ai/skills/` (role, rules, template). `docs/03-incremental-growth.md` lists `ai/skills/` in its Minimal Structure snapshot. `docs/05-ai-integration.md` covers workspace-scoped skill pointing. `templates/ai/context/structure-map.md` maps `ai/skills/` as created at project start.
   - **Conclusion:** `ai/skills/` is fully covered in both minimal setup and all documentation resources.

2. **Aligned `ai/workflows/` Snapshot:**
   - Identified that `ai/workflows/` (and `new-feature.md`) was missing from the minimal structure snapshot in `docs/03-incremental-growth.md`.
   - Updated the snapshot in `docs/03-incremental-growth.md` to include `ai/workflows/new-feature.md`, making it consistent with `create_minimal_structure.sh`, `create_minimal_structure.ps1`, and `README.md`.

