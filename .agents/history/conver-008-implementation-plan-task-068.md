# Implementation Plan - Task-068: Add Instructive Comments to Rule Template Placeholders

This plan outlines the steps to add informative HTML comment blocks immediately above all placeholder tokens (`__PLACEHOLDER__`) in the project's rule templates to guide developers during manual setup.

## User Review Required

> [!IMPORTANT]
> Informative HTML comments will be added above the placeholder tokens in the templates:
> - `templates/ai/rules/coding.md` (4 placeholders)
> - `templates/ai/rules/security.md` (9 placeholders)
> - `templates/ai/rules/testing.md` (3 placeholders)
> These comments provide context, valid options, and concrete examples.

## Open Questions

None. The task is straightforward and resolves documentation/scaffolding gaps.

## Proposed Changes

---

### Scaffolding & Templates

#### [MODIFY] [coding.md](file:///Users/pjk/code/ai-context-tree-new/templates/ai/rules/coding.md)
Add comment blocks immediately above:
- `__REFACTORING_POLICY__`
- `__TECH_STACK__`
- `__COMMUNICATION_POLICY__`
- `__LINTING_POLICY__`

#### [MODIFY] [security.md](file:///Users/pjk/code/ai-context-tree-new/templates/ai/rules/security.md)
Add comment blocks immediately above:
- `__AUTONOMY_MODE__`
- `__DEPENDENCY_POLICY__`
- `__ARCHITECTURE_POLICY__`
- `__LICENSE_POLICY__`
- `__GIT_POLICY__`
- `__SAFETY_POLICY__`
- `__TASK_MANAGEMENT_POLICY__`
- `__CONTEXT_MANAGEMENT_POLICY__`
- `__SECRETS_POLICY__`

#### [MODIFY] [testing.md](file:///Users/pjk/code/ai-context-tree-new/templates/ai/rules/testing.md)
Add comment blocks immediately above:
- `__TESTING_COVERAGE__`
- `__TESTING_APPROACH__`
- `__TEST_EXECUTION_SCOPE__`

---

### Task Tracking

#### [MODIFY] [tasks.md](file:///Users/pjk/code/ai-context-tree-new/tasks.md)
Update status of task-068 to `done`.

#### [MODIFY] [task-068-add-comments-to-rule-template-placeholders.md](file:///Users/pjk/code/ai-context-tree-new/tasks/task-068-add-comments-to-rule-template-placeholders.md)
Set status to `done` and record the verification details.

## Verification Plan

### Automated Tests
- Verify the shell script syntax remains valid:
  ```bash
  bash -n create_minimal_structure.sh
  ```

### Manual Verification
- Check all rule template files (`coding.md`, `security.md`, `testing.md`) to verify the comments are properly structured.
