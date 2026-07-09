---
aliases:
  - gitignore
  - gitignore policy
tags:
  - knowledge
type: docs
---

# Git and .gitignore Policy

This document defines the project's policy for Git version control and the configuration of `.gitignore` files.

## Core Principles

The version control strategy is built around distinguishing between **transient/generated artifacts** and **configuration/manifest source code**.

### 1. Ignore Generated Library Code
* **Rule:** Always exclude directories containing downloaded package/library code from the repository.
* **Why:** These folders are automatically populated and managed by package managers during the build or setup phase. Storing them in Git causes repository bloat, merge conflicts, and redundant files.
* **Examples of ignored directories:**
  * `node_modules/` (Node.js/npm)
  * `vendor/` (PHP/Composer or Go Modules)
  * `.venv/`, `venv/`, `env/` (Python virtual environments)
  * `packages/` (various package managers)

### 2. Retain Manifest & Configuration Files
* **Rule:** Never ignore the configuration files that describe which libraries and versions to install.
* **Why:** These files are the single source of truth (SSOT) defining the environment and dependencies. They allow other developers and CI/CD pipelines to reproduce the exact environment.
* **Examples of files that must be committed:**
  * `package.json` and `package-lock.json`
  * `composer.json` and `composer.lock`
  * `requirements.txt`, `Pipfile`, `pyproject.toml`, and `poetry.lock`
  * `go.mod` and `go.sum`

### 3. Exclude Temporary Directories
* **Rule:** Exclude directories used for temporary file storage, build outputs, or local environment variables.
* **Examples of excluded patterns:**
  * `tmp/` (used for temporary files and excluded from Git and CI/CD)
  * `dist/`, `build/`, `out/` (compilation outputs)
  * `.env`, `.env.local` (local environment secrets)
  * `*.log` (execution logs)
