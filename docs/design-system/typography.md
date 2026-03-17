# Typography

> Reference: [README.md](README.md) | [Glossary](../GLOSSARY.md)

## Font Family

| Token | Value |
|---|---|
| System font | SF Pro (macOS system font, automatic in SwiftUI via `.font(.system(...))`) |

SwiftUI uses the macOS system font (SF Pro) by default — no custom font loading or configuration needed.

## Base Typography

| Property | Value | Source |
|---|---|---|
| Base font size | `16pt` | SwiftUI `.body` default |
| Base line height | System default | SwiftUI automatic line spacing |
| Font rendering | macOS native subpixel rendering | Automatic |

## Type Scale

All font sizes currently used in the application, ordered largest to smallest:

| Size | Weight | Style | Usage | View |
|---|---|---|---|---|
| `24pt` | `.regular` | normal | Add button (+) icon | `HeaderView` |
| `22pt` | `.bold` | italic, `tracking: 1` | "Slidoo" brand title | `HeaderView` |
| `20pt` | `.bold` | normal | Progress percentage (e.g., "42%") | `TaskBarView` |
| `20pt` | `.semibold` | normal | Empty state title ("No tasks yet") | `EmptyStateView` |
| `16pt` | `.semibold` | normal | Action button labels ("Add", "Cancel") | `TaskCreateSheet` |
| `16pt` | `.medium` | normal | Task name text | `TaskBarView` |
| `16pt` | `.regular` | normal | Text input value | `TaskCreateSheet` |
| `14pt` | `.regular` | normal | Empty state subtitle | `EmptyStateView` |
| `13pt` | `.regular` | normal | Error message text | `TaskCreateSheet` |

## Font Weight Scale

| Weight | SwiftUI Value | Usage |
|---|---|---|
| Regular | `.regular` | Body text, input text, subtitles |
| Medium | `.medium` | Task name |
| Semibold | `.semibold` | Buttons, empty state title |
| Bold | `.bold` | Brand title, progress percentage |

## Text Truncation

Task names that exceed the task bar width are truncated with an ellipsis. This is implemented via SwiftUI:

```swift
Text(task.name)
    .lineLimit(1)
    .truncationMode(.tail)
```

The full name is preserved in storage (max 100 characters per D010) and visible on edit.

## Token Migration Notes

Font sizes may be defined inline in views during early development. Future improvement: extract a type scale into SwiftUI `Font` extensions (e.g., `Font.slidooXS`, `Font.slidooSM`, `Font.slidooBase`, `Font.slidooLG`, `Font.slidooXL`).
