public struct MockRoute: Hashable, Sendable {
    public let method: HTTPMethod
    public let path: String

    public init(method: HTTPMethod, path: String) {
        self.method = method
        self.path = path
    }

    var routeKey: String {
        "\(method.rawValue) \(path)"
    }
}
