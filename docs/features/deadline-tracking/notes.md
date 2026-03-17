# Deadline Tracking - Technical Notes

## Flow Inputs

- User-selected start date and end date from SwiftUI `DatePicker`
- Current system date for "days left" calculation

## Component Connections
> Traces: `REQ-DEADLINE-001`, `REQ-DEADLINE-002`, `REQ-DEADLINE-005`

- Task data model stores startDate and endDate as Swift `Date?` values in SwiftData
- `TaskBarView` renders date labels and countdown below the colored bar
- Days-left calculation runs on render (no live timer needed for v1)

## Implementation Notes
> Traces: `REQ-DEADLINE-003`, `REQ-DEADLINE-004`, `REQ-DEADLINE-005` | `AC-DEADLINE-003`, `AC-DEADLINE-004`, `AC-DEADLINE-005`

- Dates are stored as Swift `Date?` values in SwiftData; formatted to ISO 8601 for display and export
- Display format uses abbreviated month names: JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC (via Swift `DateFormatter` or `.formatted()`)
- The date labels appear in a row below the task bar: START on the left, DAYS LEFT in the center, END on the right (via `HStack` with `Spacer`)
- From the reference images, the date row has a slightly smaller font size and appears in a contrasting color on the task bar's lower section
- Days-left is recalculated each time the task list renders (not a live countdown)
