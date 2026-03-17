import Foundation
import SwiftData

@Model
final class SlidooTask {
    var id: UUID
    var name: String
    var progress: Int
    var color: String
    var parentId: UUID?
    var level: Int
    var startDate: Date?
    var endDate: Date?
    var createdAt: Date
    var updatedAt: Date

    init(name: String, color: String, parentId: UUID? = nil, level: Int = 1) {
        self.id = UUID()
        self.name = name
        self.progress = 0
        self.color = color
        self.parentId = parentId
        self.level = level
        self.startDate = nil
        self.endDate = nil
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
