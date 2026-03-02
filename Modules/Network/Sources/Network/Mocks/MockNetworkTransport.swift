public struct MockNetworkTransport: NetworkTransport {
    private let endpoints: [MockRoute: MockEndpoint]

    public init(endpoints: [MockRoute: MockEndpoint]) {
        self.endpoints = endpoints
    }

    public func send(_ request: NetworkRequest) async throws -> NetworkResponse {
        let route = MockRoute(method: request.method, path: request.path)

        guard let endpoint = endpoints[route] else {
            throw NetworkError.missingMockRoute(route.routeKey)
        }

        return NetworkResponse(
            statusCode: endpoint.statusCode,
            data: endpoint.body,
            headers: endpoint.headers
        )
    }
}
