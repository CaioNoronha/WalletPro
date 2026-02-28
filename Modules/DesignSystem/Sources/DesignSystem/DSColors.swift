import SwiftUI
import UIKit

public extension Color {
    static let ds = DSColors()
}

public struct DSColors: Sendable {
    public init() {}

    public var background: Color { color(named: "Colors/background", fallback: "background") }
    public var primary1: Color { color(named: "Colors/primary_1", fallback: "primary_1") }
    public var primary2: Color { color(named: "Colors/primary_2", fallback: "primary_2") }
    public var launchBackground: Color { color(named: "Colors/LaunchBackground", fallback: "LaunchBackground") }

    private func color(named name: String, fallback: String) -> Color {
        if let uiColor = UIColor(named: name, in: .main, compatibleWith: nil)
            ?? UIColor(named: fallback, in: .main, compatibleWith: nil) {
            return Color(uiColor: uiColor)
        }

#if DEBUG
        assertionFailure("Missing color asset. Tried '\(name)' and '\(fallback)'.")
#endif
        return .primary
    }
}
