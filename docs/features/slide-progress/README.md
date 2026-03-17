# Slide-to-Progress

- Priority: P0
- Status: Complete
- Last updated: 2026-03-14

## Overview

The core differentiating feature of Slidoo. Users update task completion by performing a horizontal click-and-drag gesture on a task bar. Dragging right increases progress; dragging left decreases it. The task bar's color fill updates in real-time as the user drags, and the percentage value updates accordingly. This replaces traditional form inputs or manual number entry with an intuitive, visual interaction.

## Requirements (REQ-*)

- `REQ-SLIDE-PROGRESS-001` The system MUST detect a horizontal drag gesture on any task bar.
- `REQ-SLIDE-PROGRESS-002` The system MUST increase the task's progress percentage when the user drags right.
- `REQ-SLIDE-PROGRESS-003` The system MUST decrease the task's progress percentage when the user drags left.
- `REQ-SLIDE-PROGRESS-004` The system MUST update the task bar's color fill in real-time during the drag gesture.
- `REQ-SLIDE-PROGRESS-005` The system MUST display the updated percentage value in real-time during the drag.
- `REQ-SLIDE-PROGRESS-006` The system MUST persist the final progress value when the user releases the mouse button (drag end).
- `REQ-SLIDE-PROGRESS-007` The system MUST clamp progress values between 0% and 100%.
- `REQ-SLIDE-PROGRESS-008` The system MUST distinguish between a horizontal drag gesture (progress update) and a single click (drill-down) using a 10pt dead zone threshold.
- `REQ-SLIDE-PROGRESS-009` The system MUST store progress as an integer percentage (0–100), rounded to the nearest integer.
- `REQ-SLIDE-PROGRESS-010` The system MUST disable the drag gesture on parent tasks whose progress is auto-calculated from subtasks.

## Acceptance Criteria (AC-*)

### AC-SLIDE-PROGRESS-001 - Drag Right to Increase (REQ-SLIDE-PROGRESS-001, REQ-SLIDE-PROGRESS-002)

- Given a task bar is displayed with current progress at X%
- When the user clicks the task bar and drags horizontally to the right
- Then the progress percentage increases proportionally to the drag distance

### AC-SLIDE-PROGRESS-002 - Drag Left to Decrease (REQ-SLIDE-PROGRESS-001, REQ-SLIDE-PROGRESS-003)

- Given a task bar is displayed with current progress at X%
- When the user clicks the task bar and drags horizontally to the left
- Then the progress percentage decreases proportionally to the drag distance

### AC-SLIDE-PROGRESS-003 - Real-Time Visual Feedback (REQ-SLIDE-PROGRESS-004, REQ-SLIDE-PROGRESS-005)

- Given the user is performing a drag gesture on a task bar
- When the mouse moves horizontally
- Then the color fill width and percentage number update continuously in real-time (within 16ms / 60fps)

### AC-SLIDE-PROGRESS-004 - Persist on Release (REQ-SLIDE-PROGRESS-006)

- Given the user is dragging on a task bar
- When the user releases the mouse button (drag end)
- Then the current progress value is saved to SwiftData

### AC-SLIDE-PROGRESS-005 - Clamped Range (REQ-SLIDE-PROGRESS-007)

- Given a task bar at 0% progress
- When the user drags left
- Then the progress remains at 0% and does not go negative

### AC-SLIDE-PROGRESS-006 - Clamped Maximum (REQ-SLIDE-PROGRESS-007)

- Given a task bar at 100% progress
- When the user drags right
- Then the progress remains at 100% and does not exceed it

### AC-SLIDE-PROGRESS-007 - Gesture vs Click Disambiguation (REQ-SLIDE-PROGRESS-008)

- Given the user clicks on a task bar
- When the drag displacement is less than 10pt in any direction
- Then the interaction is treated as a click (drill-down), not a drag (progress update)

- Given the user clicks on a task bar
- When the drag displacement exceeds 10pt horizontally
- Then the gesture engine triggers progress update via drag

### AC-SLIDE-PROGRESS-008 - Integer Progress Storage (REQ-SLIDE-PROGRESS-009)

- Given the user drags on a task bar
- When the calculated progress has a fractional component
- Then the value is rounded to the nearest integer before display and storage

### AC-SLIDE-PROGRESS-009 - Drag Disabled on Parent Tasks (REQ-SLIDE-PROGRESS-010)

- Given a task has one or more subtasks
- When the user attempts to drag on the parent task bar
- Then the drag gesture is ignored and the progress remains auto-calculated from subtasks

## Dependencies

- SwiftUI `DragGesture` API for gesture handling
- Task management feature (provides task bars to attach gestures to)

## Traceability

- Decisions: [`../../DECISIONS.md`](../../DECISIONS.md) (D004 - Horizontal drag gesture)
- NFR: [`../../nfr/NON_FUNCTIONAL.md`](../../nfr/NON_FUNCTIONAL.md) (NFR-002 - Gesture responsiveness < 16ms / 60fps)

## Non-Scope

- Multi-touch gestures (pinch, rotate)
- Apple Pencil or external input device support
- Snap-to-5% increments (progress is continuous integer 0–100, see D006)

## Open Questions

- Should the drag gesture provide trackpad haptic feedback on supported Macs?

## Resolved Questions

- **Progress granularity**: integer percentage 0–100, no snapping (D006)
- **Dead zone threshold**: 10pt before committing to drag vs click direction (D007)
- **Parent task drag**: disabled when task has subtasks — progress is auto-calculated (D009)
