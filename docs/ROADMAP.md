# Roadmap

Last updated: 2026-03-15 (Phase 3 complete)

## Phase 0 - Documentation Foundation [COMPLETE]

- [x] Define all features with requirements, acceptance criteria, flows, and rules
- [x] Establish architecture decisions and NFRs
- [x] Set up MkDocs documentation site

## Phase 1 - Core Functionality (MVP) [COMPLETE]

- [x] Xcode project setup with SwiftUI App lifecycle
- [x] SwiftData model and persistence layer (`SlidooTask`, `TaskStore`)
- [x] Task creation and listing
- [x] Slide-to-progress drag gesture engine (10pt dead zone, integer 0–100%)
- [x] Task list UI with colored progress bars
- [x] Default color assignment (round-robin from 7-color palette)
- [x] Task editing (rename via right-click context menu)
- [x] Task deletion (with confirmation dialog)
- [x] Keyboard shortcuts (Cmd+N working; Cmd+F, Cmd+E stubbed for Phase 3)
- [x] macOS menu bar integration

## Phase 2 - Hierarchy & Organization [COMPLETE]

- [x] Subtask hierarchy (multi-level nesting, up to 5 levels)
- [x] Drill-down navigation between task levels (NavigationStack)
- [x] Progress rollup from subtasks to parent (auto-average)
- [x] Color customization per task (ColorPickerView)

## Phase 3 - Deadlines & Awareness [COMPLETE]

- [x] Start date and end date assignment (SwiftUI DatePicker)
- [x] "Days left" countdown display
- [x] Overdue task indicators
- [x] Search and filtering (.searchable modifier)
- [x] JSON export (Codable + NSSavePanel)

## Phase 4 - Sync & Cloud [NEXT]

- [ ] User authentication (Apple ID)
- [ ] CloudKit sync with conflict resolution
- [ ] Mac App Store distribution (or direct download)
