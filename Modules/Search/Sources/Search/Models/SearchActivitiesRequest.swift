import Network

struct SearchActivitiesRequest {
    let path = "/search/activities"
    let method: HTTPMethod = .get

    var networkRequest: NetworkRequest {
        NetworkRequest(path: path, method: method)
    }
}
