import Foundation
import Network

protocol SearchWorkerProtocol: Sendable {
    func fetchSuggestedQueries() async throws -> [String]
}

struct SearchWorker: SearchWorkerProtocol {
    private let client: any NetworkClient

    init(client: any NetworkClient) {
        self.client = client
    }

    func fetchSuggestedQueries() async throws -> [String] {
        let request = NetworkRequest(path: "/search/suggestions", method: .get)
        let payload = try await client.request(request, as: SuggestionsPayload.self)
        return payload.queries
    }

    static func liveMock() -> SearchWorker {
        let transport = MockNetworkTransport(
            endpoints: [
                MockRoute(method: .get, path: "/search/suggestions"): .jsonString(SearchWorkerMockData.suggestionsJSON)
            ]
        )

        let client = DefaultNetworkClient(transport: transport)
        return SearchWorker(client: client)
    }
}
