# Spec: User Login Acceptance Criteria

These criteria must pass before the login feature is considered complete.

## Acceptance Criteria

### Scenario 1: Successful login
- **Given:** A registered user with email `"user@example.com"` and password `"SecretPass123"`.
- **When:** A `POST` request is sent to `/api/auth/login` with payload `{"email": "user@example.com", "password": "SecretPass123"}`.
- **Then:** Response status is `200 OK` and the body contains `accessToken` (valid JWT, expires in 15m) and `refreshToken` (valid JWT).

### Scenario 2: Invalid password
- **Given:** A registered user with email `"user@example.com"` and password `"SecretPass123"`.
- **When:** A `POST` request is sent to `/api/auth/login` with payload `{"email": "user@example.com", "password": "WrongPassword"}`.
- **Then:** Response status is `401 Unauthorized` and error message indicates invalid credentials.
