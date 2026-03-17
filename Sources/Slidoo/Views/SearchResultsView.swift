import SwiftUI

struct SearchResultsView: View {
    let results: [SlidooTask]
    let taskStore: TaskStore
    var onTaskTapped: (SlidooTask) -> Void

    var body: some View {
        if results.isEmpty {
            Text("No results")
                .font(.system(size: 16))
                .foregroundStyle(Color.slidooTextSecondary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            ScrollView {
                LazyVStack(spacing: .slidooTaskBarGap) {
                    ForEach(results) { task in
                        VStack(alignment: .leading, spacing: 0) {
                            let crumb = taskStore.buildBreadcrumb(for: task)
                            if !crumb.isEmpty {
                                Text(crumb)
                                    .font(.system(size: 11))
                                    .foregroundStyle(Color.slidooTextSecondary)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 2)
                            }
                            TaskBarView(
                                task: task,
                                childCount: taskStore.taskCount(parentId: task.id),
                                onTapped: { onTaskTapped(task) }
                            )
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
