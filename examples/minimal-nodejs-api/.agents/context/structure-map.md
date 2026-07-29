# Structure Map

This map defines which directories can exist in the workspace and when they should be created.

## Directory Mapping Rules

- **`src/`** — Core implementation code. Created at project initialization.
- **`tests/`** — Unit and integration tests. Created at project initialization.
- **`specs/`** — Business specifications and requirements. Created when the first feature requires documentation.
- **`contracts/`** — Schema contracts (e.g. OpenAPI yaml). Created when exposing API endpoints.
- **`decisions/`** — ADR files. Created when a major architectural choice is finalized.
- **`docs/`** — Technical documentation. Created at project initialization.
- **`tasks/`** — Active task files. Created when work starts.
- **`tmp/`** — Local scratch directory. Created at project initialization.
