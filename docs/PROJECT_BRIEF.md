# Slidoo - Project Brief

> **Language notice**: All documentation in this project is written exclusively in English.

## Overview

Slidoo is a native macOS desktop application for visual task and progress management. Its core interaction is a horizontal drag gesture on task bars that intuitively updates completion percentage. The app helps users organize, track, and visualize progress across tasks and projects using colorful, layered progress bars with deadline awareness.

The tagline is: **"Slide to take control about your progress"**.

## Problem it solves

Existing task management tools are either too complex (full-featured project management suites) or too simple (basic checklists with no progress granularity). Users need a fast, intuitive way to express partial progress on tasks without navigating forms or entering numbers manually. Slidoo provides a visual, gesture-driven interface that makes progress tracking feel natural and satisfying.

## Target audience

- **Fitness enthusiasts** - tracking workout exercise progress (e.g., sets, reps milestones)
- **Students** - managing homework, reading assignments, and study tasks with deadlines
- **Project Managers** - high-level project progress overview with subtask breakdown
- **Team Leaders** - delegating and monitoring team task progress
- **Designers** - tracking creative project milestones
- **Freelancers** - managing client deliverables and deadlines

## Differentiators

- **Slide-to-progress gesture**: unique horizontal click-and-drag to update task completion percentage (no forms, no typing)
- **Multi-level subtask hierarchy**: tasks can contain subtasks, which can contain sub-subtasks (3+ levels)
- **Visual color-coded progress bars**: each task has a customizable color that fills proportionally to progress
- **Desktop-native experience**: built with SwiftUI for macOS, with keyboard shortcuts, menu bar integration, and native window management
- **Deadline awareness**: start date, end date, and "days left" countdown on every task

## Business goals

- Become the go-to macOS progress tracker for personal and small-team use
- Achieve high daily-active-user retention through the satisfying drag interaction
- Offer a freemium model with premium features (advanced subtask levels, export, team sharing)

## Objectives and KPIs

- **DAU/MAU ratio** > 40% within 6 months of launch
- **Task completion rate** > 60% (tasks that reach 100% out of total tasks created)
- **Session duration** average > 2 minutes per visit
- **Mac App Store rating** > 4.5 stars

## Technical metrics (SLOs)

- App launch to interactive < 1 second
- Drag gesture response latency < 16ms (60fps)
- 99.5% uptime monthly
- Data sync conflict resolution < 5 seconds

## Non-goals

- iOS/iPadOS companion app (may explore later via Catalyst or native port)
- Full project management suite features (Gantt charts, resource allocation, budgeting)
- Real-time multi-user collaborative editing (v1 is single-user)
- Light mode theme (v1 is dark-only, light mode deferred — D013)

## Constraints and assumptions

- macOS 14 (Sonoma) minimum deployment target (required for SwiftData and `@Observable`)
- Must work offline with SwiftData local persistence; sync via CloudKit when connectivity is available
- All UI text and documentation in English only
- The drag gesture must work reliably with mouse and trackpad input
- Initial release targets individual users (no team/sharing features in v1)

## Risks

- Drag gesture conflicts with standard macOS window/scroll interactions
- Users may accidentally update progress while attempting to click (drill-down) on task bars
- Hierarchical subtask UI may become complex to navigate at deeper levels
- Offline-first sync via CloudKit may cause data conflicts when reconnecting

## Open questions

- Should the drag gesture have trackpad haptic feedback on supported Macs?
- Should completed tasks (100%) auto-archive or remain visible?

## Resolved questions

- **Maximum subtask depth**: 5 levels (D008)
- **Progress rollup**: hybrid — manual for leaf tasks (drag gesture), auto-calculated average of direct children for parent tasks (D009)
- **Progress granularity**: integer percentage 0–100, no snapping (D006)
- **Gesture dead zone**: 10pt threshold before committing to drag vs click (D007)
- **Task name max length**: 100 characters, truncated on display with ellipsis (D010)
- **Tech stack**: Swift + SwiftUI with Xcode (D005)
