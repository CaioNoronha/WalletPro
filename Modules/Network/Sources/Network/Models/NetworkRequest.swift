import Foundation

public struct NetworkRequest: Sendable {
    public let path: String
    public let method: HTTPMethod
    public let query: [String: String]
    public let headers: [String: String]
    public let body: Data?

    public init(
        path: String,
        method: HTTPMethod = .get,
        query: [String: String] = [:],
        headers: [String: String] = [:],
        body: Data? = nil
    ) {
        self.path = path
        self.method = method
        self.query = query
        self.headers = headers
        self.body = body
    }
}
