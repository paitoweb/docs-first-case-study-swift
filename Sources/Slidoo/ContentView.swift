import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var navigationPath: [UUID] = []
    @State private var taskStore: TaskStore?

    // Search state
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @State private var searchResults: [SlidooTask] = []
    @State private var searchTask: Task<Void, Never>?

    var body: some View {
        Group {
            if let taskStore {
                NavigationStack(path: $navigationPath) {
                    Group {
                        if isSearching && !searchText.trimmingCharacters(in: .whitespaces).isEmpty {
                            SearchResultsView(
                                results: searchResults,
                                taskStore: taskStore,
                                onTaskTapped: { task in
                                    isSearching = false
                                    searchText = ""
                                    searchResults = []
                                    navigateToTask(task)
                                }
                            )
                            .background(Color.slidooBg)
                        } else {
                            TaskLevelView(parentTaskId: nil, navigationPath: $navigationPath)
                        }
                    }
                    .navigationDestination(for: UUID.self) { taskId in
                        TaskLevelView(parentTaskId: taskId, navigationPath: $navigationPath)
                    }
                }
                .searchable(text: $searchText, isPresented: $isSearching, prompt: "Search tasks")
                .environment(taskStore)
                .focusedValue(\.navigationPath, $navigationPath)
                .focusedValue(\.searchActive, $isSearching)
                .focusedValue(\.exportAction, {
                    ExportUtils.exportTasks(taskStore.fetchAllTasks())
                })
                .onChange(of: searchText) { _, newValue in
                    searchTask?.cancel()
                    let query = newValue
                    searchTask = Task {
                        try? await Task.sleep(for: .milliseconds(200))
                        guard !Task.isCancelled else { return }
                        let trimmed = query.trimmingCharacters(in: .whitespaces)
                        if trimmed.isEmpty {
                            await MainActor.run { searchResults = [] }
                        } else {
                            let results = taskStore.searchTasks(query: trimmed)
                            await MainActor.run { searchResults = results }
                        }
                    }
                }
                .onChange(of: isSearching) { _, active in
                    if !active {
                        searchText = ""
                        searchResults = []
                        searchTask?.cancel()
                    }
                }
            }
        }
        .frame(minWidth: 800, minHeight: 600)
        .onAppear {
            if taskStore == nil {
                taskStore = TaskStore(modelContext: modelContext)
            }
        }
    }

    private func navigateToTask(_ task: SlidooTask) {
        guard let taskStore else { return }
        // Build navigation path from root to the task's parent
        var path: [UUID] = []
        var current = task
        while let pid = current.parentId {
            path.insert(pid, at: 0)
            guard let parent = taskStore.fetchTask(by: pid) else { break }
            current = parent
        }
        // Append the task itself to drill into it
        path.append(task.id)
        navigationPath = path
    }
}
