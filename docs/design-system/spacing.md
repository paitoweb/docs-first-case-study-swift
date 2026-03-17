# Spacing & Layout

> Reference: [README.md](README.md) | [NFR-005 (window size)](../nfr/NON_FUNCTIONAL.md)

## Window Constraints

| Property | Value | Source |
|---|---|---|
| Min window width | `800pt` | NFR-005 |
| Min window height | `600pt` | NFR-005 |
| Resizable | Yes | D001 (macOS desktop) |
| Content scaling | Task bars stretch to fill available width | `WindowGroup` configuration |

The app window is resizable with a minimum size of 800×600 points. Task bars fill the available width.

## Layout Structure

The app uses a vertical layout filling the full window height:

```
┌──────────────────────────────────────────┐
│            Header / Toolbar (56pt)       │  ← fixed height
├──────────────────────────────────────────┤
│         TaskCreateSheet (auto)           │  ← conditional (sheet/popover)
├──────────────────────────────────────────┤
│                                          │
│         TaskList or EmptyState           │  ← fills remaining space, scrollable
│                                          │
│              TaskBar (64pt)              │
│              TaskBar (64pt)              │
│              TaskBar (64pt)              │
│                                          │
└──────────────────────────────────────────┘
```

## Dimension Tokens

| Token | Value | Usage |
|---|---|---|
| `headerHeight` | `56pt` | Header bar height |
| `taskBarHeight` | `64pt` | Individual task bar height |
| `taskBarGap` | `8pt` | Vertical gap between task bars |
| `paddingX` | `20pt` | Horizontal page padding (left/right) |
| `borderRadius` | `0` | Border radius for task bars |

## Component Dimensions

| Value | Usage | View |
|---|---|---|
| `40pt × 40pt` | Add button (circular) | `HeaderView` |
| `40pt` | Header spacer (balances the + button for centered title) | `HeaderView` |

## Spacing Values Used

### Padding

| Value | Usage | View |
|---|---|---|
| `20pt` | Page horizontal padding | `HeaderView`, `EmptyStateView` |
| `16pt` | Task bar content horizontal padding | `TaskBarView` content |
| `12pt` | Form vertical padding | `TaskCreateSheet` |
| `12pt` | Text input internal padding | `TaskCreateSheet` `TextField` |
| `10pt` | Action button internal padding | `TaskCreateSheet` buttons |

### Margins & Gaps

| Value | Usage | View |
|---|---|---|
| `8pt` | Gap between task bars | `TaskListView` (via `LazyVStack(spacing:)`) |
| `8pt` | Gap between form action buttons | `TaskCreateSheet` actions |
| `8pt` | Margin-top for form action row | `TaskCreateSheet` actions |
| `8pt` | Margin-bottom below empty state title | `EmptyStateView` title |
| `12pt` | Right margin on task name (before progress %) | `TaskBarView` name |
| `6pt` | Margin-top for error message | `TaskCreateSheet` error |

## Border Radius Scale

| Value | Usage |
|---|---|
| `0` | Task bars |
| `8pt` | Text inputs, action buttons |
| `Circle` | Add button in header (`.clipShape(Circle())`) |

## Borders

| Value | Usage | View |
|---|---|---|
| `1pt` `Color.slidooInputBorder` | Text input default border | `TaskCreateSheet` |
| `2pt` `Color.white` | Add button border | `HeaderView` |
| `none` | Action buttons (cancel, submit) | `TaskCreateSheet` |

## Animations

| Property | Value | Usage |
|---|---|---|
| Fill width | `.easeOut(duration: 0.05)` | Task bar fill animation (disabled during active drag via `.transaction { $0.animation = nil }`) |
| Button press | Instant opacity change | Button press feedback (`opacity: 0.8`) |

## Token Migration Notes

Several spacing and dimension values may be defined inline in views during early development. Future improvement: extract a spacing scale into `CGFloat` extensions (e.g., `CGFloat.slidooSpace1: 4`, `CGFloat.slidooSpace2: 8`, `CGFloat.slidooSpace3: 12`, `CGFloat.slidooSpace4: 16`).
