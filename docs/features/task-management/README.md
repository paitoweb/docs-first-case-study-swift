# Task Management

- Priority: P0
- Status: Complete
- Last updated: 2026-03-14

## Overview

Core CRUD functionality for tasks in Slidoo. Users can create new tasks with a name, view them as colored bars in a list, edit task properties, and delete tasks. The task list is the main screen of the application, displaying all top-level tasks with their names, progress percentages, and color-coded bars.

## Requirements (REQ-*)

- `REQ-TASK-MGMT-001` The system MUST allow the user to create a new task with a name (max 100 characters, D010).
- `REQ-TASK-MGMT-002` The system MUST display all top-level tasks as a vertical list of colored task bars.
- `REQ-TASK-MGMT-003` The system MUST display each task's name and current progress percentage on the task bar.
- `REQ-TASK-MGMT-004` The system MUST allow the user to edit a task's name.
- `REQ-TASK-MGMT-005` The system MUST allow the user to delete a task.
- `REQ-TASK-MGMT-006` The system MUST persist all task data locally so it survives app relaunch.
- `REQ-TASK-MGMT-007` The system MUST provide an add button (+) in the header and a Cmd+N keyboard shortcut to create new tasks.
- `REQ-TASK-MGMT-008` The system MUST display a subtask count badge on tasks that have subtasks.
- `REQ-TASK-MGMT-009` The system MUST provide a right-click context menu on task bars with "Rename", "Change Color", "Set Dates", and "Delete" options.

## Acceptance Criteria (AC-*)

### AC-TASK-MGMT-001 - Create Task (REQ-TASK-MGMT-001, REQ-TASK-MGMT-007)

- Given the user is on the task list screen
- When the user clicks the (+) button or presses Cmd+N and enters a task name
- Then a new task is created with 0% progress and appears at the bottom of the list

### AC-TASK-MGMT-002 - Display Task List (REQ-TASK-MGMT-002, REQ-TASK-MGMT-003)

- Given there are one or more tasks
- When the user views the task list screen
- Then each task is displayed as a horizontal colored bar showing the task name on the left and progress percentage on the right

### AC-TASK-MGMT-003 - Edit Task Name (REQ-TASK-MGMT-004, REQ-TASK-MGMT-009)

- Given the user right-clicks a task bar and selects "Rename"
- When the task name becomes an editable inline input pre-filled with the current name
- Then the user can modify the name (max 100 characters, D010) and confirm to save
- And the updated name is persisted to SwiftData and the `updatedAt` timestamp is refreshed

### AC-TASK-MGMT-004 - Delete Task (REQ-TASK-MGMT-005, REQ-TASK-MGMT-009)

- Given the user right-clicks a task bar and selects "Delete"
- When a confirmation dialog appears and the user confirms
- Then the task (and all its subtasks, if any) is permanently removed from SwiftData
- And the task list UI updates immediately

### AC-TASK-MGMT-005 - Local Persistence (REQ-TASK-MGMT-006)

- Given the user has created or modified tasks
- When the user closes and reopens the app
- Then all tasks and their progress are restored from SwiftData

### AC-TASK-MGMT-007 - Right-Click Context Menu (REQ-TASK-MGMT-009)

- Given the user is viewing the task list
- When the user right-clicks (secondary click) on a task bar
- Then a context menu appears with "Rename", "Change Color", "Set Dates", and "Delete" options

### AC-TASK-MGMT-008 - Rename Validation (REQ-TASK-MGMT-004)

- Given the user is editing a task name inline
- When the user submits an empty or whitespace-only name
- Then the rename is rejected with a validation error message
- And the original name is preserved unchanged

### AC-TASK-MGMT-009 - Rename Cancellation (REQ-TASK-MGMT-004)

- Given the user is in inline rename mode
- When the user dismisses without confirming (e.g., presses Escape or clicks outside)
- Then the original task name is restored and no changes are persisted

### AC-TASK-MGMT-010 - Delete Cancellation (REQ-TASK-MGMT-005)

- Given the confirmation dialog for task deletion is shown
- When the user cancels the dialog
- Then the task remains unchanged in the list

### AC-TASK-MGMT-006 - Subtask Count Badge (REQ-TASK-MGMT-008)

- Given a task has one or more subtasks
- When the task is displayed in the list
- Then a numeric badge shows the total number of direct subtasks

## Dependencies

- SwiftData persistence engine (`ModelContainer` + `ModelContext`)
- SwiftUI gesture system (for interaction patterns shared with slide-progress)

## Traceability

- Decisions: [`../../DECISIONS.md`](../../DECISIONS.md)
- NFR: [`../../nfr/NON_FUNCTIONAL.md`](../../nfr/NON_FUNCTIONAL.md)

## Non-Scope

- Task reordering / drag-and-drop sorting (not shown in reference designs)
- Task assignment to other users (v1 is single-user)
- Task templates or recurring tasks

## Open Questions

None currently.

## Resolved Questions

- **Task name max length**: 100 characters, truncated on display with ellipsis (D010)
- **Task insertion order**: New tasks are added at the bottom of the list, sorted by `createdAt` ascending (AC-TASK-MGMT-001)
- **Deletion confirmation**: Yes, task deletion always requires a confirmation dialog (AC-TASK-MGMT-004)
- **Edit/delete trigger**: Right-click context menu on the task bar (D011)
