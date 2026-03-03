import Foundation
import Network
import Utils

protocol SearchWorkerProtocol: Sendable {
    func fetchActivities() async throws -> [SearchActivity]
}

struct SearchWorker: SearchWorkerProtocol {

    // MARK: - Variables

    private let network: any NetworkManagerProtocol

    // MARK: - Initializer

    init(network: any NetworkManagerProtocol) {
        self.network = network
    }

    // MARK: - Methods

    func fetchActivities() async throws -> [SearchActivity] {
        let request = SearchActivitiesRequest().networkRequest
        let data = try await network.executeRequest(request: request)
        return try JSONParser.parse(data, from: [SearchActivity].self)
    }
}

// MARK: - Search Mocked
extension SearchWorker {
    static func mocked() -> SearchWorker {
        let request = SearchActivitiesRequest().networkRequest
        let network = NetworkManagerMock(
            jsonByRoute: [
                request.routeKey: MockPayloads.searchActivities
            ]
        )

        return SearchWorker(network: network)
    }
}
