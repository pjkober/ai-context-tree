# Project Context: User Authentication Service

This service provides secure user registration, token-based authentication (JWT), and role-based access control (RBAC) for the parent platform.

## Key Objectives

1. Expose secure REST endpoints for user signup, login, and token refresh.
2. Store passwords securely using bcrypt hashing.
3. Validate and issue standard JSON Web Tokens.
4. Support role assignments (e.g., admin, user) to restrict API access.

## Non-Goals

- This service does not manage UI components or frontend code.
- It does not support third-party OAuth provider login (which will be added in a future milestone).
