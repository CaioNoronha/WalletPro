import Foundation

// MARK: - HTTP Method

public enum HTTPMethod: String, Sendable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

// MARK: - Network Request

public struct NetworkRequest: Sendable {

    // MARK: Properties

    public let path: String
    public let method: HTTPMethod
    public let query: [String: String]
    public let headers: [String: String]
    public let body: Data?

    // MARK: Initializer

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

    // MARK: Helpers

    public var routeKey: String {
        "\(method.rawValue) \(path)"
    }
}

// MARK: - Network Error

public enum NetworkError: Error, LocalizedError, Sendable {
    case invalidURL
    case invalidStatusCode(Int)
    case invalidData
    case mockRouteNotFound(String)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case let .invalidStatusCode(code):
            return "Network returned status code \(code)."
        case .invalidData:
            return "Failed to decode response data."
        case let .mockRouteNotFound(route):
            return "No mock registered for route: \(route)"
        }
    }
}
