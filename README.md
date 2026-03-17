# Docs-First Case Study: Slidoo (Swift/SwiftUI)

> **This repository is a case study for the [Docs-First method](LINK_TO_ARTICLE)** — a documentation-driven approach to AI-assisted software development. This project was built by adapting the documentation from the [React version](https://github.com/paitoweb/docs-first-case-study-react) to a completely different platform — proving that Docs-First documentation is a specification of the *product*, not the *technology*.

---

**Slide to take control about your progress.**

Slidoo is a native macOS desktop application for visual task and progress management. Update task completion by clicking and dragging horizontally on colorful task bars — a natural gesture adapted from the mobile-first concept.

## About this case study

This project demonstrates the most powerful aspect of the Docs-First method: **documentation as a platform-independent, reusable asset**.

The process:
1. **Started with an empty folder** — no code, no configuration, only the `docs/` folder copied from the React version
2. **AI adapted the documentation** — read all 39 files and asked design questions before changing anything (interaction model, macOS target version, theme strategy)
3. **35 of 40 documentation files updated** — all React/TypeScript/Vite references replaced with Swift/SwiftUI/Xcode equivalents
4. **All REQ-\* and AC-\* preserved** — business logic, validation rules, and flows remained identical
5. **3 new ADRs created** — context menus (D011), keyboard shortcuts (D012), dark-only theme (D013)
6. **Implementation followed the adapted ROADMAP** — phase by phase, guided entirely by documentation

No business rule was re-specified. The documentation proved to be what it always should have been: a specification of the product, not the technology.

## Related resources

- 📖 **[Docs-First: How Structured Documentation Transformed My Way of Building with AI](LINK_TO_ARTICLE)** — full article explaining the method
- 🛠️ **[plan-docs-standardization](https://github.com/paitoweb/plan-docs-standardization)** — the Claude Code skill that enforces the documentation standard
- 📱 **[docs-first-case-study-react](https://github.com/paitoweb/docs-first-case-study-react)** — the original mobile web version built with React/TypeScript

## Key Features

- **Click-and-Drag Progress** — drag right to increase, left to decrease task completion
- **Multi-level Subtasks** — drill down into nested task hierarchies with NavigationStack
- **Deadline Tracking** — start/end dates with "days left" countdown
- **Color-coded Tasks** — assign colors for visual categorization
- **Keyboard Shortcuts** — Cmd+N (new task), Cmd+F (search), Cmd+[ (back), and more
- **Context Menus** — right-click for Rename, Delete, Change Color, Set Dates
- **Offline-first** — SwiftData persistence, designed for future CloudKit sync
- **Search & Export** — find tasks across all levels, export data

## Tech Stack

- **Swift** + **SwiftUI**
- Native macOS application (macOS 14 Sonoma+)
- SwiftData for local persistence (designed for CloudKit migration)
- Dark theme (preserving original design language)
- VoiceOver accessibility support
- Minimum window size: 800×600

## What changed from React → Swift

| Aspect | React (Web) | Swift (macOS) |
|---|---|---|
| Framework | React 19 + TypeScript | SwiftUI + Swift |
| Bundler | Vite | Xcode |
| Storage | localStorage | SwiftData |
| Interactions | Touch/swipe, long-press | Click-and-drag, right-click, keyboard shortcuts |
| Viewport | 320–428px mobile | 800×600+ resizable window |
| Platform targets | iOS Safari 15+, Android Chrome 90+ | macOS 14 Sonoma+ |
| State management | Hooks + props drilling | @Observable macro |
| Components | React functional components | SwiftUI Views |

## What stayed the same

- **All 415+ requirements** (REQ-\*) — identical business logic
- **All 303+ acceptance criteria** (AC-\*) — same Given/When/Then specifications
- **Business rules** — same decision tables (validation, deletion cascade, display rules)
- **Flows** — same Mermaid flowcharts (adapted interaction triggers)
- **Traceability** — same REQ→AC→Rule→Flow→Note→Test chain

## Project Structure

```
slidoo-ios/
├── docs/
│   ├── index.md                  # Docs home
│   ├── PROJECT_BRIEF.md          # Product vision (adapted for macOS)
│   ├── ARCHITECTURE.md           # SwiftUI architecture with Mermaid diagrams
│   ├── GLOSSARY.md               # Domain terminology
│   ├── DECISIONS.md              # ADRs (D001–D013, including macOS-specific)
│   ├── ROADMAP.md                # Delivery phases
│   ├── BACKLOG.md                # Prioritized work items
│   ├── design-system/            # Design tokens adapted for SwiftUI
│   ├── nfr/
│   │   └── NON_FUNCTIONAL.md     # NFRs (including VoiceOver accessibility)
│   ├── features/                 # Same 6 features, adapted documentation
│   └── reports/
└── Slidoo/                       # Swift/SwiftUI application
    └── ...
```

## Development

Open the project in Xcode:

```bash
open Slidoo.xcodeproj
```

Requires Xcode 15+ and macOS 14 Sonoma+.

## Documentation

Serve the docs site locally:

```bash
pip install -r docs/requirements-mkdocs.txt
mkdocs serve
```

## Language

All documentation, code, and UI are exclusively in English.

## License

MIT

## Author

Fabrício Santos — [LinkedIn](https://linkedin.com/in/YOUR_PROFILE) | [Twitter/X](https://x.com/YOUR_HANDLE)
