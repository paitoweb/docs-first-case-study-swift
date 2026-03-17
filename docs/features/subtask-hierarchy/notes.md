# Subtask Hierarchy - Technical Notes

## Flow Inputs

- Task ID of the parent being drilled into
- Click event on task bar (single click to drill down, distinguished from drag for progress update)

## Component Connections
> Traces: `REQ-SUBTASK-HIER-003`, `REQ-SUBTASK-HIER-004` | `AC-SUBTASK-HIER-003`, `AC-SUBTASK-HIER-004`

- `TaskListView` receives a parentId parameter to know which level to display
- `NavigationStack` with path-based navigation maintains the hierarchy for drill-down/back
- Data layer queries tasks by parentId (via SwiftData `@Query` or `ModelContext.fetch()`) to load a specific level

## Implementation Notes
> Traces: `REQ-SUBTASK-HIER-002`, `REQ-SUBTASK-HIER-003`, `REQ-SUBTASK-HIER-005`, `REQ-SUBTASK-HIER-006` | `AC-SUBTASK-HIER-002`, `AC-SUBTASK-HIER-005`, `AC-SUBTASK-HIER-006`

- Distinguish click from drag: a click has no significant mouse movement between mouseDown and mouseUp (< 10pt displacement); a drag has horizontal displacement above the threshold
- The navigation state is modeled via `NavigationStack` with a path of parentIds; push on drill-down, pop on back (Cmd+[)
- The header should update to show the current parent task's name when drilled in
- Consider `NavigationStack` push animation for drill-down transitions to communicate hierarchy
- From the reference images, the subtask count badge appears as a small circle on the left side of the task bar with a number inside
