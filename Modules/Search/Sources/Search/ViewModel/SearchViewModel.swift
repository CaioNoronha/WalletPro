import Observation
import Utils

@MainActor
@Observable
final class SearchViewModel: SearchViewModelProtocol {
    var state: ScreenState = .loading
    var suggestedQueries: [SearchSuggestion] = []

    private var hasLoaded = false
    private let worker: any SearchWorkerProtocol

    init(worker: any SearchWorkerProtocol = SearchWorker.mocked()) {
        self.worker = worker
    }

    func loadSuggestionsIfNeeded() async {
        guard hasLoaded == false else { return }
        hasLoaded = true
        state = .loading

        do {
            suggestedQueries = try await worker.fetchSuggestedQueries()
            state = .content
        } catch {
            state = .error
            hasLoaded = false
        }
    }
}
