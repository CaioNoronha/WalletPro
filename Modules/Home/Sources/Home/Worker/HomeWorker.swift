import Foundation
import Network
import Utils

protocol HomeWorkerProtocol: Sendable {
    func fetchHomeData() async throws -> HomeData
}

struct HomeWorker: HomeWorkerProtocol {
    private let network: any NetworkManagerProtocol

    init(network: any NetworkManagerProtocol) {
        self.network = network
    }

    func fetchHomeData() async throws -> HomeData {
        let request = HomeDashboardRequest().networkRequest
        let data = try await network.executeRequest(request: request)
        return try JSONParser.parse(data, from: HomeData.self)
    }
}

// MARK: - Mocked Home
extension HomeWorker {
    static func mocked() -> HomeWorker {
        let request = HomeDashboardRequest().networkRequest
        let network = NetworkManagerMock(
            jsonByRoute: [
                request.routeKey: MockPayloads.homeDashboard
            ]
        )

        return HomeWorker(network: network)
    }
}
