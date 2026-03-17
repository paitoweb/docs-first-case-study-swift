# Color Customization - Flows

> Mermaid diagrams for the main flows of the feature.
> Reference: [README.md](README.md) | [Glossary](../../GLOSSARY.md)

## Change Color Flow
> Traces: `REQ-COLOR-CUSTOM-002`, `REQ-COLOR-CUSTOM-005` | `AC-COLOR-CUSTOM-002`, `AC-COLOR-CUSTOM-005`

```mermaid
flowchart TD
    A[User right-clicks task and selects Change Color] --> B[Color picker popover is shown]
    B --> C[User clicks a color from the palette]
    C --> D[Task color updated in data model]
    D --> E[Task bar re-renders with new color]
    E --> F[Persist color to SwiftData]
```

## Default Color Assignment Flow
> Traces: `REQ-COLOR-CUSTOM-001` | `AC-COLOR-CUSTOM-001`

```mermaid
flowchart TD
    A[New task created] --> B[Assign default color from palette]
    B --> C{Color rotation enabled?}
    C -->|Yes| D[Pick next color in rotation sequence]
    C -->|No| E[Use fixed default color]
    D --> F[Apply color to task bar]
    E --> F
```
