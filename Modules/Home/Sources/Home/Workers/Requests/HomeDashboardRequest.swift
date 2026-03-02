import Network

struct HomeDashboardRequest {
    let path = "/home/dashboard"
    let method: HTTPMethod = .get

    var networkRequest: NetworkRequest {
        NetworkRequest(path: path, method: method)
    }
}
