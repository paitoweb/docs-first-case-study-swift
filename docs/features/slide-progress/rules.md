# Slide-to-Progress - Business Rules

> Decision tables for the feature.
> Reference: [README.md](README.md) | [Glossary](../../GLOSSARY.md)

## Gesture Detection Rules
> Traces: `REQ-SLIDE-PROGRESS-001`, `REQ-SLIDE-PROGRESS-008`, `REQ-SLIDE-PROGRESS-010` | `AC-SLIDE-PROGRESS-007`, `AC-SLIDE-PROGRESS-009`

Dead zone: 10pt (D007). Interaction type is determined once displacement exceeds the dead zone.

| Drag Displacement | Task Has Subtasks | Result |
|---|---|---|
| < 10pt (released) | N/A | Single click — drill-down into subtasks |
| >= 10pt horizontal | No | Trigger progress update via drag |
| >= 10pt horizontal | Yes | No action (drag disabled on parent tasks, D009) |

## Progress Update Rules
> Traces: `REQ-SLIDE-PROGRESS-002`, `REQ-SLIDE-PROGRESS-003`, `REQ-SLIDE-PROGRESS-007` | `AC-SLIDE-PROGRESS-001`, `AC-SLIDE-PROGRESS-002`, `AC-SLIDE-PROGRESS-005`, `AC-SLIDE-PROGRESS-006`

| Current Progress | Drag Direction | Result |
|---|---|---|
| 0% | Left | Remains 0% (clamped) |
| 0% | Right | Increases toward 100% |
| 50% | Left | Decreases toward 0% |
| 50% | Right | Increases toward 100% |
| 100% | Left | Decreases toward 0% |
| 100% | Right | Remains 100% (clamped) |

## Progress Value Rules
> Traces: `REQ-SLIDE-PROGRESS-007`, `REQ-SLIDE-PROGRESS-009` | `AC-SLIDE-PROGRESS-008`

Progress is stored as an integer percentage 0–100 (D006).

| Calculated Value | Stored Value |
|---|---|
| 33.7% | 34% (rounded to nearest integer) |
| -5% (underflow) | 0% (clamped) |
| 105% (overflow) | 100% (clamped) |

## Persistence Rules
> Traces: `REQ-SLIDE-PROGRESS-004`, `REQ-SLIDE-PROGRESS-005`, `REQ-SLIDE-PROGRESS-006` | `AC-SLIDE-PROGRESS-003`, `AC-SLIDE-PROGRESS-004`

| Event | Result |
|---|---|
| Drag changed (during drag) | UI updates in real-time, no persistence |
| Drag ended (mouse button released) | Final integer progress value persisted to SwiftData |
| Drag cancelled (e.g., Escape pressed) | Revert to last persisted progress value |
