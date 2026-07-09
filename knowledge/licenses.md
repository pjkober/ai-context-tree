---
aliases:
  - license policy
  - software licenses
tags:
  - knowledge
type: docs
---

# Software License Guidelines

This document details the project's dependency licensing policies and explains the differences between major software licenses. It serves as a guide for AI agents and developers when selecting third-party libraries.

## License Classifications

For the purposes of this project, software licenses are divided into three tiers based on commercial safety and copyleft requirements.

---

### 1. Permissive Licenses (Bezpieczne / Zezwalające)
These licenses allow free use, modification, and distribution of the library for any purpose (including commercial), without forcing the host application to open-source its own code.

* **MIT License:** The most common and permissive. Requires only copyright and permission notices. Highly recommended.
* **Apache License 2.0:** Permissive, but adds explicit patent rights grants and protection against patent infringement claims.
* **BSD (2-Clause / 3-Clause):** Similar to MIT but includes clauses restricting the use of the authors' names for endorsement.
* **Public Domain / CC0:** Dedicates the work to the public domain, waiving all rights.

**Policy:** Fully allowed in all projects.

---

### 2. Weak-Copyleft Licenses (Ograniczone / Hybrydowe)
These licenses protect the library itself from becoming closed-source, but allow it to be linked by proprietary, closed-source host applications.

* **LGPL (Lesser GNU General Public License):** Allows dynamic linking by proprietary applications. Statically linking or modifying the library code itself forces those modifications to be open-sourced under LGPL.
* **MPL (Mozilla Public License):** Similar to LGPL; allows use in proprietary projects as long as MPL-licensed files remain separate and modifications to those files are published under MPL.
* **CDDL (Common Development and Distribution License):** File-based copyleft, similar to MPL.

**Policy:** Allowed *only* if the dependency is used as-is and linked dynamically. Modifying the dependency's code requires approval.

---

### 3. Strong-Copyleft / Viral Licenses (Kopiowanie wzajemne / Niebezpieczne dla komercji)
These licenses require any software that links, modifies, or derives from them to be released under the same copyleft license (forcing the entire proprietary application to open-source its codebase).

* **GPL (GNU General Public License v2/v3):** Viral. Static or dynamic linking forces the entire host application to be licensed under GPL.
* **AGPL (Affero GPL):** Extends GPL copyleft triggers to network access. Running the software on a server (SaaS) forces the entire server-side application to be open-sourced.
* **CC BY-NC (Creative Commons Non-Commercial):** Explicitly forbids any commercial use or monetization of the code.

**Policy:** Strictly forbidden in commercial or proprietary projects.

---

## AI Agent Ingestion Rules

When evaluating packages to install, the AI agent must run license check utilities or inspect the package manifest to confirm that the package license matches the chosen project policy.
