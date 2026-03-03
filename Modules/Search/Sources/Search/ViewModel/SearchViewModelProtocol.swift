import Utils

@MainActor
protocol SearchViewModelProtocol: AnyObject {
    var state: ScreenState { get }
    var suggestedQueries: [SearchSuggestion] { get }
    func loadSuggestionsIfNeeded() async
}
