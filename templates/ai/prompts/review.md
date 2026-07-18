# Prompt: Code Review

Use this prompt to ask your AI assistant to perform a structured code review of recently changed files.

---

Review the following files that were changed in this task: [list file paths].

Apply all rules from `ai/rules/coding.md` and `ai/rules/security.md`.

For each file, report:
1. Any violations of the coding standards.
2. Any security concerns (hardcoded secrets, SQL injection risks, missing input validation).
3. Any functions exceeding 40 lines that should be split.
4. Any missing or insufficient test coverage for the changed logic.

Output a bullet list of findings, grouped by file. If there are no findings, state "No issues found."
