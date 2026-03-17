# Component Specifications

> Reference: [README.md](README.md) | [Glossary](../GLOSSARY.md)

## View Hierarchy

```
SlidooApp (WindowGroup, min 800×600, .preferredColorScheme(.dark))
├── ContentView
│   ├── HeaderView (fixed height: 56pt)
│   │   ├── Search Button (root, normal mode) | Back Button (level 2+ or search mode)
│   │   ├── Title ("Slidoo" at root | parent task name | Search via .searchable())
│   │   └── Add Button (+, circular 40pt, disabled at level 5) | Export Button (search mode)
│   ├── TaskCreateSheet (conditional, presented as sheet/popover)
│   │   ├── TextField (full width)
│   │   ├── Date Fields (Start date | End date, SwiftUI DatePicker)
│   │   └── Action Row (Cancel | Add)
│   ├── ColorPickerView (conditional, popover)
│   │   └── Color Swatch × 7 (circular grid)
│   ├── DateEditView (conditional, sheet)
│   │   ├── Start DatePicker | End DatePicker
│   │   └── Action Row (Cancel | Save)
│   ├── SearchResultsView (search mode) | TaskListView (normal) | EmptyStateView (empty)
│   │   └── TaskBarView × N (64pt bar + optional date row)
│   │       ├── Subtask Count Badge (conditional, left side)
│   │       ├── Fill Layer (progress %, task color)
│   │       ├── Background Layer (task color 20%)
│   │       ├── Content (name left, percentage right)
│   │       └── Date Row (conditional: START date, DAYS LEFT, END date)
│   ├── Context Menu (right-click: Rename, Change Color, Set Dates, Delete) via .contextMenu
│   └── Confirmation Dialog (delete confirmation) via .confirmationDialog
```

## HeaderView

| Property | Value |
|---|---|
| Height | `56pt` |
| Background | `Color.black.opacity(0.3)` (`Color.slidooHeader`) |
| Layout | `HStack`, space-between, center-aligned |
| Title | "Slidoo", 22pt, bold, italic, tracking 1pt |
| Add button | 40pt circle, 2pt white border, transparent background, "+" at 24pt |
| Active state | Button background `Color.white.opacity(0.15)` |

## TaskBarView

The core visual component of Slidoo. See also: [Glossary: Task Bar](../GLOSSARY.md).

| Property | Value |
|---|---|
| Height | `64pt` |
| Border radius | `0` |
| Horizontal padding | `16pt` (content area) |
| Gap between bars | `8pt` (via `LazyVStack(spacing: 8)`) |

### Visual Layers

The task bar is composed of three layers stacked via `ZStack`:

1. **Background layer** (full width): task color at 20% opacity (`Color(hex: task.color).opacity(0.2)`)
2. **Fill layer** (width = progress %): task color at full opacity. Width calculated via `GeometryReader`.
3. **Content layer**: task name (left, truncated) + progress percentage (right, bold) via `HStack`

### Task Name

| Property | Value |
|---|---|
| Font size | `16pt` |
| Font weight | `.medium` |
| Color | `Color.white` (`Color.slidooText`) |
| Overflow | Truncated with ellipsis (`.lineLimit(1).truncationMode(.tail)`) |
| Max length | 100 characters (D010) |
| Right margin | `12pt` (gap before progress text) |

### Progress Percentage

| Property | Value |
|---|---|
| Font size | `20pt` |
| Font weight | `.bold` |
| Color | `Color.white` (`Color.slidooText`) |
| Format | `"{integer}%"` (e.g., "42%") |

### Interaction Behavior

| Property | Value |
|---|---|
| Drag gesture | `DragGesture(minimumDistance: 10)` for progress update |
| Click (single) | `TapGesture` for drill-down into subtasks |
| Right-click | `.contextMenu` modifier for task actions (D011) |
| User interaction during drag | Text selection disabled (default in SwiftUI) |
| Fill animation | `.easeOut(duration: 0.05)` (disabled during active drag via `.transaction { $0.animation = nil }`) |

## TaskCreateSheet

Sheet or popover presented when the user clicks (+) or presses Cmd+N.

| Property | Value |
|---|---|
| Presentation | `.sheet` or `.popover` modifier |
| Background | `Color.slidooBg` |
| Padding | `12pt` vertical, `16pt` horizontal |

### TextField

| Property | Value |
|---|---|
| Width | Full width |
| Padding | `12pt` |
| Background | `Color.white.opacity(0.1)` (`Color.slidooInputBg`) |
| Border | `1pt` `Color.white.opacity(0.2)` via `.overlay(RoundedRectangle(...).stroke(...))` |
| Focus border | `Color.white.opacity(0.5)` |
| Border radius | `8pt` |
| Placeholder color | `Color.white.opacity(0.7)` (`Color.slidooTextSecondary`) |
| Max length | 100 characters (enforced via `.onChange` modifier, per D010) |

### Action Buttons

| Property | Cancel | Submit |
|---|---|---|
| Padding | `10pt` | `10pt` |
| Border radius | `8pt` | `8pt` |
| Background | `Color.white.opacity(0.1)` | `Color(hex: "#4A90D9")` |
| Text color | `Color.white.opacity(0.7)` | `Color.white` |
| Font | `16pt`, `.semibold` | `16pt`, `.semibold` |
| Active state | `opacity: 0.8` | `opacity: 0.8` |

### Error Message

| Property | Value |
|---|---|
| Font size | `13pt` |
| Color | `Color(hex: "#E74C3C")` |
| Margin top | `6pt` |

## EmptyStateView

Centered content shown when the task list is empty.

| Property | Value |
|---|---|
| Layout | `VStack`, centered both axes |
| Title | "No tasks yet", 20pt, `.semibold` |
| Subtitle | "Click the + button...", 14pt, secondary color |
| Gap | `8pt` between title and subtitle |

## TaskListView

Scrollable container for task bars.

| Property | Value |
|---|---|
| Layout | `ScrollView` with `LazyVStack(spacing: 8)` |
| Scroll | Vertical, native macOS scrollbar |
| Padding | `0` top/bottom, `0` left/right |
| Gap | `8pt` between task bars |

## Back Button

Navigation control shown in the header when the user is drilled into a subtask level (level 2+). Hidden at the root task list.

| Property | Value |
|---|---|
| Position | Left side of header (replaces spacer) |
| Click target | `40pt × 40pt` minimum |
| Icon | Left-pointing chevron (`chevron.left` SF Symbol), 24pt, white |
| Background | Transparent |
| Active state | `Color.white.opacity(0.15)` |
| Visibility | Hidden at root level (level 1); visible at level 2+ |
| Keyboard shortcut | Cmd+[ (D012) |

When visible, the header title changes from "Slidoo" to the current parent task's name (truncated with ellipsis if needed).

## Subtask Count Badge

Small numeric indicator on parent tasks showing the number of direct subtasks.

| Property | Value |
|---|---|
| Position | Left side of task bar, vertically centered |
| Size | `22pt × 22pt` circle |
| Background | `Color.white.opacity(0.25)` |
| Font size | `12pt` |
| Font weight | `.bold` |
| Color | `Color.white` |
| Text align | Centered |
| Visibility | Shown when subtask count ≥ 1; hidden when 0 |
| Left margin | `8pt` from bar edge |

The badge shifts the task name content to the right to avoid overlap.

## ColorPickerView

Grid of circular color swatches for selecting a task's color. Triggered from the "Change Color" option in the right-click context menu. Named `ColorPickerView` to avoid conflict with SwiftUI's built-in `ColorPicker`.

| Property | Value |
|---|---|
| Layout | `HStack` / `LazyVGrid`, centered |
| Presentation | Popover or inline |
| Background | `Color.black.opacity(0.3)` (consistent with header/form) |
| Padding | `16pt` |
| Border radius | `8pt` top corners |

### Color Swatch

| Property | Value |
|---|---|
| Size | `40pt × 40pt` circle |
| Gap | `12pt` between swatches |
| Border | `2pt solid transparent` (default) |
| Selected state | `2pt solid Color.white` + slight scale (`.scaleEffect(1.15)`) |
| Click target | Minimum `44pt × 44pt` area |

### Palette Colors

| Index | Name | Hex | Swatch |
|---|---|---|---|
| 0 | Blue (dark) | `#4A90D9` | Default first color |
| 1 | Blue (light) | `#5BA8C8` | |
| 2 | Green | `#2ECC71` | |
| 3 | Purple | `#9B59B6` | |
| 4 | Orange | `#E67E22` | |
| 5 | Yellow-green | `#A8D858` | |
| 6 | Teal | `#1ABC9C` | |

## DateEditView

Sheet for editing a task's start and end dates. Triggered from "Set Dates" in the right-click context menu.

| Property | Value |
|---|---|
| Presentation | `.sheet` modifier |
| Background | `Color.slidooBg` |
| Border radius | `12pt` |
| Padding | `16pt` |

### Date Inputs

| Property | Value |
|---|---|
| Type | SwiftUI `DatePicker` (`.datePickerStyle(.graphical)` or `.field`) |
| Color scheme | Dark (inherited from `.preferredColorScheme(.dark)`) |

Action buttons follow the same Cancel/Save pattern as TaskCreateSheet.

## SearchResultsView

Flat list of task bars shown during search mode, with breadcrumb labels for nested tasks. Search integrated via SwiftUI `.searchable()` modifier on the `NavigationStack`.

| Property | Value |
|---|---|
| Layout | `ScrollView` with `LazyVStack(spacing: 8)` |
| Gap | `8pt` between result items |

### Breadcrumb

| Property | Value |
|---|---|
| Font size | `11pt` |
| Color | `Color.white.opacity(0.7)` (`Color.slidooTextSecondary`) |
| Padding | `0 16pt 2pt` |
| Overflow | Truncated with ellipsis |
| Format | `"Grandparent > Parent > Task"` |

### No Results State

| Property | Value |
|---|---|
| Font size | `16pt` |
| Color | `Color.white.opacity(0.7)` (`Color.slidooTextSecondary`) |
| Layout | Centered both axes |

## Date Row (below TaskBarView)

Appears below the task bar when a task has start or end dates assigned.

| Property | Value |
|---|---|
| Layout | `HStack`, space-between |
| Padding | `4pt 16pt 0` |
| Min height | `20pt` |

### Date Labels

| Property | Value |
|---|---|
| Font size | `10pt` |
| Font weight | `.semibold` |
| Color | `Color.white.opacity(0.7)` (`Color.slidooTextSecondary`) |
| Letter spacing | `0.5pt` (via `.tracking(0.5)`) |
| Format | `"START DD MMM YYYY"` (left) / `"END DD MMM YYYY"` (right) |

### Days Left / Overdue

| Property | Value |
|---|---|
| Position | Center of date row |
| Font size | `10pt` |
| Color (normal) | `Color.white.opacity(0.7)` |
| Color (overdue) | `Color(hex: "#E74C3C")`, `.bold` |
| Values | `"X DAYS LEFT"`, `"1 DAY LEFT"`, `"TODAY"`, `"OVERDUE"` |

### Overdue Indicator (on TaskBarView)

| Property | Value |
|---|---|
| Style | `3pt` left border in `Color(hex: "#E74C3C")` via `.overlay(alignment: .leading)` |
| Condition | End date in the past AND progress < 100% |
