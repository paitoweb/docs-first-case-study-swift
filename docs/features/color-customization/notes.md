# Color Customization - Technical Notes

## Flow Inputs

- User click on a color option in the palette
- Task ID to update

## Component Connections
> Traces: `REQ-COLOR-CUSTOM-002`, `REQ-COLOR-CUSTOM-003`, `REQ-COLOR-CUSTOM-005`

- `ColorPickerView` is shown as a popover during task edit (triggered from right-click context menu)
- `TaskBarView` reads the color value to apply as SwiftUI fill color
- Data layer persists the color value as a hex string via SwiftData

## Phase 1 vs Phase 2 Scope

**Already implemented (Phase 1):**
- Default color assignment via round-robin (`TaskColor.allCases[taskCount % TaskColor.allCases.count]`)
- Color field in task data model (hex string)
- Proportional color fill display on task bar (fill layer + background layer)
- Color persistence in SwiftData

**New in Phase 2:**
- Color picker UI view (`ColorPickerView` — grid of 7 circular swatches; named to avoid conflict with SwiftUI's built-in `ColorPicker`)
- "Change Color" option added to right-click context menu (see [task-management notes](../task-management/notes.md))
- Immediate color update on swatch selection with persistence

## Implementation Notes
> Traces: `REQ-COLOR-CUSTOM-003`, `REQ-COLOR-CUSTOM-004`, `REQ-COLOR-CUSTOM-005` | `AC-COLOR-CUSTOM-003`, `AC-COLOR-CUSTOM-004`, `AC-COLOR-CUSTOM-005`

- Colors are stored as hex strings (e.g., "#4A90D9") in the task data model
- The task bar uses SwiftUI `GeometryReader` with `Rectangle().frame(width:)` to show the color fill proportional to progress
- From the reference images, each task row has two visual layers: the colored fill (representing progress) and a slightly lighter/darker background (representing the remaining unfilled portion)
- The color picker should be a simple grid of circular color swatches
- Consider storing a palette index rather than hex to allow future palette/theme changes
