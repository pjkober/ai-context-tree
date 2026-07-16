---
id: task-072
tags:
  - tasks
status: todo
priority: medium
type: docs
owner: pjk
created: 2026-07-16
updated: 2026-07-16
depends_on: []
---

# Task-072: Clarify Distinction Between `ai/history/` and `ai/memory/`

## Source
Report section 5.2 (Ambiguity).

## Location
- `docs/structure/ai-agents.md` -- sections for `ai/history/` and `ai/memory/`
- `templates/ai/history/conver-001-example-transcript.md` -- existing template (good example)
- `templates/ai/memory/` -- needs a concrete example file

## Description

The documentation defines two directories with overlapping conceptual territory:
- `ai/history/` -- conversation transcripts, session summaries, conversation logs.
- `ai/memory/` -- historical lessons, post-mortems, known issues, technical debt.

In everyday English, "history" and "memory" are near-synonyms. A developer writing a post-mortem summary of a conversation session could reasonably place the file in either directory. An AI agent faced with this decision will pick arbitrarily.

The renaming of `ai/memory/` to `ai/lessons/` or `ai/retrospectives/` is considered as an option but is a breaking change. The minimum viable fix is to add concrete example content that clearly differentiates the two.

## What to Do

### Option A (Recommended): Rename `ai/memory/` to `ai/lessons/`

1. Update `docs/structure/ai-agents.md` to rename the section from `ai/memory/` to `ai/lessons/`.
2. Update `templates/ai/context/structure-map.md` if `ai/memory/` is listed there.
3. Update `templates/AGENTS.md` if it references `ai/memory/`.
4. Add a disambiguation note in both the `ai/history/` and `ai/lessons/` sections:
   ```markdown
   ## ai/history/
   Role: Raw session logs -- what was said between the developer and the AI agent.
   - File type: Conversation transcripts, chat logs, session records.
   - Question it answers: "What was discussed in this session?"
   - Example: conver-001-setup-payments-api.md (transcript of the session that designed the payments module)

   ## ai/lessons/
   Role: Extracted knowledge -- what was learned from past mistakes or decisions.
   - File type: Post-mortems, known issues, technical debt notes, architectural warnings.
   - Question it answers: "What should future agents know to avoid this mistake?"
   - Example: lesson-001-never-use-orm-transactions-with-queue.md
   ```

### Option B (Minimal): Add disambiguation to `ai/memory/` without renaming

If renaming is not desired, add a clear disambiguation note to `docs/structure/ai-agents.md` under both sections with concrete examples as shown in Option A.

## Verification

- `docs/structure/ai-agents.md` contains a disambiguation note under both directory sections.
- Each section contains at least one concrete file name example.
- A new developer reading the two sections can immediately determine which directory to use for any given content.
