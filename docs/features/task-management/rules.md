# Task Management - Business Rules

> Decision tables for the feature.
> Reference: [README.md](README.md) | [Glossary](../../GLOSSARY.md)

## Context Menu Rules
> Traces: `REQ-TASK-MGMT-009` | `AC-TASK-MGMT-007`

| Condition | Result |
|---|---|
| User right-clicks (secondary click) on a task bar | Show context menu with "Rename", "Change Color", "Set Dates", and "Delete" options (D011) |
| Context menu is open and user clicks outside | Dismiss menu, no action |

## Task Creation Rules
> Traces: `REQ-TASK-MGMT-001` | `AC-TASK-MGMT-001`

| Condition | Result |
|---|---|
| Name is empty or whitespace-only | Reject creation, show error |
| Name is valid (non-empty) | Create task with 0% progress, default color |
| Name exceeds 100 characters | Reject input (enforce max 100 chars on input, D010) |

## Task Editing (Rename) Rules
> Traces: `REQ-TASK-MGMT-004` | `AC-TASK-MGMT-003`, `AC-TASK-MGMT-008`, `AC-TASK-MGMT-009`

| Condition | Result |
|---|---|
| New name is empty or whitespace-only | Reject rename, show validation error, preserve original name |
| New name exceeds 100 characters | Prevent input beyond 100 chars (enforce max on input, D010) |
| New name is identical to current name | Accept silently, no storage write needed |
| New name is valid and different | Update task name, refresh `updatedAt`, persist to SwiftData |
| User cancels rename (Escape or clicks outside) | Discard changes, restore original name |

## Task Deletion Rules
> Traces: `REQ-TASK-MGMT-005` | `AC-TASK-MGMT-004`, `AC-TASK-MGMT-010`

| Condition | Result |
|---|---|
| Task has no subtasks | Delete task directly after confirmation |
| Task has subtasks | Delete task and all nested subtasks after confirmation |
| Task is the only remaining task | Allow deletion, show empty state |

## Task Display Rules
> Traces: `REQ-TASK-MGMT-002`, `REQ-TASK-MGMT-003`, `REQ-TASK-MGMT-008` | `AC-TASK-MGMT-002`, `AC-TASK-MGMT-006`

| Condition | Result |
|---|---|
| Task has 0% progress | Show task bar with name only, no fill |
| Task has 1-99% progress | Show task bar with proportional color fill |
| Task has 100% progress | Show task bar fully filled, mark as complete |
| Task has subtasks | Show subtask count badge |
| Task name overflows bar width | Truncate with ellipsis (full name preserved in storage, D010) |
