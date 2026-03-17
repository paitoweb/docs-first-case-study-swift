# Color Customization

- Priority: P1
- Status: Complete
- Last updated: 2026-03-14

## Overview

Each task in Slidoo has a customizable color that is applied to its task bar. Colors help users visually categorize and distinguish tasks at a glance. The color fills proportionally to the task's progress percentage, creating a visual representation of completion. Users can change a task's color quickly through a color picker interface.

## Requirements (REQ-*)

- `REQ-COLOR-CUSTOM-001` The system MUST assign a default color to newly created tasks.
- `REQ-COLOR-CUSTOM-002` The system MUST allow the user to change a task's color.
- `REQ-COLOR-CUSTOM-003` The system MUST display the task bar filled with the assigned color proportional to progress.
- `REQ-COLOR-CUSTOM-004` The system MUST provide a set of predefined colors for quick selection.
- `REQ-COLOR-CUSTOM-005` The system MUST persist the color assignment across sessions.

## Acceptance Criteria (AC-*)

### AC-COLOR-CUSTOM-001 - Default Color Assignment (REQ-COLOR-CUSTOM-001)

- Given the user creates a new task
- When the task is displayed for the first time
- Then it has a default color applied to the task bar

### AC-COLOR-CUSTOM-002 - Change Task Color (REQ-COLOR-CUSTOM-002)

- Given the user selects a task for editing
- When the user chooses a new color from the color picker
- Then the task bar immediately updates to display the new color

### AC-COLOR-CUSTOM-003 - Color Fill Proportional to Progress (REQ-COLOR-CUSTOM-003)

- Given a task has a color and 60% progress
- When the task bar is rendered
- Then 60% of the bar width is filled with the task's color and 40% shows the unfilled background

### AC-COLOR-CUSTOM-004 - Predefined Color Palette (REQ-COLOR-CUSTOM-004)

- Given the user opens the color picker
- When the color options are displayed
- Then a set of predefined colors is shown (matching the app's visual style)

### AC-COLOR-CUSTOM-005 - Color Persistence (REQ-COLOR-CUSTOM-005)

- Given the user assigns a color to a task
- When the user closes and reopens the app
- Then the task retains its assigned color

## Dependencies

- Task management feature (task data model must support a color field)

## Traceability

- Decisions: [`../../DECISIONS.md`](../../DECISIONS.md)
- NFR: [`../../nfr/NON_FUNCTIONAL.md`](../../nfr/NON_FUNCTIONAL.md)
- Design System — Colors: [`../../design-system/colors.md`](../../design-system/colors.md)
- Design System — Components (TaskBar layers): [`../../design-system/components.md`](../../design-system/components.md)

## Non-Scope

- Custom RGB/hex color input (predefined palette only in v1)
- Color themes or dark mode
- Color inheritance from parent to subtasks

## Open Questions

None currently.

## Resolved Questions

- **Palette size**: 7 predefined colors (see [Design System — Colors](../../design-system/colors.md))
- **Default color assignment**: sequential round-robin through the palette on task creation (implemented in `TaskStore`)
- **Subtask color inheritance**: Subtasks get their own default color (round-robin), no inheritance from parent. Color inheritance is explicitly non-scope for v1
