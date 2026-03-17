# Task Management - Technical Notes

## Flow Inputs

- User input events (click on + button, Cmd+N keyboard shortcut, right-click on task bars)
- Task name text input from user

## Component Connections
> Traces: `REQ-TASK-MGMT-002`, `REQ-TASK-MGMT-007`, `REQ-TASK-MGMT-009`

- `ContentView` manages task state via `TaskStore` (`@Observable` class injected as `@Environment`) and coordinates create sheet, rename, and delete confirmation state
- `HeaderView` renders the (+) button and Cmd+N keyboard shortcut, calls create action
- `TaskCreateSheet` presented as a sheet/popover, calls `taskStore.addTask(name:)` with validated input
- `TaskListView` renders `TaskBarView` for each task, passing rename state and callbacks
- `TaskBarView` uses `.gesture(DragGesture(...))` for progress detection and `.contextMenu` for right-click actions; supports inline rename mode via `@State` or `@Binding`
- Context menu is rendered natively via SwiftUI `.contextMenu` modifier on each `TaskBarView`, with "Rename", "Change Color", "Set Dates", and "Delete" options (D011)
- Confirmation dialog is rendered via `.confirmationDialog()` modifier for delete confirmation
- `TaskStore` provides `addTask()`, `updateProgress()`, `updateTask()`, and `deleteTask()` methods, backed by SwiftData `ModelContext`

## Implementation Notes
> Traces: `REQ-TASK-MGMT-001`, `REQ-TASK-MGMT-006`, `REQ-TASK-MGMT-007` | `AC-TASK-MGMT-001`, `AC-TASK-MGMT-005`

- Tasks are stored as SwiftData `@Model` objects with: id (Swift `UUID()`), name (max 100 chars), progress (Int 0-100), color (hex String), parentId (UUID?), level (Int 1-5), startDate (Date?), endDate (Date?), createdAt (Date), updatedAt (Date). See full schema in ARCHITECTURE.md
- Storage uses SwiftData via `TaskStore` (`@Observable` class) with `ModelContainer` and `ModelContext`. The store provides `addTask()`, `updateTask()`, `deleteTask()`, `deleteMany()` — all operations persist automatically via SwiftData
- Task list queries top-level tasks (parentId == nil) by default using SwiftData `@Query` or `ModelContext.fetch()`
- The (+) button is positioned in the header bar, right-aligned, alongside the centered "Slidoo" title. Cmd+N shortcut via `.keyboardShortcut("n")` (D012)
- Colors are assigned sequentially from a 7-color palette using round-robin: `TaskColor.allCases[taskCount % TaskColor.allCases.count]`
- New tasks appear at the bottom of the list (sorted by `createdAt` ascending, per AC-TASK-MGMT-001)
- Task name input enforces max 100 chars via `.onChange` modifier; empty names are rejected with inline error message
- State management uses `@Observable` / `@Environment` pattern (no additional state management libraries needed)

## Context Menu
> Traces: `REQ-TASK-MGMT-009` | `AC-TASK-MGMT-007`

- Right-click on a task bar triggers the native macOS context menu via SwiftUI `.contextMenu` modifier (D011)
- Menu items: "Rename", "Change Color", "Set Dates", "Delete"
- Haptic feedback via `NSHapticFeedbackManager.defaultPerformer.perform(.alignment, performanceTime: .default)` on menu activation (optional, trackpad-dependent)

## Task Editing (Rename)
> Traces: `REQ-TASK-MGMT-004` | `AC-TASK-MGMT-003`, `AC-TASK-MGMT-008`, `AC-TASK-MGMT-009`

- Selecting "Rename" from the context menu replaces the task name label with an inline `TextField`
- The TextField is pre-filled with the current name and auto-focused via `.focused()` modifier with `.onAppear` to select text
- Enforces 100 character limit via `.onChange` modifier (same constraint as creation, D010)
- Confirm on Return key or on focus loss (click outside the TextField)
- Cancel on Escape key — restore the original name without persisting
- On valid submit: calls `taskStore.updateTask(id, name: newName)`, which updates the task and persists via SwiftData
- On invalid submit (empty/whitespace): shows inline validation error, keeps input focused
- If name is unchanged: dismisses rename mode silently with no storage write
- The `updatedAt` timestamp is refreshed on successful rename
- Drag gesture is disabled during rename mode via conditional gesture attachment

## Task Deletion
> Traces: `REQ-TASK-MGMT-005` | `AC-TASK-MGMT-004`, `AC-TASK-MGMT-010`

- Selecting "Delete" from the context menu shows a `.confirmationDialog()` on the view
- Confirmation message reads: "Delete '{taskName}'?" (or "Delete '{taskName}' and all subtasks?" if subtasks exist)
- On confirm: calls `taskStore.deleteTask(id)`, which removes the task (and subtasks recursively) from SwiftData
- On cancel: dismisses dialog, no changes
- After deletion, the task list re-renders without the removed task; if the list becomes empty, the empty state is shown

## Change Color (Context Menu)
> Traces: `REQ-TASK-MGMT-009`, `REQ-COLOR-CUSTOM-002` | `AC-COLOR-CUSTOM-002`

- Selecting "Change Color" from the context menu shows the `ColorPickerView` as a popover (see [Design System — Components](../../design-system/components.md))
- The color picker displays 7 predefined swatches in a grid layout
- Clicking a swatch immediately updates the task's color and persists to SwiftData
- The task bar re-renders with the new color; the color picker dismisses
- See `color-customization` feature for full requirements and flows

## Phase 2 Dependencies

- Subtask count badge — REQ-TASK-MGMT-008: implementing in Phase 2 (see [subtask-hierarchy](../subtask-hierarchy/README.md) feature, REQ-SUBTASK-HIER-006)
