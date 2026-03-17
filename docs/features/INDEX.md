# Feature Index

Last updated: 2026-03-15

## Purpose

Centralize feature navigation with traceability to requirements and acceptance criteria.

## ID Conventions

- Functional requirement: `REQ-<FEATURE>-NNN`
- Acceptance criterion: `AC-<FEATURE>-NNN`
- Non-functional requirement: `NFR-NNN`

## Feature Catalog

| Feature | Priority | Docs | Implementation | Phase | Folder | Flows | Rules |
|---|---|---|---|---|---|---|---|
| Task Management | P0 | Complete | **Done** | 1 | [`task-management/`](task-management/README.md) | [flows.md](task-management/flows.md) | [rules.md](task-management/rules.md) |
| Slide-to-Progress | P0 | Complete | **Done** | 1 | [`slide-progress/`](slide-progress/README.md) | [flows.md](slide-progress/flows.md) | [rules.md](slide-progress/rules.md) |
| Subtask Hierarchy | P0 | Complete | **Done** | 2 | [`subtask-hierarchy/`](subtask-hierarchy/README.md) | [flows.md](subtask-hierarchy/flows.md) | [rules.md](subtask-hierarchy/rules.md) |
| Deadline Tracking | P1 | Complete | **Done** | 3 | [`deadline-tracking/`](deadline-tracking/README.md) | [flows.md](deadline-tracking/flows.md) | [rules.md](deadline-tracking/rules.md) |
| Color Customization | P1 | Complete | **Done** | 2 | [`color-customization/`](color-customization/README.md) | [flows.md](color-customization/flows.md) | [rules.md](color-customization/rules.md) |
| Search & Export | P2 | Complete | **Done** | 3 | [`search-export/`](search-export/README.md) | [flows.md](search-export/flows.md) | [rules.md](search-export/rules.md) |

## Non-Functional Requirements

- Global document: [`../nfr/NON_FUNCTIONAL.md`](../nfr/NON_FUNCTIONAL.md)

## Reports

- [Reports index](../reports/README.md)

## Governance Rules

- Every feature MUST have `README.md`, `flows.md`, `rules.md`, `notes.md`.
- Every functional requirement MUST receive a unique `REQ-*` ID.
- Every acceptance criterion MUST receive an `AC-*` ID and reference at least one `REQ-*`.
- Every cross-cutting requirement MUST be registered in `docs/nfr/NON_FUNCTIONAL.md`.
- Domain terms MUST be defined in [`../GLOSSARY.md`](../GLOSSARY.md).
