---
id: task-011
tags:
  - tasks
status: todo
priority: critical
type: docs
owner: pjk
created: 2026-07-07
updated: 2026-07-07
depends_on: []
---

# Task-011: Document Contradicts Its Own No-Preset-Levels Principle

**Location:** Lines 109-131 (Incremental Growth principle) vs. Lines 133-224 (Structure Snapshots section) vs. Line 1083 (Terminology section)

**Description:** The document explicitly states (line 111): *"The MINIMAL / FULL levels described in the following section are for illustrative purposes only. They show typical snapshots of the structure at different stages — they are not rigid presets that you must choose from at the start."* However, the document itself immediately contradicts this in multiple places:

- The section heading on line 151 reads **"FULL Version (AI Native)"** — the word "Version" implies a selectable variant, not an illustration.
- The section heading on line 133 reads **"MINIMAL Version (Basic)"** — same problem.
- The overarching section title on line 129 is **"Structure Snapshots (Illustrative)"** — the qualifier "Illustrative" appears only here, not in the two sub-headings, making it easy to miss.
- The Terminology Management section (line 1083) introduces three named levels: **MINIMAL**, **OPTIMAL**, **FULL** — treating them as a classification system for choosing rules, which directly contradicts the incremental growth principle.
- The `structure-map.md` template (lines 482-494) implicitly reinforces a two-level model by only cataloguing directories associated with the illustrative FULL snapshot.

**Justification:** A reader who only scans headings and the Terminology section will conclude that the document defines three selectable project levels to choose from at project start. This is the **opposite** of the stated principle. Proposed fix options:

1. Rename sub-headings to "Early-stage snapshot" and "Mature-project snapshot" (remove the word "Version").
2. Move the Incremental Growth principle *before* the snapshots section and add a prominent callout block.
3. Remove the snapshot section entirely and replace it with inline examples within the incremental growth description.
4. Remove all references to OPTIMAL (see task-009) — it has no definition and implies a third selectable level.
