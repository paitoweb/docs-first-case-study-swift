import SwiftUI

// MARK: - Color Tokens

extension Color {
    static let slidooBg = Color(hex: "#1B2838")
    static let slidooHeader = Color.black.opacity(0.3)
    static let slidooText = Color.white
    static let slidooTextSecondary = Color.white.opacity(0.7)
    static let slidooInputBg = Color.white.opacity(0.1)
    static let slidooInputBorder = Color.white.opacity(0.2)
    static let slidooInputFocusBorder = Color.white.opacity(0.5)
    static let slidooError = Color(hex: "#E74C3C")
    static let slidooPrimary = Color(hex: "#4A90D9")
    static let slidooButtonActive = Color.white.opacity(0.15)
    static let slidooCancelBg = Color.white.opacity(0.1)
    static let slidooBadgeBg = Color.white.opacity(0.25)
    static let slidooColorPickerBg = Color.black.opacity(0.3)
}

// MARK: - Spacing Tokens

extension CGFloat {
    static let slidooHeaderHeight: CGFloat = 56
    static let slidooTaskBarHeight: CGFloat = 64
    static let slidooTaskBarGap: CGFloat = 8
    static let slidooPaddingX: CGFloat = 20
    static let slidooAddButtonSize: CGFloat = 40
    static let slidooBadgeSize: CGFloat = 22
    static let slidooBadgeMarginLeft: CGFloat = 8
    static let slidooColorSwatchSize: CGFloat = 40
    static let slidooColorSwatchGap: CGFloat = 12
    static let slidooDateRowHeight: CGFloat = 20
    static let slidooDateRowPaddingTop: CGFloat = 4
    static let slidooOverdueBorderWidth: CGFloat = 3
}
