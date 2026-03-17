import SwiftUI

struct TaskCreateSheet: View {
    let parentId: UUID?
    let level: Int

    @Environment(TaskStore.self) private var taskStore
    @Environment(\.dismiss) private var dismiss

    @State private var taskName: String = ""
    @State private var errorMessage: String?
    @FocusState private var isTextFieldFocused: Bool

    init(parentId: UUID? = nil, level: Int = 1) {
        self.parentId = parentId
        self.level = level
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(parentId == nil ? "New Task" : "New Subtask")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color.slidooText)
                .padding(.bottom, 12)

            TextField("Task name", text: $taskName)
                .textFieldStyle(.plain)
                .font(.system(size: 16))
                .foregroundStyle(Color.slidooText)
                .padding(12)
                .background(Color.slidooInputBg)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            isTextFieldFocused ? Color.slidooInputFocusBorder : Color.slidooInputBorder,
                            lineWidth: 1
                        )
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .focused($isTextFieldFocused)
                .onChange(of: taskName) { _, newValue in
                    if newValue.count > 100 {
                        taskName = String(newValue.prefix(100))
                    }
                    errorMessage = nil
                }
                .onSubmit {
                    attemptCreate()
                }

            if let errorMessage {
                Text(errorMessage)
                    .font(.system(size: 13))
                    .foregroundStyle(Color.slidooError)
                    .padding(.top, 6)
            }

            HStack(spacing: 8) {
                Button("Cancel") {
                    dismiss()
                }
                .buttonStyle(.plain)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.slidooTextSecondary)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.slidooCancelBg)
                .clipShape(RoundedRectangle(cornerRadius: 8))

                Button("Add") {
                    attemptCreate()
                }
                .buttonStyle(.plain)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.slidooText)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(
                    taskName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                        ? Color.slidooPrimary.opacity(0.4)
                        : Color.slidooPrimary
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .disabled(taskName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding(.top, 8)
        }
        .padding(16)
        .frame(width: 360)
        .background(Color.slidooBg)
        .onAppear {
            isTextFieldFocused = true
        }
    }

    private func attemptCreate() {
        let trimmed = taskName.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            errorMessage = "Task name cannot be empty"
            return
        }
        taskStore.addTask(name: trimmed, parentId: parentId, level: level)
        dismiss()
    }
}
