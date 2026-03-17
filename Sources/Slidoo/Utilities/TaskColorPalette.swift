import Foundation

enum TaskColorPalette {
    static let colors: [String] = [
        "#4A90D9",  // Blue (dark)
        "#5BA8C8",  // Blue (light)
        "#2ECC71",  // Green
        "#9B59B6",  // Purple
        "#E67E22",  // Orange
        "#A8D858",  // Yellow-green
        "#1ABC9C",  // Teal
    ]

    static func nextColor(forTaskCount count: Int) -> String {
        colors[count % colors.count]
    }
}
