import Foundation
import Network
import Utils

protocol SearchWorkerProtocol: Sendable {
    func fetchSuggestedQueries() async throws -> [SearchSuggestion]
}

struct SearchWorker: SearchWorkerProtocol {
    private let network: any NetworkManagerProtocol

    init(network: any NetworkManagerProtocol) {
        self.network = network
    }

    func fetchSuggestedQueries() async throws -> [SearchSuggestion] {
        let request = SearchSuggestionsRequest().networkRequest
        let data = try await network.executeRequest(request: request)
        return try JSONParser.parse(data, from: [SearchSuggestion].self)
    }
}

// MARK: - Search Mocked
extension SearchWorker {
    static func mocked() -> SearchWorker {
        let request = SearchSuggestionsRequest().networkRequest
        let network = NetworkManagerMock(
            jsonByRoute: [
                request.routeKey: MockPayloads.searchSuggestions
            ]
        )

        return SearchWorker(network: network)
    }
}
