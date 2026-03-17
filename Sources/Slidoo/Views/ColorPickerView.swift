import SwiftUI

struct ColorPickerView: View {
    let currentColor: String
    let onColorSelected: (String) -> Void

    var body: some View {
        HStack(spacing: .slidooColorSwatchGap) {
            ForEach(TaskColorPalette.colors, id: \.self) { hex in
                Circle()
                    .fill(Color(hex: hex))
                    .frame(width: .slidooColorSwatchSize, height: .slidooColorSwatchSize)
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: hex == currentColor ? 2 : 0)
                    )
                    .scaleEffect(hex == currentColor ? 1.15 : 1.0)
                    .animation(.easeInOut(duration: 0.15), value: currentColor)
                    .contentShape(Circle())
                    .onTapGesture {
                        onColorSelected(hex)
                    }
            }
        }
        .padding(16)
        .background(Color.slidooColorPickerBg)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
