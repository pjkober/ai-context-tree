# Security Policies

All modifications must adhere strictly to these security guidelines.

## Rules

- **Hashing:** Always use bcrypt with a salt round count of 12 for hashing passwords. Never use MD5 or SHA-1.
- **Tokens:** JWTs must expire within 15 minutes. Always sign tokens with an HS256 algorithm or stronger, using keys loaded from the environment.
- **Secrets:** Do not commit hardcoded secrets, keys, or passwords. Load secrets from `.env` using environment variables.
- **Validation:** Always validate request payloads using schemas (e.g. Zod) at the entry points of Express controllers.
