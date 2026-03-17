import SwiftUI
import SwiftData

struct TaskLevelView: View {
    let parentTaskId: UUID?
    @Binding var navigationPath: [UUID]

    @Environment(TaskStore.self) private var taskStore
    @State private var showCreateSheet = false
    @State private var parentTask: SlidooTask?

    private var isAtRoot: Bool { parentTaskId == nil }
    private var isAtMaxDepth: Bool { (parentTask?.level ?? 0) >= 5 }
    private var nextLevel: Int { (parentTask?.level ?? 0) + 1 }

    var body: some View {
        VStack(spacing: 0) {
            HeaderView(
                parentTaskName: parentTask?.name,
                isAtRoot: isAtRoot,
                isAtMaxDepth: isAtMaxDepth,
                onAddTapped: { showCreateSheet = true },
                onBackTapped: {
                    if !navigationPath.isEmpty {
                        navigationPath.removeLast()
                    }
                }
            )

            TaskListView(
                parentId: parentTaskId,
                onTaskTapped: { task in
                    navigationPath.append(task.id)
                }
            )
        }
        .background(Color.slidooBg)
        .sheet(isPresented: $showCreateSheet) {
            TaskCreateSheet(parentId: parentTaskId, level: nextLevel)
                .environment(taskStore)
        }
        .focusedValue(\.showCreateSheet, $showCreateSheet)
        .onAppear {
            if let parentTaskId {
                parentTask = taskStore.fetchTask(by: parentTaskId)
            }
        }
    }
}
