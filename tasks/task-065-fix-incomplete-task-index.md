---
id: task-065
tags:
  - tasks
status: done
priority: high
type: docs
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on: []
---

# Task-065: Fix Incomplete Task Index in `tasks.md`

## Source
Report section 4.3 (HIGH).

## Location
- `tasks.md` (lines 84-89 — only the last 5 tasks are listed)

## Description

The `tasks.md` file is documented as the index and convention reference for the `tasks/` directory. However, only tasks 058-062 are listed in the index section (lines 84-89). Tasks 001-057 -- over 90% of the project's history -- are invisible from the index. This defeats the entire purpose of the index file and makes the task history undiscoverable.

There are two acceptable approaches. Choose one and document it explicitly:

**Option A (Recommended): Full index**
List all tasks with their status inline.

**Option B: Documented partial index**
Explicitly document that the index shows only the last N tasks and provide a shell command for querying the full history.

## What to Do

### Option A: Full index

1. Generate a list of all tasks from the `tasks/` directory:
   ```bash
   ls tasks/ | sort
   ```
2. For each task file, extract the id and title from the filename and status from the frontmatter:
   ```bash
   for f in tasks/task-*.md; do
     id=$(basename $f .md)
     status=$(grep "^status:" $f | awk '{print $2}')
     title=$(grep "^# Task-" $f | head -1)
     echo "- [$id](tasks/$(basename $f)) -- $title ($status)"
   done
   ```
3. Replace the current partial list in `tasks.md` with the full generated list.
4. Add a convention note: "The index must be kept complete. Add every new task as a line entry when it is created."

### Option B: Documented partial index

1. Add a clear note above the partial list:
   ```markdown
   > The index below shows only the most recently active tasks. To list all tasks, run:
   > ```bash
   > ls tasks/ | sort
   > ```
   > To search by status: `grep -l "status: todo" tasks/*.md`
   ```
2. Document in the convention section what N means (e.g., last 10 tasks).

## Verification

- `tasks.md` either contains all task entries or explicitly documents the partial-index convention.
- Any reader opening `tasks.md` can understand how to find older tasks without guessing.

### Walkthrough of Changes
1. Added completeness rule (item 4) under the `Completed Task Lifecycle Rule` section in `tasks.md`:
   `4. The index must be kept complete. Add every new task as a line entry when it is created.`
2. Created a script `tmp/update_tasks_index.py` to recursively scan all 92 task files, parse their titles and statuses, format the list, and write it to the `Task Index` section in `tasks.md`.
3. Executed the script and verified that all 92 tasks (001-092) are now indexed in `tasks.md` with their correct status.
4. Cleaned up the temporary script `tmp/update_tasks_index.py`.
5. Staged and committed changes.
