import SwiftUI

public extension Color {
    static let ds = DSColors()
}

public struct DSColors: Sendable {
    public init() {}

    public var background: Color { Color("background", bundle: .main) }
    public var primary1: Color { Color("primary_1", bundle: .main) }
    public var primary2: Color { Color("primary_2", bundle: .main) }
    public var launchBackground: Color { Color("LaunchBackground", bundle: .main) }
}
