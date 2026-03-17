# Design System

- Status: Active
- Last updated: 2026-03-14

## Purpose

Centralize all visual design decisions, tokens, and component specifications for Slidoo. This document serves as the single source of truth for the app's look and feel, ensuring consistency across all components.

Slidoo uses **SwiftUI `Color` and `Font` extensions** as its token layer. Component-level styles use **custom `ViewModifier`s** scoped to each view.

## Design Principles

- **Desktop-native**: designed for macOS desktop windows (min 800×600, resizable, per D001 and NFR-005)
- **Dark theme**: dark navy background with white text for a focused desktop experience (D013)
- **Color-coded tasks**: each task has a distinct color from a 7-color palette for visual categorization
- **Gesture-first**: the primary interaction is click-and-drag (drag gesture), complemented by keyboard shortcuts and context menus
- **Minimal chrome**: minimal UI decoration; the colored task bars ARE the UI

## Token Categories

| Category | Document | Description |
|---|---|---|
| Colors | [colors.md](colors.md) | Background, text, task palette, semantic colors |
| Typography | [typography.md](typography.md) | Font family, sizes, weights, line heights |
| Spacing & Layout | [spacing.md](spacing.md) | Spacing scale, component dimensions, layout constraints |
| Components | [components.md](components.md) | Visual specifications for each UI component |

## Token Implementation

Tokens are implemented as SwiftUI `Color` and `Font` extensions in a `DesignTokens.swift` file. Some values may be defined inline in views during early development and are noted as extraction candidates in the relevant token documents.

### SwiftUI Extension Convention

| Extension | Category | Example |
|---|---|---|
| `Color.slidoo*` | Color tokens | `Color.slidooBg`, `Color.slidooText` |
| `Font.slidoo*` | Typography tokens | `Font.slidooTitle`, `Font.slidooBody` |
| `CGFloat.slidoo*` | Spacing tokens | `CGFloat.slidooHeaderHeight`, `CGFloat.slidooTaskBarHeight` |

### Dynamic Tokens (per-component)

The `TaskBarView` applies dynamic values via SwiftUI modifiers:

| Property | Source | Description |
|---|---|---|
| Fill color | `task.color` | The task's assigned hex color at full opacity |
| Background color | `task.color` at 20% opacity | The task's color at ~20% opacity (unfilled portion) |
| Fill width | `currentProgress` as fraction of bar width | The progress fill width via `GeometryReader` |

## Cross-References

- Architecture: [`../ARCHITECTURE.md`](../ARCHITECTURE.md) — tech stack, data model
- Color Customization feature: [`../features/color-customization/README.md`](../features/color-customization/README.md) — requirements for the color picker (Phase 2)
- NFR-005 (window size): [`../nfr/NON_FUNCTIONAL.md`](../nfr/NON_FUNCTIONAL.md) — window size constraints
- Glossary: [`../GLOSSARY.md`](../GLOSSARY.md) — domain terms (Task Bar, Task Color, etc.)
