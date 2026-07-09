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
By default, running the script interactively will guide you through a CLI wizard to customize your AI rules (Autonomy levels, Dependency rules, Git permissions, and Testing approach).

If you want to skip the wizard and immediately generate the structure with default settings, run:

* **Bash:** `./create_minimal_structure.sh --non-interactive`
* **PowerShell:** `./create_minimal_structure.ps1 -NonInteractive`

### Step 4: Cleanup (Automated or Manual)
Once the files are successfully created and configured in your project, the generator script and `file-templates/` directory are no longer needed.

If running interactively, the script will prompt you at the very end with a post-setup cleanup menu:
* **Move to `tmp/` (Default & Recommended):** Moves both `file-templates/` and the setup script to the project's `tmp/` directory. Since `tmp/` is ignored by Git, this keeps your project root clean but preserves the files locally in case you need to refer back to them.
* **Delete permanently:** Deletes `file-templates/` and the setup script immediately.
* **Keep:** Leaves both files in your root directory.

If you ran the script in `--non-interactive` mode (or want to clean up manually), you can do so by running:

```bash
# Clean up generator script and templates manually
rm -rf file-templates/ create_minimal_structure.sh
```


---

## 🗺️ What was Created?

The script generates a minimal set of files that act as pointers and standard guidelines for your AI assistant:
* [AGENTS.md](../AGENTS.md) — The central hub for AI instruction.
* [MANIFEST.md](../MANIFEST.md) — A living map of the files in your project.
* `ai/` — Guidelines, workflows, scripts, and logs.

---
[← Previous: 🤖 AI Client Integration](05-ai-integration.md) | [Home (README)](../README.md)

