import SwiftUI
import Testing
@testable import Search
import Utils
import Home

private struct SuccessSearchWorker: SearchWorkerProtocol {
    func fetchActivities() async throws -> [SearchActivity] {
        [
            SearchActivity(id: "a1", title: "Transfer", dateText: "21 fev. 2026", status: .success, amountText: "$34", avatarText: "A"),
            SearchActivity(id: "a2", title: "Klarna", dateText: "20 fev. 2026", status: .success, amountText: "$90", avatarText: "K")
        ]
    }
}

private struct FailureSearchWorker: SearchWorkerProtocol {
    struct MockError: Error {}
    func fetchActivities() async throws -> [SearchActivity] {
        throw MockError()
    }
}

@MainActor
@Test func createsSearchFeatureView() {
    let view = SearchFeatureView(searchText: .constant(""))
    #expect(String(describing: type(of: view)) == "SearchFeatureView")
}

@MainActor
@Test func loadActivitiesSuccessSetsContentState() async {
    let viewModel = SearchViewModel(worker: SuccessSearchWorker())
    await viewModel.loadActivitiesIfNeeded()

    #expect(viewModel.state == .content)
    #expect(viewModel.activities.count == 2)
}

@MainActor
@Test func loadActivitiesFailureSetsErrorState() async {
    let viewModel = SearchViewModel(worker: FailureSearchWorker())
    await viewModel.loadActivitiesIfNeeded()

    #expect(viewModel.state == .error)
}

@MainActor
@Test func filtersActivitiesByQuery() async {
    let viewModel = SearchViewModel(worker: SuccessSearchWorker())
    await viewModel.loadActivitiesIfNeeded()

    let filtered = viewModel.filteredActivities(using: "Klarna")
    #expect(filtered.count == 1)
}
