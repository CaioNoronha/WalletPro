import Foundation
import Network
import Utils

protocol SearchWorkerProtocol: Sendable {
    func fetchSuggestedQueries() async throws -> [SearchSuggestion]
}

struct SearchWorker<Client: NetworkClient>: SearchWorkerProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func fetchSuggestedQueries() async throws -> [SearchSuggestion] {
        let request = SearchSuggestionsRequest()
        return try await client.request(request.networkRequest, as: [SearchSuggestion].self)
    }
}

//MARK: Search Mocked
extension SearchWorker where Client == DefaultNetworkClient {
    static func mocked() -> SearchWorker<DefaultNetworkClient> {
        let request = SearchSuggestionsRequest()
        let transport = MockNetworkTransport(
            endpoints: [
                MockRoute(method: request.method, path: request.path): .jsonString(MockPayloads.searchSuggestions)
            ]
        )

        let client = DefaultNetworkClient(transport: transport)
        return SearchWorker(client: client)
    }
}
