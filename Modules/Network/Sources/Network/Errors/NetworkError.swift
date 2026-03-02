import Foundation

public enum NetworkError: Error, LocalizedError, Sendable {
    case invalidStatusCode(Int)
    case decodingFailure(String)
    case transportFailure(String)
    case missingMockRoute(String)

    public var errorDescription: String? {
        switch self {
        case let .invalidStatusCode(code):
            return "Network returned status code \(code)."
        case let .decodingFailure(message):
            return "Failed to decode response: \(message)"
        case let .transportFailure(message):
            return "Transport failure: \(message)"
        case let .missingMockRoute(route):
            return "No mock registered for route: \(route)"
        }
    }
}
