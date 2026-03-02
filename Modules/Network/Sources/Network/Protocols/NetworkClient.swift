public protocol NetworkClient: Sendable {
    
    func request<Response: Decodable>(
        _ request: NetworkRequest,
        as type: Response.Type
    ) async throws -> Response
}
