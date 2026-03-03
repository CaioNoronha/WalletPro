import Network

struct SearchSuggestionsRequest {
    let path = "/search/suggestions"
    let method: HTTPMethod = .get

    var networkRequest: NetworkRequest {
        NetworkRequest(path: path, method: method)
    }
}
