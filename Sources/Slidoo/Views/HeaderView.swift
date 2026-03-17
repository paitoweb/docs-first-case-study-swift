import SwiftUI

struct HeaderView: View {
    var parentTaskName: String? = nil
    var isAtRoot: Bool = true
    var isAtMaxDepth: Bool = false
    var onAddTapped: () -> Void
    var onBackTapped: () -> Void = {}

    var body: some View {
        HStack {
            // Left side: back button or spacer
            if isAtRoot {
                Color.clear
                    .frame(width: .slidooAddButtonSize, height: .slidooAddButtonSize)
            } else {
                Button(action: onBackTapped) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24))
                        .foregroundStyle(Color.slidooText)
                        .frame(width: .slidooAddButtonSize, height: .slidooAddButtonSize)
                }
                .buttonStyle(.plain)
            }

            Spacer()

            // Center: title
            Text(parentTaskName ?? "Slidoo")
                .font(.system(size: 22, weight: .bold))
                .italic(isAtRoot)
                .tracking(isAtRoot ? 1 : 0)
                .foregroundStyle(Color.slidooText)
                .lineLimit(1)
                .truncationMode(.tail)

            Spacer()

            // Right: add button
            Button(action: onAddTapped) {
                Text("+")
                    .font(.system(size: 24))
                    .foregroundStyle(isAtMaxDepth ? Color.slidooTextSecondary : Color.slidooText)
                    .frame(width: .slidooAddButtonSize, height: .slidooAddButtonSize)
            }
            .buttonStyle(.plain)
            .background(Color.clear)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(
                    isAtMaxDepth ? Color.white.opacity(0.3) : Color.white,
                    lineWidth: 2
                )
            )
            .disabled(isAtMaxDepth)
        }
        .padding(.horizontal, .slidooPaddingX)
        .frame(height: .slidooHeaderHeight)
        .background(Color.slidooHeader)
    }
}
