# Backlog

Last updated: 2026-03-15 (Phase 3 complete)

## P0 [COMPLETE]

- [x] Set up Xcode project with SwiftUI App lifecycle and SwiftData
- [x] Implement task creation and listing
- [x] Implement slide-to-progress drag gesture engine
- [x] Build task bar UI view with progress visualization
- [x] Set up SwiftData persistence (`SlidooTask` model, `TaskStore`)
- [x] Implement right-click context menu (Rename, Change Color, Set Dates, Delete)
- [x] Implement task editing (rename)
- [x] Implement task deletion
- [x] Add keyboard shortcuts (Cmd+N, Cmd+F, Cmd+E, Cmd+[, Delete, Escape, Return)
- [x] Implement macOS menu bar (File, Edit, View, Window, Help)

## P1

### Phase 2 — Hierarchy & Organization [COMPLETE]
- [x] Implement subtask creation and drill-down navigation
- [x] Implement multi-level subtask hierarchy (3+ levels)
- [x] Add progress rollup calculation from subtasks to parent
- [x] Implement color customization with color picker

### Phase 3 — Deadlines & Awareness [COMPLETE]
- [x] Add start date and end date to tasks
- [x] Implement "days left" countdown display
- [x] Handle overdue task visual indicators

## P2

- [x] Implement task search and filtering (.searchable modifier)
- [x] Add data export functionality (JSON via NSSavePanel)
- [ ] Build user authentication flow (Apple ID)
- [ ] Implement CloudKit sync service
- [ ] Add sync conflict resolution (last-write-wins)
- [ ] Mac App Store distribution
- [ ] Add trackpad haptic feedback for drag gesture (if supported)
- [ ] Implement task auto-archive for completed tasks
