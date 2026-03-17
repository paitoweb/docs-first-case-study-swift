# Subtask Hierarchy - Business Rules

> Decision tables for the feature.
> Reference: [README.md](README.md) | [Glossary](../../GLOSSARY.md)

## Navigation Rules
> Traces: `REQ-SUBTASK-HIER-003`, `REQ-SUBTASK-HIER-004` | `AC-SUBTASK-HIER-003`, `AC-SUBTASK-HIER-004`

| User Action | Task Has Subtasks | Result |
|---|---|---|
| Click task bar | Yes | Drill down to subtask list |
| Click task bar | No | Drill down to empty subtask view (user can add first subtask via + button) |
| Click back button or Cmd+[ | At level 2+ | Navigate to parent level |
| Click back button or Cmd+[ | At level 1 (top) | No action (back button not shown) |

## Subtask Creation Rules
> Traces: `REQ-SUBTASK-HIER-001`, `REQ-SUBTASK-HIER-002`, `REQ-SUBTASK-HIER-009` | `AC-SUBTASK-HIER-001`, `AC-SUBTASK-HIER-002`, `AC-SUBTASK-HIER-009`

Maximum depth: 5 levels (D008).

| Condition | Result |
|---|---|
| Parent task at level 1 | Create subtask at level 2 |
| Parent task at level 2 | Create subtask at level 3 |
| Parent task at level 3 | Create subtask at level 4 |
| Parent task at level 4 | Create subtask at level 5 |
| Parent task at level 5 | Reject creation — (+) button disabled |

## Progress Rollup Rules
> Traces: `REQ-SUBTASK-HIER-007`, `REQ-SUBTASK-HIER-008` | `AC-SUBTASK-HIER-007`, `AC-SUBTASK-HIER-008`

Hybrid progress model (D009).

| Condition | Progress Source | Slide Gesture |
|---|---|---|
| Task has no subtasks (leaf) | Manual (drag gesture) | Enabled |
| Task has 1+ subtasks (parent) | Average of direct children's progress | Disabled |
| Last subtask deleted from parent | Reverts to manual at last computed value | Re-enabled |
| First subtask added to leaf | Switches to auto-rollup | Disabled |

## Subtask Count Badge Rules
> Traces: `REQ-SUBTASK-HIER-006` | `AC-SUBTASK-HIER-006`

| Condition | Badge Display |
|---|---|
| Task has 0 subtasks | No badge shown |
| Task has 1+ subtasks | Badge shows count of direct subtasks |
| Subtask is deleted | Badge count decrements |

## Delete Cascade Rules
> Traces: `REQ-SUBTASK-HIER-001` | `AC-SUBTASK-HIER-001`
> Cross-ref: `REQ-TASK-MGMT-005` | `AC-TASK-MGMT-004`

| Condition | Result |
|---|---|
| Delete a task with subtasks | All nested subtasks at all levels are also deleted |
| Delete a subtask | Only that subtask and its descendants are deleted |
