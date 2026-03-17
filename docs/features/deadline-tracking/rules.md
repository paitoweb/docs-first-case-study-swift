# Deadline Tracking - Business Rules

> Decision tables for the feature.
> Reference: [README.md](README.md) | [Glossary](../../GLOSSARY.md)

## Date Validation Rules
> Traces: `REQ-DEADLINE-001`, `REQ-DEADLINE-002` | `AC-DEADLINE-001`, `AC-DEADLINE-002`

| Condition | Result |
|---|---|
| Start date provided, no end date | Valid, no countdown shown |
| End date provided, no start date | Valid, countdown shown |
| Both dates provided, end >= start | Valid |
| Both dates provided, end < start | Invalid, show error |
| Neither date provided | Valid, no date labels shown |

## Days Left Display Rules
> Traces: `REQ-DEADLINE-005`, `REQ-DEADLINE-006` | `AC-DEADLINE-005`, `AC-DEADLINE-006`

| Days Until End Date | Progress | Display |
|---|---|---|
| > 1 day | Any | "X DAYS LEFT" |
| 1 day | Any | "1 DAY LEFT" |
| 0 days (today) | Any | "TODAY" |
| Negative (past) | < 100% | Overdue indicator |
| Negative (past) | 100% | Completed (no overdue) |

## Date Format Rules
> Traces: `REQ-DEADLINE-003`, `REQ-DEADLINE-004` | `AC-DEADLINE-003`, `AC-DEADLINE-004`

| Element | Format | Example |
|---|---|---|
| Start date label | "START DD MMM YYYY" | "START 12 FEB 2015" |
| End date label | "END DD MMM YYYY" | "END 7 FEB 2015" |
| Days left | "X DAYS LEFT" | "5 DAYS LEFT" |
