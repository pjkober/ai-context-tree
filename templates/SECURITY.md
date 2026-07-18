# Security Policy

## Supported Versions

<!-- Replace the table below with the versions your project currently supports with security updates. -->

| Version | Supported |
|---|---|
| Latest (main branch) | Yes |
| Older tagged versions | No |

We recommend always using the latest stable release.

---

## Reporting a Vulnerability

If you discover a security vulnerability in this project, please do NOT open a public GitHub issue.

Instead, report it privately via one of these methods:

1. **GitHub Private Vulnerability Reporting:** Use the "Report a vulnerability" button on the [Security tab](../../security/advisories/new) of this repository.
2. **Email:** Contact the project maintainer directly. See the GitHub profile for contact details.

Please include:

- A clear description of the vulnerability.
- The file(s) and line number(s) affected.
- Reproduction steps (if applicable).
- Potential impact assessment.

We will acknowledge the report within 72 hours and aim to provide a fix or mitigation within 14 days of confirmation.

---

## Security Best Practices for Contributors

1. **Never commit secrets:** Do not include API keys, passwords, tokens, or credentials in any committed file. Use environment variables and a secrets manager instead.

2. **Review generated files:** If this project uses a code generator or bootstrap script, review all generated files before committing to ensure no placeholder values contain real credentials.

3. **Dependency hygiene:** Keep all dependencies up to date. Run security audits regularly (e.g., npm audit, pip-audit, cargo audit).

4. **AI agent users:** If you configure an AI agent in full autonomy mode, ensure your .gitignore correctly excludes all credential and environment files before granting write access to the repository.

---

## Scope

This security policy covers the source code, configuration, and scripts maintained in this repository.

It does NOT cover:
- Third-party dependencies (report those to their respective maintainers).
- Deployment infrastructure or hosting environments managed outside this repository.
