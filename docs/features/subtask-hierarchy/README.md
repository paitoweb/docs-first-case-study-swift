# Subtask Hierarchy

- Priority: P0
- Status: Complete
- Last updated: 2026-03-14

## Overview

Tasks in Slidoo can contain subtasks, which can themselves contain further subtasks, forming a multi-level hierarchy up to 5 levels deep (D008). Users navigate between levels by clicking any task to drill down into its subtask view — if the task has no subtasks yet, the user sees an empty view with the (+) button to create the first subtask. Each level displays its own task list with the same visual style (colored bars, progress percentages). A parent task displays its subtask count as a badge, and its progress is auto-calculated as the average of its direct children (D009).

## Requirements (REQ-*)

- `REQ-SUBTASK-HIER-001` The system MUST allow the user to create subtasks inside any existing task.
- `REQ-SUBTASK-HIER-002` The system MUST support up to 5 levels of subtask nesting (D008).
- `REQ-SUBTASK-HIER-003` The system MUST allow the user to drill down into a task to view its subtasks.
- `REQ-SUBTASK-HIER-004` The system MUST allow the user to navigate back to the parent task level.
- `REQ-SUBTASK-HIER-005` The system MUST display subtasks using the same task bar UI as top-level tasks.
- `REQ-SUBTASK-HIER-006` The system MUST display a subtask count badge on parent tasks.
- `REQ-SUBTASK-HIER-007` The system MUST support the drag-to-progress gesture on leaf subtasks at any level (drag is disabled on parent tasks per D009).
- `REQ-SUBTASK-HIER-008` The system MUST auto-calculate parent task progress as the arithmetic average of its direct children's progress (D009).
- `REQ-SUBTASK-HIER-009` The system MUST prevent subtask creation at level 5 (maximum depth per D008).

## Acceptance Criteria (AC-*)

### AC-SUBTASK-HIER-001 - Create Subtask (REQ-SUBTASK-HIER-001)

- Given the user has drilled down into a task
- When the user clicks the (+) button or presses Cmd+N and enters a subtask name
- Then a new subtask is created under the current parent task with 0% progress

### AC-SUBTASK-HIER-002 - Multi-Level Nesting Up to 5 Levels (REQ-SUBTASK-HIER-002)

- Given a task hierarchy exists with tasks at levels 1 through 5
- When the user drills down to any level up to 5
- Then the subtasks are displayed and functional (drag gesture works on leaf tasks)

### AC-SUBTASK-HIER-003 - Drill Down Navigation (REQ-SUBTASK-HIER-003)

- Given a task exists at any level (with or without subtasks)
- When the user clicks the task bar
- Then the view transitions to show the subtask list for that task (which may be empty, allowing the user to add the first subtask via the + button or Cmd+N)

### AC-SUBTASK-HIER-004 - Navigate Back (REQ-SUBTASK-HIER-004)

- Given the user is viewing a subtask list
- When the user clicks the back button or presses Cmd+[
- Then the view returns to the parent task level

### AC-SUBTASK-HIER-005 - Consistent UI Across Levels (REQ-SUBTASK-HIER-005)

- Given the user is viewing subtasks at any nesting level
- When the subtasks are rendered
- Then they use the same colored bar UI with name, progress percentage, and color fill

### AC-SUBTASK-HIER-006 - Subtask Count Display (REQ-SUBTASK-HIER-006)

- Given a task has N direct subtasks
- When the task is displayed in any list
- Then a badge shows the number N

### AC-SUBTASK-HIER-007 - Slide on Leaf Subtasks (REQ-SUBTASK-HIER-007)

- Given the user is viewing leaf subtasks (no children) at any level
- When the user clicks and drags horizontally on a leaf subtask bar
- Then the subtask's progress updates via the standard drag-to-progress interaction

### AC-SUBTASK-HIER-008 - Auto-Calculated Parent Progress (REQ-SUBTASK-HIER-008)

- Given a parent task has 3 subtasks with progress 20%, 60%, and 80%
- When the parent task bar is displayed
- Then it shows 53% progress (arithmetic average rounded to nearest integer)

### AC-SUBTASK-HIER-009 - Max Depth Enforcement (REQ-SUBTASK-HIER-009)

- Given the user is viewing subtasks at level 5
- When the user attempts to create a new subtask
- Then the (+) button is disabled and subtask creation is prevented

## Dependencies

- Task management feature (provides task data model and CRUD)
- Slide-to-progress feature (provides drag gesture engine)

## Traceability

- Decisions: [`../../DECISIONS.md`](../../DECISIONS.md)
- NFR: [`../../nfr/NON_FUNCTIONAL.md`](../../nfr/NON_FUNCTIONAL.md)

## Non-Scope

- Moving subtasks between parent tasks (re-parenting)
- Collapsible/expandable subtask list within the same view (drill-down only)
- Nesting beyond 5 levels

## Open Questions

None currently.

## Resolved Questions

- **Progress rollup**: auto-calculated as average of direct children for parent tasks; manual for leaf tasks (D009)
- **Maximum nesting depth**: 5 levels (D008)
- **Drag on parent tasks**: disabled — progress is read-only when task has subtasks (D009)
- **Header breadcrumb trail**: No breadcrumb — show only the current parent task name + back button. A simple back button (also accessible via Cmd+[) is sufficient and consistent with the drill-down navigation model
