import Foundation

public enum DateFormatting {
    public static func shortDate(
        _ date: Date,
        locale: Locale = .current
    ) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
