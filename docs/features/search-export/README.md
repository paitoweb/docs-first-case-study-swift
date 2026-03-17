# Search & Export

- Priority: P2
- Status: Complete
- Last updated: 2026-03-14

## Overview

Users can search through their tasks and export task data. The reference designs show a search/download icon in the header bar (magnifying glass with download arrow), indicating combined search and export functionality. Search allows filtering the task list by name, and export allows downloading task data in a portable format.

## Requirements (REQ-*)

- `REQ-SEARCH-EXPORT-001` The system MUST allow the user to search tasks by name.
- `REQ-SEARCH-EXPORT-002` The system MUST filter the task list in real-time as the user types a search query.
- `REQ-SEARCH-EXPORT-003` The system MUST search across all tasks including subtasks at all nesting levels.
- `REQ-SEARCH-EXPORT-004` The system MUST allow the user to export task data.
- `REQ-SEARCH-EXPORT-005` The system MUST provide the export in a portable format (JSON or CSV).

## Acceptance Criteria (AC-*)

### AC-SEARCH-EXPORT-001 - Search by Name (REQ-SEARCH-EXPORT-001, REQ-SEARCH-EXPORT-002)

- Given the user clicks the search icon in the header or presses Cmd+F
- When the user types a query into the search input
- Then the task list filters in real-time to show only tasks whose names contain the query string (case-insensitive)

### AC-SEARCH-EXPORT-002 - Search Across Levels (REQ-SEARCH-EXPORT-003)

- Given the user searches for a term that matches a subtask at level 3
- When the search results are displayed
- Then the matching subtask is shown with a breadcrumb indicating its parent hierarchy

### AC-SEARCH-EXPORT-003 - Export Task Data (REQ-SEARCH-EXPORT-004, REQ-SEARCH-EXPORT-005)

- Given the user clicks the export button or presses Cmd+E
- When the export is triggered
- Then a file containing all task data (names, progress, dates, colors, hierarchy) is generated and offered for save via NSSavePanel

### AC-SEARCH-EXPORT-004 - Clear Search (REQ-SEARCH-EXPORT-001)

- Given the user has an active search filter
- When the user clears the search input
- Then the full task list is restored

## Dependencies

- Task management feature (provides task data to search and export)
- Subtask hierarchy feature (search must traverse the hierarchy)

## Traceability

- Decisions: [`../../DECISIONS.md`](../../DECISIONS.md)
- NFR: [`../../nfr/NON_FUNCTIONAL.md`](../../nfr/NON_FUNCTIONAL.md)

## Non-Scope

- Cloud-based search or server-side search (search is in-app only)
- Import from external files
- Sharing task lists with other users via link

## Open Questions

None currently.

## Resolved Questions

- **Export scope**: Export includes the full task hierarchy (all tasks at all levels) as a flat JSON array with `parentId` references preserving the tree structure
- **Export format**: JSON only (`slidoo-tasks-YYYY-MM-DD.json`). JSON preserves hierarchy natively via `parentId`; CSV omitted as less useful for tree data
- **Search result navigation**: Search results are displayed as a flat list with breadcrumbs showing parent hierarchy. Tasks in results support right-click context menu actions but not drill-down navigation (search mode is a separate view from the hierarchy navigation)
