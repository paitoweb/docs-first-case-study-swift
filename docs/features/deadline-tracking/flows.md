# Deadline Tracking - Flows

> Mermaid diagrams for the main flows of the feature.
> Reference: [README.md](README.md) | [Glossary](../../GLOSSARY.md)

## Assign Dates Flow
> Traces: `REQ-DEADLINE-001`, `REQ-DEADLINE-002` | `AC-DEADLINE-001`, `AC-DEADLINE-002`

```mermaid
flowchart TD
    A[User creates or edits a task] --> B[SwiftUI DatePicker shown]
    B --> C[User selects start date]
    C --> D[User selects end date]
    D --> E{End date >= Start date?}
    E -->|Yes| F[Save dates to task]
    F --> G[Update task bar with date labels and countdown]
    E -->|No| H[Show validation error: end must be after start]
```

## Days Left Calculation Flow
> Traces: `REQ-DEADLINE-005`, `REQ-DEADLINE-006` | `AC-DEADLINE-005`, `AC-DEADLINE-006`

```mermaid
flowchart TD
    A[Task has an end date] --> B[Calculate difference: end date - today]
    B --> C{Difference > 0?}
    C -->|Yes| D[Display 'X DAYS LEFT']
    C -->|No| E{Difference == 0?}
    E -->|Yes| F[Display 'TODAY' or '0 DAYS LEFT']
    E -->|No| G{Progress < 100%?}
    G -->|Yes| H[Display overdue indicator]
    G -->|No| I[Task completed, no overdue]
```
