# Search & Export - Flows

> Mermaid diagrams for the main flows of the feature.
> Reference: [README.md](README.md) | [Glossary](../../GLOSSARY.md)

## Search Flow
> Traces: `REQ-SEARCH-EXPORT-001`, `REQ-SEARCH-EXPORT-002`, `REQ-SEARCH-EXPORT-003` | `AC-SEARCH-EXPORT-001`, `AC-SEARCH-EXPORT-002`, `AC-SEARCH-EXPORT-004`

```mermaid
flowchart TD
    A[User clicks search icon or presses Cmd+F] --> B[Search input appears via .searchable modifier]
    B --> C[User types query]
    C --> D[Filter tasks where name contains query]
    D --> E{Matches found?}
    E -->|Yes| F[Display matching tasks with parent breadcrumbs]
    E -->|No| G[Show 'no results' message]
    F --> H{User clicks a result?}
    H -->|Yes| I[Navigate to that task's location in hierarchy]
    H -->|No| C
```

## Export Flow
> Traces: `REQ-SEARCH-EXPORT-004`, `REQ-SEARCH-EXPORT-005` | `AC-SEARCH-EXPORT-003`

```mermaid
flowchart TD
    A[User clicks export button or presses Cmd+E] --> B[Collect all task data from SwiftData]
    B --> C[Serialize to JSON via Codable]
    C --> D[Present NSSavePanel for file save location]
    D --> E[Save file to user-selected location]
```
