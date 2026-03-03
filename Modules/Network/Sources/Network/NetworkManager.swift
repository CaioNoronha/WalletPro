import Foundation


public protocol NetworkManagerProtocol: Sendable {
    func executeRequest(request: NetworkRequest) async throws -> Data
}

public struct NetworkManager: NetworkManagerProtocol {

    //MARK: Properties

    private let baseURL: URL
    private let session: URLSession

    //MARK: Initializer

    public init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    //MARK: Methods

    public func executeRequest(request: NetworkRequest) async throws -> Data {
        let urlRequest = try makeURLRequest(from: request)
        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidData
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }

        return data
    }

    private func makeURLRequest(from request: NetworkRequest) throws -> URLRequest {
        guard var components = URLComponents(
            url: baseURL.appendingPathComponent(request.path),
            resolvingAgainstBaseURL: false
        ) else {
            throw NetworkError.invalidURL
        }

        if request.query.isEmpty == false {
            components.queryItems = request.query.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body

        for (key, value) in request.headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        return urlRequest
    }
}

// MARK: - Mock Manager

public struct NetworkManagerMock: NetworkManagerProtocol {

    //MARK: Properties

    private let payloadByRoute: [String: Data]

    //MARK: Initializers

    public init(payloadByRoute: [String: Data]) {
        self.payloadByRoute = payloadByRoute
    }

    public init(jsonByRoute: [String: String]) {
        self.payloadByRoute = jsonByRoute.mapValues { Data($0.utf8) }
    }

    //MARK: Methods

    public func executeRequest(request: NetworkRequest) async throws -> Data {
        guard let data = payloadByRoute[request.routeKey] else {
            throw NetworkError.mockRouteNotFound(request.routeKey)
        }

        return data
    }
}
