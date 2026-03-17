# Colors

> Reference: [README.md](README.md) | [Color Customization feature](../features/color-customization/README.md) | [Glossary](../GLOSSARY.md)

## Background & Surface Colors

| Token | Value | Usage |
|---|---|---|
| `Color.slidooBg` | `#1B2838` | App background (dark navy) |
| `Color.slidooHeader` | `rgba(0, 0, 0, 0.3)` | Header and form background (semi-transparent black overlay) |

## Text Colors

| Token | Value | Usage |
|---|---|---|
| `Color.slidooText` | `#FFFFFF` | Primary text (task names, progress %, headings) |
| `Color.slidooTextSecondary` | `rgba(255, 255, 255, 0.7)` | Secondary text (empty state subtitle, cancel button, placeholder) |

## Input Colors

| Token | Value | Usage |
|---|---|---|
| `Color.slidooInputBg` | `rgba(255, 255, 255, 0.1)` | Text input background |
| `Color.slidooInputBorder` | `rgba(255, 255, 255, 0.2)` | Text input border (default state) |

## Semantic Colors

| Value | Usage | View |
|---|---|---|
| `#4A90D9` | Submit / primary action button background | `TaskCreateSheet` |
| `#E74C3C` | Error text (validation messages) | `TaskCreateSheet` |
| `rgba(255, 255, 255, 0.15)` | Button active/pressed state | `HeaderView` |
| `rgba(255, 255, 255, 0.5)` | Input focus border | `TaskCreateSheet` |
| `rgba(255, 255, 255, 0.1)` | Cancel button background | `TaskCreateSheet` |

## Task Color Palette

The 7-color palette used for task bar coloring. Colors are assigned sequentially (round-robin) on task creation. Defined as a `TaskColor` enum or constant array.

| Index | Name | Hex | Swatch | Usage Example |
|---|---|---|---|---|
| 0 | Blue (dark) | `#4A90D9` | | Default / general tasks |
| 1 | Blue (light) | `#5BA8C8` | | Alternate tasks |
| 2 | Green | `#2ECC71` | | Active / in-progress |
| 3 | Purple | `#9B59B6` | | School / study tasks |
| 4 | Orange | `#E67E22` | | Fitness / workout |
| 5 | Yellow-green | `#A8D858` | | Projects |
| 6 | Teal | `#1ABC9C` | | Design tasks |

> See also: [Color Customization rules](../features/color-customization/rules.md) for color assignment and display rules.

## Task Bar Color Layers

Each task bar uses two color layers derived from its assigned task color:

| Layer | Derivation | SwiftUI Implementation | Visual Role |
|---|---|---|---|
| Fill (progress) | Task color at full opacity | `Color(hex: task.color)` | Filled portion representing progress (0–100%) |
| Background (remaining) | Task color at ~20% opacity | `Color(hex: task.color).opacity(0.2)` | Unfilled portion of the bar |

## Dark Appearance

The app enforces dark appearance via `.preferredColorScheme(.dark)` on the root `WindowGroup` (D013). All color tokens are defined for dark mode only.

## Color Accessibility Notes

- All text is white (`#FFFFFF`) on colored backgrounds — contrast ratios should be verified against each palette color
- The dark background (`#1B2838`) provides high contrast with white text
- Error color (`#E74C3C`) on dark background meets WCAG AA contrast requirements
- VoiceOver accessibility labels should not rely on color alone (NFR-009)
