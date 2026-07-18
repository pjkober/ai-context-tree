# System Architecture Overview

This document describes the high-level module architecture of the User Authentication Service.

## Request Lifecycle

1. **Routing:** Incoming client requests enter through `src/routes/`.
2. **Validation Middleware:** Payloads are checked against schemas located in `src/validation/`.
3. **Controller:** Route requests are processed in `src/controllers/`, extracting inputs and orchestrating service logic.
4. **Data layer:** Database queries are executed in `src/models/` or using Knex query builder directly.
5. **Response:** Controllers return JSON payloads representing the response schemas.

## Security Controls

- JWTs are generated and validated using the `jsonwebtoken` package.
- Passwords are hashed before database insertion using `bcrypt`.
- Input validation prevents SQL injection and query parameter attacks.
