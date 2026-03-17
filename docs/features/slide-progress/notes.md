# Slide-to-Progress - Technical Notes

## Flow Inputs

- Gesture events: `DragGesture` `onChanged`, `onEnded`; `TapGesture` for drill-down
- Task bar width (via `GeometryReader`, to calculate percentage from point displacement)
- Current task progress value

## Component Connections
> Traces: `REQ-SLIDE-PROGRESS-001`, `REQ-SLIDE-PROGRESS-004`, `REQ-SLIDE-PROGRESS-006`

- `DragGesture` logic is attached to `TaskBarView` via `.gesture(DragGesture(minimumDistance: 10).onChanged { ... }.onEnded { ... })` modifier
- View state tracks `@State private var currentProgress: Int` and `@State private var isDragging: Bool`
- `TapGesture` is used for drill-down (single click without significant drag), combined with `DragGesture` via `.simultaneousGesture()` or gesture priority
- On drag end, calls `taskStore.updateProgress(taskId, progress)` which persists via SwiftData `ModelContext`

## Implementation Notes
> Traces: `REQ-SLIDE-PROGRESS-002`, `REQ-SLIDE-PROGRESS-003`, `REQ-SLIDE-PROGRESS-007`, `REQ-SLIDE-PROGRESS-008`, `REQ-SLIDE-PROGRESS-009` | `AC-SLIDE-PROGRESS-003`, `AC-SLIDE-PROGRESS-007`, `AC-SLIDE-PROGRESS-008`

- The percentage change per point is relative to the task bar width: `deltaPercent = (deltaX / barWidth) * 100` — bar width obtained via `GeometryReader`
- Dead zone threshold of 10pt is handled by `DragGesture(minimumDistance: 10)` which only triggers `onChanged` after 10pt of movement (D007)
- Gesture disambiguation between click (drill-down) and drag (progress update) is handled by combining `TapGesture` and `DragGesture` with appropriate priority — if drag triggers, tap does not fire
- Gesture state (`isDragging`, `currentProgress`, `baseProgress`) is tracked via `@State` properties on the view, which SwiftUI manages across gesture callbacks
- Gesture exclusivity is handled via `.highPriorityGesture()` or gesture composition to prevent conflicting interactions
- The fill layer uses a SwiftUI animation (`.easeOut(duration: 0.05)`) for smooth visual updates, disabled during active drag via `.transaction { $0.animation = nil }` for direct 1:1 tracking
- Progress is rounded to the nearest integer via `Int(value.rounded())` and clamped to [0, 100] via `min(100, max(0, ...))`
- On drag cancellation, progress reverts to the initial value (last persisted value)

## Phase 2 Dependencies
> Traces: `REQ-SLIDE-PROGRESS-010` | `AC-SLIDE-PROGRESS-009`

- REQ-SLIDE-PROGRESS-010: drag disabled on parent tasks — implementing in Phase 2 (see [subtask-hierarchy](../subtask-hierarchy/README.md) feature, REQ-SUBTASK-HIER-007, D009). The `DragGesture` should be conditionally attached only to leaf tasks (tasks without subtasks).
- Trackpad haptic feedback on supported Macs (deferred, no target phase)
