import Foundation
import Network
import Utils

protocol HomeWorkerProtocol: Sendable {
    func fetchHomeData() async throws -> HomeData
}

struct HomeWorker<Client: NetworkClient>: HomeWorkerProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func fetchHomeData() async throws -> HomeData {
        let request = HomeDashboardRequest()
        return try await client.request(request.networkRequest, as: HomeData.self)
    }

}

// MARK: - Mocked Home
extension HomeWorker where Client == DefaultNetworkClient {
    static func mocked() -> HomeWorker<DefaultNetworkClient> {
        let request = HomeDashboardRequest()
        let transport = MockNetworkTransport(
            endpoints: [
                MockRoute(method: request.method, path: request.path): .jsonString(MockPayloads.homeDashboard)
            ]
        )
        let client = DefaultNetworkClient(transport: transport)
        return HomeWorker(client: client)
    }
}
