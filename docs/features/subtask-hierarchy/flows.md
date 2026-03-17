# Subtask Hierarchy - Flows

> Mermaid diagrams for the main flows of the feature.
> Reference: [README.md](README.md) | [Glossary](../../GLOSSARY.md)

## Drill-Down Navigation Flow
> Traces: `REQ-SUBTASK-HIER-003` | `AC-SUBTASK-HIER-003`

```mermaid
flowchart TD
    A[User clicks a task bar] --> B[Transition to subtask view]
    B --> C{Task has subtasks?}
    C -->|Yes| D[Display subtasks as task bars]
    C -->|No| E[Show empty state with + button]
    D --> F[Show back navigation control]
    E --> F
```

## Create Subtask Flow
> Traces: `REQ-SUBTASK-HIER-001`, `REQ-SUBTASK-HIER-006` | `AC-SUBTASK-HIER-001`, `AC-SUBTASK-HIER-006`

```mermaid
flowchart TD
    A[User is viewing subtask list of parent task] --> B[User clicks + button or presses Cmd+N]
    B --> C[Input dialog appears]
    C --> D[User enters subtask name]
    D --> E{Name valid?}
    E -->|Yes| F[Create subtask with parentId = current task]
    F --> G[Save to SwiftData]
    G --> H[Update subtask list UI]
    H --> I[Update parent task subtask count badge]
    E -->|No| J[Show validation error]
```

## Navigate Back Flow
> Traces: `REQ-SUBTASK-HIER-004` | `AC-SUBTASK-HIER-004`

```mermaid
flowchart TD
    A[User clicks back button or presses Cmd+[] --> B[Read parent task's parentId]
    B --> C{Parent has a parent?}
    C -->|Yes| D[Transition to grandparent's subtask list]
    C -->|No| E[Transition to top-level task list]
```

## Multi-Level Hierarchy Diagram
> Traces: `REQ-SUBTASK-HIER-002`, `REQ-SUBTASK-HIER-003`, `REQ-SUBTASK-HIER-004` | `AC-SUBTASK-HIER-002`

```mermaid
flowchart TD
    L1[Top-Level Tasks] --> |Click task| L2[Level 2: Subtasks]
    L2 --> |Click subtask| L3[Level 3: Sub-subtasks]
    L3 --> |Back| L2
    L2 --> |Back| L1
```
