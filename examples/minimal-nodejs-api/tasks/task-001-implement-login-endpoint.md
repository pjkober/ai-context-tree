---
id: task-001
tags:
  - tasks
  - authentication
status: done
priority: high
type: feature
owner: agent-01
created: 2026-07-16
updated: 2026-07-16
depends_on: []
---

# Task-001: Implement Login Endpoint

## Description

Expose the `POST /api/auth/login` endpoint to allow user authentication and JWT issuance, as described in specs.

## What to Do

1. Create a validation schema in `src/validation/auth.ts` for login request payloads.
2. Implement the login handler in `src/controllers/auth.ts` verifying the password hash.
3. Add routing in `src/routes/auth.ts`.
4. Add unit and integration tests in `tests/controllers/auth.test.ts`.

## Verification

- `POST /api/auth/login` returns JWT tokens on successful credentials.
- Invalid payloads return `400 Bad Request`.
- Missing user or invalid password returns `401 Unauthorized`.

## Walkthrough

- Created `src/validation/auth.ts` containing the Zod schema for login validations.
- Implemented handler in `src/controllers/auth.ts` fetching user records and matching passwords via bcrypt.
- Added tests in `tests/controllers/auth.test.ts` covering success, failure, and validation error scenarios.
- All tests pass, and coverage for the login critical path is 100%.
