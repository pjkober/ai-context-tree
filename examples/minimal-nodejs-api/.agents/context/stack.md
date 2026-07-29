# Technology Stack & Constraints

This authentication service is built using the Node.js ecosystem with TypeScript.

## Core Stack

- **Runtime:** Node.js (v20 LTS or higher)
- **Language:** TypeScript (strict mode enabled)
- **Framework:** Express (v5.0.0-beta.3)
- **Database:** PostgreSQL (v16)
- **ORM/Query Builder:** Knex.js (v3)

## Quality Tools

- **Linter/Formatter:** ESLint + Prettier (tabs for indentation, double quotes)
- **Testing:** Vitest (v1) with supertest for endpoint integration verification
- **Security:** `npm audit` and Snyk for dependency vulnerability checking
