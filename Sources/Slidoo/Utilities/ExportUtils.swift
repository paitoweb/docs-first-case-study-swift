import Foundation
import AppKit
import UniformTypeIdentifiers

struct TaskExportModel: Codable {
    let id: String
    let name: String
    let progress: Int
    let color: String
    let parentId: String?
    let level: Int
    let startDate: String?
    let endDate: String?
}

extension SlidooTask {
    func toExportModel() -> TaskExportModel {
        let isoFormatter = ISO8601DateFormatter()
        return TaskExportModel(
            id: id.uuidString,
            name: name,
            progress: progress,
            color: color,
            parentId: parentId?.uuidString,
            level: level,
            startDate: startDate.map { isoFormatter.string(from: $0) },
            endDate: endDate.map { isoFormatter.string(from: $0) }
        )
    }
}

enum ExportUtils {
    @MainActor
    static func exportTasks(_ tasks: [SlidooTask]) {
        let models = tasks.map { $0.toExportModel() }
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        guard let data = try? encoder.encode(models) else { return }

        let panel = NSSavePanel()
        let dateStr = String(ISO8601DateFormatter().string(from: Date()).prefix(10))
        panel.nameFieldStringValue = "slidoo-tasks-\(dateStr).json"
        panel.allowedContentTypes = [.json]

        if panel.runModal() == .OK, let url = panel.url {
            try? data.write(to: url)
        }
    }
}
