# Task Management - Flows

> Mermaid diagrams for the main flows of the feature.
> Reference: [README.md](README.md) | [Glossary](../../GLOSSARY.md)

## Create Task Flow
> Traces: `REQ-TASK-MGMT-001`, `REQ-TASK-MGMT-007` | `AC-TASK-MGMT-001`

```mermaid
flowchart TD
    A[User clicks + button or presses Cmd+N] --> B[Task create sheet appears]
    B --> C[User enters task name]
    C --> D{Name valid?}
    D -->|Yes| E[Create task with 0% progress]
    E --> F[Assign default color]
    F --> G[Save to SwiftData]
    G --> H[Update task list UI]
    D -->|No / Empty| I[Show validation error]
    I --> B
```

## Right-Click Context Menu Flow
> Traces: `REQ-TASK-MGMT-009` | `AC-TASK-MGMT-007`

```mermaid
flowchart TD
    A[User right-clicks task bar] --> D[Show context menu: Rename / Change Color / Set Dates / Delete]
    D --> E{User selects action}
    E -->|Rename| F[Enter inline rename mode]
    E -->|Change Color| F2[Show color picker popover]
    E -->|Set Dates| F3[Show date edit sheet]
    E -->|Delete| G[Enter delete confirmation flow]
    E -->|Dismiss| H[Close menu, return to list]
```

## Edit Task (Rename) Flow
> Traces: `REQ-TASK-MGMT-004` | `AC-TASK-MGMT-003`, `AC-TASK-MGMT-008`, `AC-TASK-MGMT-009`

```mermaid
flowchart TD
    A[User selects Rename from context menu] --> B[Task name becomes editable inline TextField]
    B --> C[TextField pre-filled with current name, focused]
    C --> D{User action}
    D -->|Confirms new name via Return| E{Name valid?}
    E -->|Yes: non-empty, ≤ 100 chars| F[Update task name in SwiftData]
    F --> G[Refresh updatedAt timestamp]
    G --> H[Update task bar UI with new name]
    E -->|No: empty or whitespace| I[Show validation error]
    I --> C
    D -->|Cancels via Escape or clicks outside| J[Restore original name, discard changes]
```

## Delete Task Flow
> Traces: `REQ-TASK-MGMT-005` | `AC-TASK-MGMT-004`, `AC-TASK-MGMT-010`

```mermaid
flowchart TD
    A[User triggers delete action] --> B{Task has subtasks?}
    B -->|Yes| C[Confirm: delete task and all subtasks?]
    B -->|No| D[Confirm: delete task?]
    C --> E{User confirms?}
    D --> E
    E -->|Yes| F[Remove task and subtasks from SwiftData]
    F --> G[Update task list UI]
    E -->|No| H[Cancel, return to list]
```

## Task List Display Flow
> Traces: `REQ-TASK-MGMT-002`, `REQ-TASK-MGMT-003`, `REQ-TASK-MGMT-006` | `AC-TASK-MGMT-002`, `AC-TASK-MGMT-005`

```mermaid
flowchart TD
    A[App launches] --> B[Read tasks from SwiftData]
    B --> C{Tasks exist?}
    C -->|Yes| D[Render task bars with name + progress + color]
    C -->|No| E[Show empty state]
    D --> F[Attach gesture and context menu to each bar]
```
