---
id: task-095
tags:
  - tasks
status: done
priority: high
type: chore
owner: agent
created: 2026-07-17
updated: 2026-07-17
depends_on:
  - task-094
---

# task-095: Release v1.0.0

## Goal

Promote all accumulated changes from [Unreleased] and [0.6.0] into the first stable release v1.0.0.

## Release Contents

v1.0.0 consolidates work from tasks 063-094 spanning:
- Complete ai-context-tree standard with all template types
- Bootstrap scripts (sh and ps1) with full wizard (9 sections)
- Integration tests for bootstrap scripts
- Real-world example project (examples/minimal-nodejs-api/)
- CI/CD pipeline
- SECURITY.md policy and templates
- CONTRIBUTING.md, CHANGELOG.md, semantic versioning
- Multi-agent coordination guide
- Full ai/history/ documentation (conver-001 through conver-028)

## Changes Made

- CHANGELOG.md [MODIFIED]: [Unreleased] promoted to [1.0.0] - 2026-07-17, [0.6.0] block added.
- VERSION [MODIFIED]: 0.6.0 -> 1.0.0.
- tasks/task-095 [NEW]: this file.

## Verification

Version 1.0.0 tagged in git.
