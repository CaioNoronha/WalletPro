import SwiftUI

public extension Color {
    static let ds = DSColors()
}

public struct DSColors: Sendable {
    public init() {}

    public var primary: Color { Color("Colors/primary") }
    public var primary1: Color { Color("Colors/primary_1") }
    public var launchBackground: Color { Color("Colors/LaunchBackground") }
}
