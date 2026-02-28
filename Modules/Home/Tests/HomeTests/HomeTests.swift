import Testing
@testable import Home

@MainActor
@Test func filtersActivitiesByQuery() {
    let viewModel = HomeViewModel()

    let titleMatches = viewModel.filteredActivities(using: "Klarna")
    #expect(titleMatches.count == 1)

    let dateMatches = viewModel.filteredActivities(using: "21 fev. 2026")
    #expect(dateMatches.count == 1)

    let amountMatches = viewModel.filteredActivities(using: "$27")
    #expect(amountMatches.count == 1)

    let allItems = viewModel.filteredActivities(using: "")
    #expect(allItems.count == viewModel.activities.count)
}
