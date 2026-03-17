# Deadline Tracking

- Priority: P1
- Status: Complete
- Last updated: 2026-03-14

## Overview

Tasks can have a start date and an end date (deadline). The app displays these dates below each task bar along with a "days left" countdown showing how many days remain until the deadline. This helps users prioritize tasks and stay aware of approaching deadlines. Overdue tasks receive a visual indicator.

## Requirements (REQ-*)

- `REQ-DEADLINE-001` The system MUST allow the user to assign a start date to a task.
- `REQ-DEADLINE-002` The system MUST allow the user to assign an end date (deadline) to a task.
- `REQ-DEADLINE-003` The system MUST display the start date below the task bar in the format "START DD MMM YYYY".
- `REQ-DEADLINE-004` The system MUST display the end date below the task bar in the format "END DD MMM YYYY".
- `REQ-DEADLINE-005` The system MUST display a "X DAYS LEFT" countdown when the task has an end date in the future.
- `REQ-DEADLINE-006` The system MUST visually indicate overdue tasks when the end date has passed and progress is below 100%.

## Acceptance Criteria (AC-*)

### AC-DEADLINE-001 - Assign Start Date (REQ-DEADLINE-001)

- Given the user is creating or editing a task
- When the user selects a start date
- Then the start date is saved and displayed below the task bar

### AC-DEADLINE-002 - Assign End Date (REQ-DEADLINE-002)

- Given the user is creating or editing a task
- When the user selects an end date
- Then the end date is saved and displayed below the task bar

### AC-DEADLINE-003 - Start Date Display Format (REQ-DEADLINE-003)

- Given a task has a start date of February 12, 2015
- When the task is displayed
- Then the text "START 12 FEB 2015" appears below the task bar on the left

### AC-DEADLINE-004 - End Date Display Format (REQ-DEADLINE-004)

- Given a task has an end date of February 7, 2015
- When the task is displayed
- Then the text "END 7 FEB 2015" appears below the task bar on the right

### AC-DEADLINE-005 - Days Left Countdown (REQ-DEADLINE-005)

- Given a task has an end date 5 days from today
- When the task is displayed
- Then the text "5 DAYS LEFT" appears between the start and end date labels

### AC-DEADLINE-006 - Overdue Indicator (REQ-DEADLINE-006)

- Given a task has an end date in the past and progress is below 100%
- When the task is displayed
- Then a visual overdue indicator is shown (e.g., red highlight or "OVERDUE" label)

## Dependencies

- Task management feature (task data model must support date fields)

## Traceability

- Decisions: [`../../DECISIONS.md`](../../DECISIONS.md)
- NFR: [`../../nfr/NON_FUNCTIONAL.md`](../../nfr/NON_FUNCTIONAL.md)

## Non-Scope

- Calendar view or timeline view of tasks
- Recurring deadlines / repeating tasks
- Notification/alarm system for approaching deadlines

## Open Questions

None currently.

## Resolved Questions

- **Dates optional or required**: Dates are optional at task creation and can be set later via "Set Dates" in the right-click context menu
- **Real-time countdown**: "Days left" is calculated on render, not a live countdown — it updates when the view re-renders
- **Less than 1 day remaining**: Displays "TODAY" when 0 days remain; displays "OVERDUE" with red indicator when past due and progress < 100%
