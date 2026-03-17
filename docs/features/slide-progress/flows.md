# Slide-to-Progress - Flows

> Mermaid diagrams for the main flows of the feature.
> Reference: [README.md](README.md) | [Glossary](../../GLOSSARY.md)

## Main Slide Flow
> Traces: `REQ-SLIDE-PROGRESS-001` through `REQ-SLIDE-PROGRESS-009` | `AC-SLIDE-PROGRESS-001` through `AC-SLIDE-PROGRESS-008`

```mermaid
flowchart TD
    A[Mouse down / Drag began on task bar] --> B[Record initial drag position]
    B --> C[Drag changed event]
    C --> D{Horizontal displacement > 10pt threshold?}
    D -->|No| E[Treat as click if released — drill-down]
    D -->|Yes| G[Lock gesture as horizontal drag]
    G --> H[Calculate delta X from initial position]
    H --> I[Map delta X to progress percentage change]
    I --> J{New value < 0?}
    J -->|Yes| K[Clamp to 0%]
    J -->|No| L{New value > 100?}
    L -->|Yes| M[Clamp to 100%]
    L -->|No| N[Set new progress value]
    K --> O[Update task bar fill + percentage display]
    M --> O
    N --> O
    O --> P{Drag ended / Mouse up?}
    P -->|No| C
    P -->|Yes| Q[Persist final progress to SwiftData]
```

## Gesture Disambiguation Flow
> Traces: `REQ-SLIDE-PROGRESS-008` | `AC-SLIDE-PROGRESS-007`

```mermaid
flowchart TD
    A[Mouse down on task bar] --> B[Record start position]
    B --> C[Mouse moved / Drag changed]
    C --> D[Calculate displacement]
    D --> E{Displacement > 10pt horizontally?}
    E -->|Yes| F[Horizontal drag: trigger progress update]
    E -->|No| G{Mouse released?}
    G -->|Yes| H[Single click: trigger drill-down]
    G -->|No| C
```
