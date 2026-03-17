# Domain Glossary

Last updated: 2026-03-14

## Purpose

Centralize term definitions to reduce ambiguity across the Slidoo project.

## General Terms

| Term | Definition |
|---|---|
| Product | The Slidoo native macOS desktop application |
| User | A person using Slidoo on their Mac to manage tasks |
| Feature | A distinct functional capability of the Slidoo application |

## Slidoo-Specific Terms

| Term | Definition |
|---|---|
| Task | A trackable work item with a name, progress percentage, optional dates, and optional subtasks |
| Task Bar | The horizontal visual element representing a task; contains the task name, progress percentage, color fill, and is the target for the drag gesture |
| Drag Gesture | A horizontal click-and-drag (left or right) on a task bar that increases or decreases the task's completion percentage. Implemented via SwiftUI `DragGesture` |
| Progress Percentage | A value from 0% to 100% representing how complete a task is, visually shown as the filled portion of the task bar |
| Subtask | A task nested inside another task; subtasks can themselves contain further subtasks (hierarchy) |
| Task Level | The depth of a task within the subtask hierarchy (level 1 = top-level task, level 2 = subtask, level 3 = sub-subtask, etc.) |
| Task Color | A user-assignable color applied to a task bar for visual categorization |
| Start Date | The date when work on a task is expected to begin |
| End Date | The date when a task is expected to be completed (deadline) |
| Days Left | A countdown showing how many days remain until a task's end date |
| Subtask Count Badge | A numeric indicator on a task bar showing how many subtasks it contains |
| Task List | The main screen showing all top-level tasks as colored bars |
| Drill-Down | The action of clicking any task to navigate into its subtask view (which may be empty if the task has no subtasks yet) |
| Progress Rollup | The auto-calculation of a parent task's progress as the arithmetic average of its direct children's progress (D009). Only applies to tasks with subtasks; leaf tasks use manual progress via drag |
| Dead Zone | A 10pt threshold applied to drag displacement before the gesture engine commits to a drag interaction (progress update) vs treating it as a click (drill-down) (D007) |
| Leaf Task | A task with no subtasks. Progress is manual (drag gesture enabled) |
| Parent Task | A task with one or more subtasks. Progress is auto-calculated (drag gesture disabled) |
| Color Picker | The UI control allowing users to change a task's color (Phase 2). Named `ColorPickerView` in code to avoid conflict with SwiftUI's built-in `ColorPicker` |
| Task Color Palette | A set of 7 predefined colors assigned to task bars. See [Design System — Colors](design-system/colors.md) |
| Design Token | A named value (color, size, spacing, etc.) used consistently across the UI. Implemented as SwiftUI `Color`/`Font` extensions and custom `ViewModifier`s. See [Design System](design-system/README.md) |
| Sync | The process of synchronizing local task data with a remote server (Phase 4, via CloudKit) |
| Export | The ability to save or share task data in an external format (JSON via `NSSavePanel`) |

## Technical Terms

| Term | Definition |
|---|---|
| SwiftUI | Apple's declarative UI framework used to build the Slidoo interface |
| Swift | The programming language used for the Slidoo application |
| SwiftData | Apple's persistence framework (macOS 14+) used for local task storage via `@Model` and `ModelContainer` |
| `@Observable` | Swift macro (macOS 14+) enabling reactive state management for view models like `TaskStore` |
| `DragGesture` | SwiftUI gesture recognizer used to implement the horizontal drag interaction on task bars |
| `ModelContainer` | SwiftData container managing the persistence stack and `ModelContext` for CRUD operations |
| `NSSavePanel` | macOS system panel for choosing a file save location, used for JSON export |
| Context Menu | macOS native right-click menu providing task actions (Rename, Change Color, Set Dates, Delete). Implemented via SwiftUI `.contextMenu` modifier (D011) |
| Keyboard Shortcut | macOS key combination for quick actions (Cmd+N, Cmd+F, etc.). Implemented via SwiftUI `.keyboardShortcut()` modifier (D012) |
