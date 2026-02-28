import SwiftUI

public extension Color {
    static let ds = DSColors()
}

public struct DSColors: Sendable {
    public init() {}

    public var background: Color { Color("Colors/background") }
    public var primary1: Color { Color("Colors/primary_1") }
    public var primary2: Color { Color("Colors/primary_2") }
    public var launchBackground: Color { Color("Colors/LaunchBackground") }
}
