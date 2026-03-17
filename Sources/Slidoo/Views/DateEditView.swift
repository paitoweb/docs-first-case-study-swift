import SwiftUI

struct DateEditView: View {
    let task: SlidooTask

    @Environment(TaskStore.self) private var taskStore
    @Environment(\.dismiss) private var dismiss

    @State private var hasStart: Bool
    @State private var hasEnd: Bool
    @State private var startDate: Date
    @State private var endDate: Date
    @State private var errorMessage: String?

    init(task: SlidooTask) {
        self.task = task
        _hasStart = State(initialValue: task.startDate != nil)
        _hasEnd = State(initialValue: task.endDate != nil)
        _startDate = State(initialValue: task.startDate ?? Date())
        _endDate = State(initialValue: task.endDate ?? Date())
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Set Dates")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color.slidooText)

            // Start date
            Toggle(isOn: $hasStart) {
                Text("Start date")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.slidooText)
            }
            .toggleStyle(.switch)
            .onChange(of: hasStart) { _, _ in errorMessage = nil }

            if hasStart {
                DatePicker(
                    "",
                    selection: $startDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.field)
                .labelsHidden()
                .onChange(of: startDate) { _, _ in errorMessage = nil }
            }

            Divider()
                .background(Color.slidooInputBorder)

            // End date
            Toggle(isOn: $hasEnd) {
                Text("End date")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.slidooText)
            }
            .toggleStyle(.switch)
            .onChange(of: hasEnd) { _, _ in errorMessage = nil }

            if hasEnd {
                DatePicker(
                    "",
                    selection: $endDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.field)
                .labelsHidden()
                .onChange(of: endDate) { _, _ in errorMessage = nil }
            }

            if let errorMessage {
                Text(errorMessage)
                    .font(.system(size: 13))
                    .foregroundStyle(Color.slidooError)
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

                Button("Save") {
                    attemptSave()
                }
                .buttonStyle(.plain)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.slidooText)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.slidooPrimary)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding(16)
        .frame(width: 360)
        .background(Color.slidooBg)
    }

    private func attemptSave() {
        let newStart: Date? = hasStart ? startDate : nil
        let newEnd: Date? = hasEnd ? endDate : nil

        if !DateUtils.validateDateRange(start: newStart, end: newEnd) {
            errorMessage = "End date must be on or after start date"
            return
        }

        taskStore.updateDates(task, startDate: newStart, endDate: newEnd)
        dismiss()
    }
}
