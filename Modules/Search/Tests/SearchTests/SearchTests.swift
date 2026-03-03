import SwiftUI
import Testing
@testable import Search
import Utils

private struct SuccessSearchWorker: SearchWorkerProtocol {
    func fetchSuggestedQueries() async throws -> [SearchSuggestion] {
        [
            SearchSuggestion(text: "Transfer"),
            SearchSuggestion(text: "Klarna")
        ]
    }
}

private struct FailureSearchWorker: SearchWorkerProtocol {
    struct MockError: Error {}
    func fetchSuggestedQueries() async throws -> [SearchSuggestion] {
        throw MockError()
    }
}

@MainActor
@Test func createsSearchFeatureView() {
    let view = SearchFeatureView(searchText: .constant(""))
    #expect(String(describing: type(of: view)) == "SearchFeatureView")
}

@MainActor
@Test func loadSuggestionsSuccessSetsContentState() async {
    let viewModel = SearchViewModel(worker: SuccessSearchWorker())
    await viewModel.loadSuggestionsIfNeeded()

    #expect(viewModel.state == .content)
    #expect(viewModel.suggestedQueries.count == 2)
}

@MainActor
@Test func loadSuggestionsFailureSetsErrorState() async {
    let viewModel = SearchViewModel(worker: FailureSearchWorker())
    await viewModel.loadSuggestionsIfNeeded()

    #expect(viewModel.state == .error)
}
