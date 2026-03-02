public protocol NetworkTransport: Sendable {
    func send(_ request: NetworkRequest) async throws -> NetworkResponse
}
