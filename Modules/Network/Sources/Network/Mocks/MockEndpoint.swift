import Foundation

public struct MockEndpoint: Sendable {
    public let statusCode: Int
    public let body: Data
    public let headers: [String: String]

    public init(statusCode: Int = 200, body: Data, headers: [String: String] = [:]) {
        self.statusCode = statusCode
        self.body = body
        self.headers = headers
    }

    public static func jsonString(
        _ json: String,
        statusCode: Int = 200,
        headers: [String: String] = [:]
    ) -> MockEndpoint {
        MockEndpoint(
            statusCode: statusCode,
            body: Data(json.utf8),
            headers: headers
        )
    }
}
