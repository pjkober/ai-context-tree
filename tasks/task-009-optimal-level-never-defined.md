---
id: task-009
tags:
  - tasks
status: done
priority: high
type: docs
owner: pjk
created: 2026-07-07
updated: 2026-07-07
depends_on:
  - task-011
---

# Task-009: OPTIMAL Level Referenced Once But Never Defined

**Location:** Line 1083

**Description:** The Terminology Management section names three levels: **MINIMAL**, **OPTIMAL**, **FULL**. Only MINIMAL and FULL are defined and illustrated with structure snapshots. OPTIMAL appears exactly once with no definition, snapshot, or explanation of what distinguishes it from the other two.

**Justification:** This is a symptom of the deeper inconsistency described in task-011. The document's core principle states there are no selectable levels — yet the Terminology section introduces a third level name without defining it. Either remove the OPTIMAL reference entirely (consistent with the incremental growth principle), or define it explicitly.
