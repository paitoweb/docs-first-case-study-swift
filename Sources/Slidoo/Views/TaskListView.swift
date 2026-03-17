import SwiftUI
import SwiftData

struct TaskListView: View {
    @Query private var tasks: [SlidooTask]
    @Environment(TaskStore.self) private var taskStore

    let parentId: UUID?
    var onTaskTapped: (SlidooTask) -> Void

    init(parentId: UUID?, onTaskTapped: @escaping (SlidooTask) -> Void) {
        self.parentId = parentId
        self.onTaskTapped = onTaskTapped
        if let parentId {
            _tasks = Query(
                filter: #Predicate<SlidooTask> { task in task.parentId == parentId },
                sort: \SlidooTask.createdAt
            )
        } else {
            _tasks = Query(
                filter: #Predicate<SlidooTask> { task in task.parentId == nil },
                sort: \SlidooTask.createdAt
            )
        }
    }

    var body: some View {
        if tasks.isEmpty {
            EmptyStateView(isSubtaskLevel: parentId != nil)
        } else {
            ScrollView {
                LazyVStack(spacing: .slidooTaskBarGap) {
                    ForEach(tasks) { task in
                        TaskBarView(
                            task: task,
                            childCount: taskStore.taskCount(parentId: task.id),
                            onTapped: { onTaskTapped(task) }
                        )
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
