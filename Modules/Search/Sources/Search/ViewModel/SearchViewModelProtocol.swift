import Utils

@MainActor
protocol SearchViewModelProtocol: AnyObject {
    var state: ScreenState { get }
    var activities: [SearchActivity] { get }

    func loadActivitiesIfNeeded() async
    func filteredActivities(using query: String) -> [SearchActivity]
}
