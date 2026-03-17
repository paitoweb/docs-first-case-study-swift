import SwiftUI

struct EmptyStateView: View {
    var isSubtaskLevel: Bool = false

    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            Text(isSubtaskLevel ? "No subtasks yet" : "No tasks yet")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(Color.slidooText)
            Text("Click the + button or press \u{2318}N to create your first \(isSubtaskLevel ? "subtask" : "task")")
                .font(.system(size: 14))
                .foregroundStyle(Color.slidooTextSecondary)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
