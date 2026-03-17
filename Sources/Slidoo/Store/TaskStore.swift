import Foundation
import SwiftData
import SwiftUI

@MainActor
@Observable
final class TaskStore {
    let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    // MARK: - Create

    func addTask(name: String, parentId: UUID? = nil, level: Int = 1) {
        let count = taskCount(parentId: parentId)
        let color = TaskColorPalette.nextColor(forTaskCount: count)
        let task = SlidooTask(name: name, color: color, parentId: parentId, level: level)
        modelContext.insert(task)
        recalculateAncestorProgress(from: parentId)
    }

    // MARK: - Update

    func updateProgress(_ task: SlidooTask, progress: Int) {
        task.progress = min(100, max(0, progress))
        task.updatedAt = Date()
        recalculateAncestorProgress(from: task.parentId)
    }

    func renameTask(_ task: SlidooTask, newName: String) {
        task.name = newName
        task.updatedAt = Date()
    }

    func updateTaskColor(_ task: SlidooTask, color: String) {
        task.color = color
        task.updatedAt = Date()
    }

    func updateDates(_ task: SlidooTask, startDate: Date?, endDate: Date?) {
        task.startDate = startDate
        task.endDate = endDate
        task.updatedAt = Date()
    }

    // MARK: - Delete

    func deleteTask(_ task: SlidooTask) {
        let savedParentId = task.parentId
        deleteChildren(of: task)
        modelContext.delete(task)
        recalculateAncestorProgress(from: savedParentId)
    }

    // MARK: - Queries

    func taskCount(parentId: UUID? = nil) -> Int {
        var descriptor = FetchDescriptor<SlidooTask>()
        if let parentId {
            descriptor.predicate = #Predicate { $0.parentId == parentId }
        } else {
            descriptor.predicate = #Predicate { $0.parentId == nil }
        }
        return (try? modelContext.fetchCount(descriptor)) ?? 0
    }

    func fetchChildren(of taskId: UUID) -> [SlidooTask] {
        let descriptor = FetchDescriptor<SlidooTask>(
            predicate: #Predicate { $0.parentId == taskId },
            sortBy: [SortDescriptor(\SlidooTask.createdAt)]
        )
        return (try? modelContext.fetch(descriptor)) ?? []
    }

    func hasChildren(_ taskId: UUID) -> Bool {
        taskCount(parentId: taskId) > 0
    }

    func fetchTask(by id: UUID) -> SlidooTask? {
        let descriptor = FetchDescriptor<SlidooTask>(
            predicate: #Predicate { $0.id == id }
        )
        return try? modelContext.fetch(descriptor).first
    }

    // MARK: - Search

    func searchTasks(query: String) -> [SlidooTask] {
        let lowered = query.lowercased()
        let descriptor = FetchDescriptor<SlidooTask>(
            sortBy: [SortDescriptor(\SlidooTask.createdAt)]
        )
        let all = (try? modelContext.fetch(descriptor)) ?? []
        return all.filter { $0.name.lowercased().contains(lowered) }
    }

    func buildBreadcrumb(for task: SlidooTask) -> String {
        var parts: [String] = []
        var current = task
        while let pid = current.parentId, let parent = fetchTask(by: pid) {
            parts.insert(parent.name, at: 0)
            current = parent
        }
        return parts.isEmpty ? "" : parts.joined(separator: " > ")
    }

    // MARK: - Export

    func fetchAllTasks() -> [SlidooTask] {
        let descriptor = FetchDescriptor<SlidooTask>(
            sortBy: [SortDescriptor(\SlidooTask.level), SortDescriptor(\SlidooTask.createdAt)]
        )
        return (try? modelContext.fetch(descriptor)) ?? []
    }

    // MARK: - Progress Rollup (D009)

    func recalculateProgress(for task: SlidooTask) {
        let children = fetchChildren(of: task.id)
        guard !children.isEmpty else { return }
        let sum = children.reduce(0) { $0 + $1.progress }
        let average = Int((Double(sum) / Double(children.count)).rounded())
        task.progress = average
        task.updatedAt = Date()
    }

    func recalculateAncestorProgress(from parentId: UUID?) {
        guard let parentId else { return }
        guard let parent = fetchTask(by: parentId) else { return }
        recalculateProgress(for: parent)
        recalculateAncestorProgress(from: parent.parentId)
    }

    // MARK: - Private

    private func deleteChildren(of task: SlidooTask) {
        let taskId = task.id
        var descriptor = FetchDescriptor<SlidooTask>(
            predicate: #Predicate { $0.parentId == taskId }
        )
        descriptor.fetchLimit = nil
        guard let children = try? modelContext.fetch(descriptor) else { return }
        for child in children {
            deleteChildren(of: child)
            modelContext.delete(child)
        }
    }
}
