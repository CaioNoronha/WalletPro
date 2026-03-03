import Observation
import Utils

@MainActor
@Observable
final class SearchViewModel: SearchViewModelProtocol {

    // MARK: - Variables

    var state: ScreenState = .loading
    var activities: [SearchActivity] = []

    private var hasLoaded = false
    private let worker: any SearchWorkerProtocol

    // MARK: - Initializer

    init(worker: any SearchWorkerProtocol = SearchWorker.mocked()) {
        self.worker = worker
    }

    // MARK: - Methods

    func loadActivitiesIfNeeded() async {
        guard hasLoaded == false else { return }
        hasLoaded = true
        state = .loading

        do {
            activities = try await worker.fetchActivities()
            state = .content
        } catch {
            state = .error
            hasLoaded = false
        }
    }

    func filteredActivities(using query: String) -> [SearchActivity] {
        let normalizedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard normalizedQuery.isEmpty == false else { return activities }

        return activities.filter { item in
            item.title.localizedCaseInsensitiveContains(normalizedQuery)
                || item.dateText.localizedCaseInsensitiveContains(normalizedQuery)
                || item.status.title.localizedCaseInsensitiveContains(normalizedQuery)
                || item.amountText.localizedCaseInsensitiveContains(normalizedQuery)
        }
    }
}
