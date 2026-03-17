import SwiftUI
import SwiftData
import AppKit

@main
struct SlidooApp: App {
    init() {
        // SPM executables don't activate automatically — make the app a proper
        // foreground application with a Dock icon and bring it to front.
        NSApplication.shared.setActivationPolicy(.regular)
        NSApplication.shared.activate()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: SlidooTask.self)
        .defaultSize(width: 900, height: 700)
        .commands {
            SlidooCommands()
        }
    }
}
