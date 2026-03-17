import SwiftUI

// MARK: - FocusedValue Keys

struct ShowCreateSheetKey: FocusedValueKey {
    typealias Value = Binding<Bool>
}

struct NavigationPathKey: FocusedValueKey {
    typealias Value = Binding<[UUID]>
}

struct SearchActiveKey: FocusedValueKey {
    typealias Value = Binding<Bool>
}

struct ExportActionKey: FocusedValueKey {
    typealias Value = () -> Void
}

extension FocusedValues {
    var showCreateSheet: Binding<Bool>? {
        get { self[ShowCreateSheetKey.self] }
        set { self[ShowCreateSheetKey.self] = newValue }
    }

    var navigationPath: Binding<[UUID]>? {
        get { self[NavigationPathKey.self] }
        set { self[NavigationPathKey.self] = newValue }
    }

    var searchActive: Binding<Bool>? {
        get { self[SearchActiveKey.self] }
        set { self[SearchActiveKey.self] = newValue }
    }

    var exportAction: (() -> Void)? {
        get { self[ExportActionKey.self] }
        set { self[ExportActionKey.self] = newValue }
    }
}

// MARK: - Menu Bar Commands

struct SlidooCommands: Commands {
    @FocusedBinding(\.showCreateSheet) private var showCreateSheet
    @FocusedBinding(\.navigationPath) private var navigationPath
    @FocusedBinding(\.searchActive) private var searchActive
    @FocusedValue(\.exportAction) private var exportAction

    var body: some Commands {
        CommandGroup(replacing: .newItem) {
            Button("New Task") {
                showCreateSheet = true
            }
            .keyboardShortcut("n", modifiers: .command)
            .disabled(showCreateSheet == nil)
        }

        CommandGroup(after: .newItem) {
            Divider()
            Button("Export...") {
                exportAction?()
            }
            .keyboardShortcut("e", modifiers: .command)
            .disabled(exportAction == nil)
        }

        CommandMenu("Navigate") {
            Button("Back") {
                if let navigationPath, !navigationPath.isEmpty {
                    self.navigationPath?.removeLast()
                }
            }
            .keyboardShortcut("[", modifiers: .command)
            .disabled(navigationPath == nil || navigationPath?.isEmpty == true)
        }

        CommandMenu("View") {
            Button("Search") {
                searchActive = true
            }
            .keyboardShortcut("f", modifiers: .command)
            .disabled(searchActive == nil)
        }
    }
}
