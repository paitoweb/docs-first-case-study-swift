# Non-Functional Requirements

- Default priority: P0
- Status: Active
- Last updated: 2026-03-14

## Context

Central document for cross-cutting requirements that apply across all Slidoo features.

## Scope

Performance, reliability, security, privacy, scalability, accessibility, and observability for a native macOS desktop application.

## Requirements (NFR-*)

- `NFR-001` The system MUST launch to an interactive task list within 1 second on supported hardware.
- `NFR-002` The system MUST respond to the drag gesture within 16ms of input (60fps rendering).
- `NFR-003` The system MUST maintain 99.5% monthly uptime for the sync service.
- `NFR-004` The system MUST function fully offline using SwiftData local persistence when no network is available.
- `NFR-005` The system MUST support a resizable application window with a minimum size of 800×600 points.
- `NFR-006` The system MUST encrypt user data in transit (TLS 1.2+) and at rest for cloud-synced data.
- `NFR-007` The system MUST resolve sync conflicts within 5 seconds of reconnection.
- `NFR-008` The system MUST run on macOS 14 (Sonoma) and later versions.
- `NFR-009` The system MUST support macOS VoiceOver accessibility for all interactive elements.

## Acceptance Criteria (AC-NFR-*)

### AC-NFR-001 - App Launch Performance (NFR-001)

- Given a user opens Slidoo on a Mac running macOS 14+
- When the app launches for the first time
- Then the task list is interactive within 1 second

### AC-NFR-002 - Gesture Responsiveness (NFR-002)

- Given a user is viewing the task list
- When the user initiates a horizontal drag on a task bar
- Then the progress bar visual updates within 16ms of the drag input (maintaining 60fps)

### AC-NFR-003 - Service Availability (NFR-003)

- Given the sync service is deployed
- When measured over a calendar month
- Then uptime is at least 99.5%

### AC-NFR-004 - Offline Functionality (NFR-004)

- Given the user's Mac has no network connectivity
- When the user creates, edits, or drags progress on tasks
- Then all changes are persisted locally via SwiftData and available immediately

### AC-NFR-005 - Window Size Support (NFR-005)

- Given a macOS window with at least 800×600 points
- When the user opens Slidoo or resizes the window
- Then all UI elements are fully visible and functional, with task bars stretching to fill available width

### AC-NFR-006 - Data Encryption (NFR-006)

- Given a user has cloud sync enabled
- When task data is transmitted or stored on the server
- Then data is encrypted with TLS 1.2+ in transit and AES-256 at rest

### AC-NFR-007 - Sync Conflict Resolution (NFR-007)

- Given the user made offline changes that conflict with server data
- When network connectivity is restored
- Then conflicts are resolved within 5 seconds using last-write-wins strategy

### AC-NFR-008 - macOS Compatibility (NFR-008)

- Given a user opens Slidoo on macOS 14 (Sonoma) or later
- When using all app features including drag gesture, context menus, and keyboard shortcuts
- Then all features work correctly without platform-specific bugs

### AC-NFR-009 - VoiceOver Accessibility (NFR-009)

- Given a user has VoiceOver enabled on macOS
- When navigating the task list and interacting with task bars
- Then all interactive elements have appropriate accessibility labels and values via SwiftUI accessibility modifiers

## Dependencies

- SwiftUI `DragGesture` API for gesture handling
- SwiftData (`ModelContainer`, `ModelContext`) for local persistence
- CloudKit infrastructure for sync service and uptime SLO (Phase 4)

## Traceability

- Architecture: [`../ARCHITECTURE.md`](../ARCHITECTURE.md)
- Decisions: [`../DECISIONS.md`](../DECISIONS.md)

## Non-Scope

- iOS/iPadOS performance optimization
- Windows or Linux platform support
- Web browser performance benchmarks

## Open Questions

- Should we set a maximum SwiftData storage quota and warn users approaching the limit?
- What is the target memory footprint for the macOS app?
