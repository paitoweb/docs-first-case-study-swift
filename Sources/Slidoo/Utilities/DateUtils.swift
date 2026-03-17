import Foundation

enum DateUtils {
    private static let displayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "d MMM yyyy"
        f.locale = Locale(identifier: "en_US_POSIX")
        return f
    }()

    static func formatDateLabel(_ date: Date, prefix: String) -> String {
        "\(prefix) \(displayFormatter.string(from: date).uppercased())"
    }

    static func daysLeft(until endDate: Date) -> Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let end = calendar.startOfDay(for: endDate)
        return calendar.dateComponents([.day], from: today, to: end).day ?? 0
    }

    static func daysLeftText(until endDate: Date, progress: Int) -> (text: String?, isOverdue: Bool) {
        let days = daysLeft(until: endDate)
        if days > 1 {
            return ("\(days) DAYS LEFT", false)
        } else if days == 1 {
            return ("1 DAY LEFT", false)
        } else if days == 0 {
            return ("TODAY", false)
        } else if progress < 100 {
            return ("OVERDUE", true)
        } else {
            return (nil, false)
        }
    }

    static func isOverdue(endDate: Date?, progress: Int) -> Bool {
        guard let endDate else { return false }
        return daysLeft(until: endDate) < 0 && progress < 100
    }

    static func validateDateRange(start: Date?, end: Date?) -> Bool {
        guard let start, let end else { return true }
        let calendar = Calendar.current
        return calendar.startOfDay(for: end) >= calendar.startOfDay(for: start)
    }
}
