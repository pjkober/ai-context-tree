# Structure Map

| Directory | When to create |
|---|---|
| `specs/` | when the first feature requiring documented business requirements is introduced |
| `decisions/` | when the first architectural decision worth justifying arises |
| `contracts/` | when the project starts exposing APIs or exchanging data between modules |
| `knowledge/` | when business knowledge grows too large to fit in a single `glossary.md` |
| `checklists/` | when a repeatable process (e.g., release) begins to be executed manually more than once |
| `plans/` | when the first change too large for a single entry in `task.md` is introduced |
| `prototypes/` | when the team starts testing solutions not intended for immediate production release |
| `archive/` | when the first piece of code or documentation becomes inactive but is worth preserving |
| `research/` | when the team begins analytical research, spikes, or market/competitor analysis |
| `tools/` | when custom utilities, generators, converters, or CLIs are created for the project |
| `scripts/` | when automation or helper scripts (build, seed, deploy, backup) are introduced |
| `config/` | when tool configs (eslint, tsconfig, vite, etc.) are consolidated to reduce root directory clutter |
| `infrastructure/` | when DevOps/IAC resources (docker-compose, terraform, helm, kubernetes) are introduced |
| `assets/` | when static assets (images, icons, fonts, design documents) are added to the project |
| `examples/` | when documentation references usage examples or code snippets (e.g., API requests/responses) |
| `ai/skills/` | created at project start to store project-specific local agent skills |
| `tasks/` | when tasks start being managed via individual markdown files with YAML frontmatter |
| `tmp/` | created automatically by local tools or build processes for temporary files |

