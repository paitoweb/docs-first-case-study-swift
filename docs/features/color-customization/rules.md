# Color Customization - Business Rules

> Decision tables for the feature.
> Reference: [README.md](README.md) | [Glossary](../../GLOSSARY.md) | [Design System — Colors](../../design-system/colors.md)

## Color Assignment Rules
> Traces: `REQ-COLOR-CUSTOM-001` | `AC-COLOR-CUSTOM-001`

| Condition | Result |
|---|---|
| New task created, no color specified | Assign default color |
| User selects color from palette | Apply selected color immediately |
| User creates subtask | Subtask gets its own default color (does not inherit parent) |

## Color Display Rules
> Traces: `REQ-COLOR-CUSTOM-003` | `AC-COLOR-CUSTOM-003`

| Progress | Color Fill |
|---|---|
| 0% | No color fill (empty bar) |
| 1-99% | Color fills proportionally from left to right |
| 100% | Full bar filled with color |

## Predefined Palette
> Traces: `REQ-COLOR-CUSTOM-004` | `AC-COLOR-CUSTOM-004`

7 colors assigned via sequential round-robin on task creation. Full hex values and implementation details in the [Design System — Colors](../../design-system/colors.md).

| Index | Color Name | Hex | Use Case Example |
|---|---|---|---|
| 0 | Blue (dark) | `#4A90D9` | Default / general tasks |
| 1 | Blue (light) | `#5BA8C8` | Alternate tasks |
| 2 | Green | `#2ECC71` | Active / in-progress |
| 3 | Purple | `#9B59B6` | School / study tasks |
| 4 | Orange | `#E67E22` | Fitness / workout |
| 5 | Yellow-green | `#A8D858` | Projects |
| 6 | Teal | `#1ABC9C` | Design tasks |

## Task Bar Color Layers
> Traces: `REQ-COLOR-CUSTOM-003` | `AC-COLOR-CUSTOM-003`

Each task bar renders two color layers. See [Design System — Components](../../design-system/components.md) for full specs.

| Layer | Derivation | Visual Role |
|---|---|---|
| Fill | Task color at 100% opacity | Progress portion (width = progress %) |
| Background | Task color at ~20% opacity | Remaining unfilled portion |
