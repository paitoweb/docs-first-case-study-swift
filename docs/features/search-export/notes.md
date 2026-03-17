# Search & Export - Technical Notes

## Flow Inputs

- User text input for search query
- User action trigger for export (click or Cmd+E)

## Component Connections
> Traces: `REQ-SEARCH-EXPORT-001`, `REQ-SEARCH-EXPORT-003`, `REQ-SEARCH-EXPORT-004`

- Search integrated via SwiftUI `.searchable()` modifier on the `NavigationStack`, also triggered by Cmd+F keyboard shortcut
- Search queries the data layer for tasks matching the query across all nesting levels
- Export reads all tasks from SwiftData and serializes via `Codable`
- `NSSavePanel` used for file save dialog; `NSSharingServicePicker` available for native macOS sharing

## Implementation Notes
> Traces: `REQ-SEARCH-EXPORT-002`, `REQ-SEARCH-EXPORT-003`, `REQ-SEARCH-EXPORT-005` | `AC-SEARCH-EXPORT-001`, `AC-SEARCH-EXPORT-002`, `AC-SEARCH-EXPORT-003`

- From the reference images, the search/export icon is a magnifying glass with a downward arrow, positioned on the left side of the header bar
- Search should debounce input (200-300ms) via Combine `debounce(for:scheduler:)` or Swift async `Task.sleep` to avoid filtering on every keystroke
- For cross-level search, the data layer needs a "search all" method that traverses the full task tree via SwiftData query
- Breadcrumb for search results: "Parent > Grandparent > Task Name"
- Export filename suggestion: "slidoo-tasks-YYYY-MM-DD.json"
- Use `NSSharingServicePicker` for native macOS sharing options
