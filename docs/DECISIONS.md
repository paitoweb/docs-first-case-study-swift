# Decisions (Lightweight ADR)

Format:

- Record: date of record
- Decision: what was decided
- Status: Active, Review, Superseded
- Context: why it was decided
- Consequences: expected impacts

---

## D001 - Native macOS desktop application

Record: 2026-03-14
Decision: Slidoo will be built as a native macOS desktop application using Swift and SwiftUI.
Status: Active
Context: The core slide gesture interaction maps naturally to click-and-drag on macOS trackpad and mouse. Building a native macOS app provides optimal performance, native system integration (menu bar, keyboard shortcuts, window management), and access to SwiftData for local persistence. Minimum target: macOS 14 (Sonoma).
Consequences: Xcode project with SwiftUI lifecycle. Window resizable with minimum 800×600. Distribution via Mac App Store or direct download. iOS/iPadOS may be explored later via Catalyst or native port.

---

## D002 - English-only documentation and UI

Record: 2026-03-14
Decision: All project documentation, code comments, and UI text will be written exclusively in English.
Status: Active
Context: The project targets a global audience and the development team operates in English. Maintaining a single language reduces translation overhead and ambiguity.
Consequences: No i18n infrastructure needed for v1. All documentation files use English section headers and content.

---

## D003 - Offline-first with SwiftData

Record: 2026-03-14
Decision: The app will use SwiftData as the primary data store for the MVP, with `ModelContainer` managing persistence. Optional cloud sync via CloudKit planned for Phase 4.
Status: Active
Context: The drag gesture must respond instantly without waiting for server roundtrips. Local-first ensures the app is always functional. SwiftData was chosen for its native Swift integration, `@Model` macro support, and automatic persistence with minimal boilerplate. It requires macOS 14+, which aligns with D001.
Consequences: Sync conflict resolution strategy needed for Phase 4 (CloudKit integration). `TaskStore` (`@Observable` class) provides all CRUD operations via SwiftData `ModelContext`.

---

## D004 - Horizontal drag gesture for progress updates

Record: 2026-03-14
Decision: The primary interaction for updating task progress will be a horizontal click-and-drag on the task bar.
Status: Active
Context: This is the core differentiator of Slidoo. It provides an intuitive way to express partial progress without forms or number inputs. The gesture maps naturally to the visual progress bar metaphor. On macOS, the user clicks on the task bar and drags left/right, preserving the "slide" brand identity.
Consequences: Must handle gesture disambiguation between single click (drill-down) and click-and-drag (progress update). Need drag threshold (10pt) to distinguish click from drag. SwiftUI `DragGesture` is the core interaction component.

---

## D005 - SwiftUI with Xcode

Record: 2026-03-14
Decision: The application will be built with SwiftUI using the Swift language, managed in Xcode.
Status: Active
Context: SwiftUI offers declarative UI, native macOS integration (menu bar, keyboard shortcuts, window management), and excellent performance. The `@Observable` macro (macOS 14+) provides clean reactive state management. The view hierarchy maps naturally to the task bar / task list / drill-down UI structure.
Consequences: Xcode project with SwiftUI App lifecycle. Dependencies managed via Swift Package Manager. Testing with XCTest + XCUITest (or Swift Testing framework).

---

## D006 - Integer percentage progress (0–100)

Record: 2026-03-14
Decision: Task progress is stored and displayed as an integer percentage (0–100), not snapped to 5% increments.
Status: Active
Context: Integer granularity gives users fine-grained control while keeping the data model simple. Snapping to 5% was considered but felt too coarse for short task lists.
Consequences: Progress field is an integer clamped to [0, 100]. No rounding logic needed in the gesture engine beyond `Int(rounded)`.

---

## D007 - Dead zone threshold of 10pt

Record: 2026-03-14
Decision: The gesture engine uses a 10pt dead zone to disambiguate click-and-drag (progress update) from single click (drill-down).
Status: Active
Context: Below 10pt of drag displacement, the gesture engine does not commit to a drag interaction. Once 10pt is exceeded horizontally, the interaction is treated as a progress drag for the rest of the gesture sequence. 10pt is a standard starting point; can be tuned after user testing.
Consequences: Mouse movement within 10pt is treated as a click (drill-down). Drag threshold is evaluated once at gesture start, not re-evaluated per frame.

---

## D008 - Maximum 5 levels of subtask nesting

Record: 2026-03-14
Decision: The subtask hierarchy is capped at 5 levels deep (level 1 = top-level task, level 5 = deepest subtask).
Status: Active
Context: Deeper nesting provides diminishing organizational value and increases UI complexity. 5 levels covers virtually all real-world use cases (project > milestone > task > subtask > checklist item).
Consequences: The (+) button is hidden or disabled when viewing tasks at level 5. Data model enforces depth constraint on creation.

---

## D009 - Hybrid progress rollup

Record: 2026-03-14
Decision: Tasks without subtasks have manual progress (set via drag gesture). Tasks with subtasks have their progress auto-calculated as the arithmetic average of their direct children's progress.
Status: Active
Context: Manual-only would require users to update parent tasks separately, which is tedious. Full auto-rollup makes the slide gesture meaningful at leaf level while keeping parent progress accurate. The average of direct children (not deep descendants) keeps the calculation simple and predictable.
Consequences: Drag gesture is disabled on parent tasks that have subtasks (progress is read-only, computed). When a task's last subtask is deleted, the task reverts to manual progress at its last computed value. Adding subtasks to a previously manual task switches it to auto-rollup.

---

## D010 - Task name max length 100 characters

Record: 2026-03-14
Decision: Task names are limited to 100 characters. Names exceeding this limit are truncated on display with an ellipsis.
Status: Active
Context: 100 characters is generous enough for descriptive names while preventing abuse. Truncation on display (not on input) means the full name is preserved in storage and visible on edit.
Consequences: Input allows up to 100 characters (enforced via SwiftUI `.onChange` modifier). Display truncates with ellipsis if the rendered text overflows the task bar width. Full name shown on click/edit.

---

## D011 - Right-click context menu for task actions

Record: 2026-03-14
Decision: Task actions (Rename, Change Color, Set Dates, Delete) are accessed via right-click (secondary click) context menu on the task bar.
Status: Active
Context: On macOS, right-click context menus are the standard pattern for contextual actions on interactive elements. This replaces the mobile long-press (500ms) interaction pattern. SwiftUI provides the `.contextMenu` modifier for native implementation.
Consequences: No long-press detection needed. Context menu renders natively via macOS. All task actions are accessible via right-click on any task bar.

---

## D012 - Keyboard shortcuts for common actions

Record: 2026-03-14
Decision: The app provides standard macOS keyboard shortcuts for common actions: Cmd+N (new task), Cmd+F (search), Cmd+E (export), Cmd+[ (navigate back), Delete/Backspace (delete task), Escape (cancel/dismiss), Return (confirm input).
Status: Active
Context: macOS users expect keyboard-driven workflows. Keyboard shortcuts complement mouse/trackpad interactions and improve power-user efficiency. SwiftUI provides `.keyboardShortcut()` modifier for native implementation.
Consequences: Keyboard shortcuts are documented in the app's menu bar. Menu bar follows standard macOS structure (File, Edit, View, Window, Help).

---

## D013 - Dark-only theme

Record: 2026-03-14
Decision: The app uses a dark-only theme (dark navy #1B2838 background) for v1. System-adaptive light mode is deferred to a future release.
Status: Active
Context: The dark theme is a core part of the Slidoo visual identity. Supporting both themes doubles the design token work. Dark-only simplifies the initial design system while maintaining the distinctive look.
Consequences: App forces dark appearance via `.preferredColorScheme(.dark)`. All color tokens are defined for dark mode only. Light mode support may be added in a future version.
