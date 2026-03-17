# Search & Export - Business Rules

> Decision tables for the feature.
> Reference: [README.md](README.md) | [Glossary](../../GLOSSARY.md)

## Search Rules
> Traces: `REQ-SEARCH-EXPORT-001`, `REQ-SEARCH-EXPORT-002`, `REQ-SEARCH-EXPORT-003` | `AC-SEARCH-EXPORT-001`, `AC-SEARCH-EXPORT-002`, `AC-SEARCH-EXPORT-004`

| Condition | Result |
|---|---|
| Query is empty | Show full task list (no filter) |
| Query matches task names | Show matching tasks only |
| Query matches subtask at any level | Show subtask with parent breadcrumb |
| Query matches no tasks | Show "no results" message |
| Search is case-insensitive | "math" matches "Math Worksheet" |

## Export Rules
> Traces: `REQ-SEARCH-EXPORT-004`, `REQ-SEARCH-EXPORT-005` | `AC-SEARCH-EXPORT-003`

| Condition | Result |
|---|---|
| User triggers export | Export ALL tasks including subtasks |
| Export format is JSON | Include full task hierarchy with all fields |
| Export format is CSV | Flatten hierarchy with a "parent" column |
| No tasks exist | Export empty file or show warning |

## Export Data Fields
> Traces: `REQ-SEARCH-EXPORT-005` | `AC-SEARCH-EXPORT-003`

| Field | Included | Notes |
|---|---|---|
| Task name | Yes | Required |
| Progress percentage | Yes | Integer 0-100 |
| Color | Yes | Hex string |
| Start date | Yes (if set) | ISO 8601 |
| End date | Yes (if set) | ISO 8601 |
| Parent task ID | Yes (if subtask) | For hierarchy reconstruction |
| Nesting level | Yes | Integer starting at 1 |
