import SwiftUI
import SwiftData

struct TaskBarView: View {
    let task: SlidooTask
    let childCount: Int
    var onTapped: (() -> Void)?

    @Environment(TaskStore.self) private var taskStore

    @State private var currentProgress: Int = 0
    @State private var baseProgress: Int = 0
    @State private var isDragging: Bool = false

    @State private var isRenaming: Bool = false
    @State private var renameText: String = ""
    @State private var renameError: String?
    @FocusState private var isRenameFocused: Bool

    @State private var showDeleteConfirmation: Bool = false
    @State private var showColorPicker: Bool = false
    @State private var showDateEditor: Bool = false

    private var isParent: Bool { childCount > 0 }
    private var hasDates: Bool { task.startDate != nil || task.endDate != nil }

    var body: some View {
        VStack(spacing: 0) {
            // Colored task bar
            GeometryReader { geometry in
                let barWidth = geometry.size.width

                ZStack(alignment: .leading) {
                    // Background layer — task color at 20% opacity
                    Rectangle()
                        .fill(Color(hex: task.color).opacity(0.2))

                    // Fill layer — task color at full opacity, width = progress%
                    Rectangle()
                        .fill(Color(hex: task.color))
                        .frame(width: barWidth * CGFloat(currentProgress) / 100.0)
                        .animation(isDragging ? nil : .easeOut(duration: 0.05), value: currentProgress)

                    // Content layer
                    HStack {
                        // Subtask count badge
                        if childCount > 0 {
                            ZStack {
                                Circle()
                                    .fill(Color.slidooBadgeBg)
                                    .frame(width: .slidooBadgeSize, height: .slidooBadgeSize)
                                Text("\(childCount)")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundStyle(Color.slidooText)
                            }
                            .padding(.leading, .slidooBadgeMarginLeft)
                        }

                        if isRenaming {
                            renameField
                        } else {
                            Text(task.name)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(Color.slidooText)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }

                        Spacer(minLength: 12)

                        Text("\(currentProgress)%")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(Color.slidooText)
                    }
                    .padding(.horizontal, 16)
                }
                .frame(height: .slidooTaskBarHeight)
                // Overdue indicator: 3pt red left border
                .overlay(alignment: .leading) {
                    if DateUtils.isOverdue(endDate: task.endDate, progress: task.progress) {
                        Rectangle()
                            .fill(Color.slidooError)
                            .frame(width: .slidooOverdueBorderWidth)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if !isRenaming {
                        onTapped?()
                    }
                }
                .gesture(isParent ? nil : dragGesture(barWidth: barWidth))
            }
            .frame(height: .slidooTaskBarHeight)

            // Date row (conditional)
            if hasDates {
                dateRow
            }
        }
        .contextMenu {
            Button("Rename") {
                renameText = task.name
                renameError = nil
                isRenaming = true
                isRenameFocused = true
            }
            Button("Change Color") {
                showColorPicker = true
            }
            Button("Set Dates") {
                showDateEditor = true
            }
            Divider()
            Button("Delete", role: .destructive) {
                showDeleteConfirmation = true
            }
        }
        .popover(isPresented: $showColorPicker) {
            ColorPickerView(
                currentColor: task.color,
                onColorSelected: { hex in
                    taskStore.updateTaskColor(task, color: hex)
                    showColorPicker = false
                }
            )
        }
        .sheet(isPresented: $showDateEditor) {
            DateEditView(task: task)
                .environment(taskStore)
        }
        .confirmationDialog(
            "Delete '\(task.name)'?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive) {
                taskStore.deleteTask(task)
            }
            Button("Cancel", role: .cancel) { }
        }
        .accessibilityLabel(
            childCount > 0
                ? "\(task.name), \(task.progress) percent complete, \(childCount) subtasks"
                : "\(task.name), \(task.progress) percent complete"
        )
        .accessibilityValue("\(task.progress) percent")
        .onAppear {
            currentProgress = task.progress
        }
        .onChange(of: task.progress) { _, newValue in
            if !isDragging {
                currentProgress = newValue
            }
        }
    }

    // MARK: - Date Row

    @ViewBuilder
    private var dateRow: some View {
        HStack {
            if let start = task.startDate {
                Text(DateUtils.formatDateLabel(start, prefix: "START"))
            }

            Spacer()

            if let end = task.endDate {
                let info = DateUtils.daysLeftText(until: end, progress: task.progress)
                if let text = info.text {
                    Text(text)
                        .foregroundStyle(info.isOverdue ? Color.slidooError : Color.slidooTextSecondary)
                        .fontWeight(info.isOverdue ? .bold : .semibold)
                }

                Spacer()

                Text(DateUtils.formatDateLabel(end, prefix: "END"))
            }
        }
        .font(.system(size: 10, weight: .semibold))
        .tracking(0.5)
        .foregroundStyle(Color.slidooTextSecondary)
        .padding(.top, .slidooDateRowPaddingTop)
        .padding(.horizontal, 16)
        .frame(minHeight: .slidooDateRowHeight)
    }

    // MARK: - Drag Gesture

    private func dragGesture(barWidth: CGFloat) -> some Gesture {
        DragGesture(minimumDistance: 10)
            .onChanged { value in
                if !isDragging && !isRenaming {
                    baseProgress = task.progress
                    isDragging = true
                }
                guard isDragging else { return }
                let deltaPercent = (value.translation.width / barWidth) * 100
                let newProgress = baseProgress + Int(deltaPercent.rounded())
                currentProgress = min(100, max(0, newProgress))
            }
            .onEnded { _ in
                guard isDragging else { return }
                taskStore.updateProgress(task, progress: currentProgress)
                isDragging = false
            }
    }

    // MARK: - Inline Rename

    @ViewBuilder
    private var renameField: some View {
        VStack(alignment: .leading, spacing: 2) {
            TextField("Task name", text: $renameText)
                .textFieldStyle(.plain)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.slidooText)
                .focused($isRenameFocused)
                .onChange(of: renameText) { _, newValue in
                    if newValue.count > 100 {
                        renameText = String(newValue.prefix(100))
                    }
                    renameError = nil
                }
                .onSubmit {
                    commitRename()
                }
                .onExitCommand {
                    cancelRename()
                }

            if let renameError {
                Text(renameError)
                    .font(.system(size: 13))
                    .foregroundStyle(Color.slidooError)
            }
        }
    }

    private func commitRename() {
        let trimmed = renameText.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            renameError = "Task name cannot be empty"
            return
        }
        if trimmed != task.name {
            taskStore.renameTask(task, newName: trimmed)
        }
        isRenaming = false
        renameError = nil
    }

    private func cancelRename() {
        isRenaming = false
        renameText = task.name
        renameError = nil
    }
}
