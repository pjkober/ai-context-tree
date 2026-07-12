[← Previous: 🤖 AI Client Integration](05-ai-integration.md) | [Home (README)](../README.md)

---

# Repository Initialization Guide

This guide explains how to use the initialization scripts (`create_minimal_structure.sh` and `create_minimal_structure.ps1`) to bootstrap the `ai-context-tree` layout in your own projects.

---

## ⚠️ Prerequisites & Dependencies

The initialization scripts **are not standalone**. They depend on the templates directory to work:
* **Required Directory:** `file-templates/` must exist in the same folder as the script.
* **Failure to comply:** If the script is run without `file-templates/` present, it will exit immediately with an error.

---

## 🚀 How to Setup in a New/Existing Project

Follow these steps to apply the AI-First structure to your project:

### Step 1: Copy the files to your project
Copy both the script matching your OS and the `file-templates/` directory to the root of your project:

```
your-project/
├── file-templates/         <-- COPY THIS DIR
├── create_minimal_structure.sh (or .ps1)  <-- COPY THIS SCRIPT
└── [your existing project files]
```

### Step 2: Run the script

#### On macOS / Linux (Bash)
Open your terminal in the project root, make the script executable, and run it:
```bash
chmod +x ./create_minimal_structure.sh
./create_minimal_structure.sh
```

#### On Windows (PowerShell)
Open PowerShell in the project root and execute:
```powershell
./create_minimal_structure.ps1
```

### Step 3: Configure via the Wizard (Optional)
By default, running the script interactively will guide you through a CLI wizard to customize your AI rules (Autonomy levels, Dependency rules, Git permissions, and Testing approach) and choose which AI IDE pointer files to generate.

All prompts in the wizard support a default option. You can simply press **Enter** to accept the recommended default value and proceed.

The wizard guides you through:
- **Section 0 – Project Details:** Set your project name (used in README.md and completion message).
- **Section 1 – Autonomy & Decisions:** Ask-First vs. Proactive autonomy, Dependency/License/Git/Safety/Security/Cost policies.
- **Section 2 – Coding & Refactoring:** Refactoring policy, linting, task granularity, and communication style.
- **Section 3 – Testing Strategy:** Coverage goals, TDD vs. Post-implementation, and test execution scope.
- **Section 4 – Tech Stack:** Multi-select language/framework-specific rules (Node.js/TypeScript, Python, Go, React/Next.js, Rust, Java/Spring Boot, C#/.NET, PHP/Laravel, or General).
- **Section 5 – AI IDE Pointer Files:** Optionally generate thin pointer files for Claude Code, Cursor, Cline/Roo Code, Windsurf, GitHub Copilot, JetBrains AI Assistant, Aider, Tabnine, and Cody.
- **Section 6 – Git Version Control:** Optionally initialize a Git repository (`git init`), copy the `knowledge/git.md` reference guide, and stage all initial project files (`git add .`). Default: skip (no Git).

If you want to skip the wizard and immediately generate the structure with default settings, run:

* **Bash:** `./create_minimal_structure.sh --non-interactive`
* **PowerShell:** `./create_minimal_structure.ps1 -NonInteractive`


### Step 4: Cleanup (Automated or Manual)
Once the files are successfully created and configured in your project, the generator script and `file-templates/` directory are no longer needed.

If running interactively, the script will prompt you at the very end with a post-setup cleanup menu:
* **Clean up one-time templates, but KEEP remaining future-growth templates in `file-templates/` (Default & Recommended):** Deletes the setup scripts (`create_minimal_structure.sh` / `.ps1`) and cleans up templates that are only needed once at startup (like `README.md`, `AGENTS.md`, and the `ai/` context folder). It keeps the optional templates for future repository scaffolding in `file-templates/` so you can use them as your project scales.
* **Delete permanently:** Deletes all template files and setup scripts immediately to keep the root directory completely minimal.
* **Keep everything:** Leaves all setup scripts and templates untouched in the root.

If running in `--non-interactive` mode, the script automatically executes the recommended cleanup (Option 1).

If you want to manually clean up at any point, you can delete the setup scripts and any unused templates:
```bash
# Delete setup scripts
rm -f create_minimal_structure.sh create_minimal_structure.ps1
```

---

## 📂 About the `file-templates/` Directory

The `file-templates/` directory contains two types of templates:

| Type | Description | Lifecycle |
|---|---|---|
| **One-time templates** | Files initialized directly into your project by the script (e.g., `README.md`, `AGENTS.md`, `ai/rules/`, `.gitignore`). | **Deleted after setup** (cleanup option 1). No longer needed once initialized. |
| **Reusable scaffolding templates** | Optional templates for directories you may create as your project grows (e.g., `specs/`, `contracts/`, `plans/`, `decisions/`). | **Kept after setup.** Use them whenever you need to scaffold a new directory. |

You can:
- **Use the existing templates** as starting points for new project directories.
- **Customize them** to match your team's conventions.
- **Add your own templates** to the directory to make scaffolding new areas of the project consistent and repeatable.

> [!TIP]
> The `knowledge/git.md` template is copied to your project only if you choose to initialize Git during setup (Section 6). You can also copy it manually at any time with:
> ```bash
> cp file-templates/knowledge/git.md knowledge/git.md
> ```

---

## 🗺️ What was Created?

The script generates a minimal set of files that act as pointers and standard guidelines for your AI assistant:
* [AGENTS.md](../AGENTS.md) — The central hub for AI instruction.
* [MANIFEST.md](../MANIFEST.md) — A living map of the files in your project.
* `ai/` — Guidelines, workflows, scripts, and logs.

---
[← Previous: 🤖 AI Client Integration](05-ai-integration.md) | [Home (README)](../README.md)
