import Testing
@testable import Home

private struct SuccessHomeWorker: HomeWorkerProtocol {
    func fetchHomeData() async throws -> HomeData {
        HomeData(
            user: "Cooper",
            balance: BalanceSummary(title: "Account Balance", amount: 3890.99, currencySymbol: "$"),
            cardInvoice: CardInvoiceSummary(
                title: "Card Statement",
                amount: 1200.00,
                availableLimit: 4000.00,
                currencySymbol: "$",
                isOpen: true
            ),
            quickActions: [
                HomeQuickAction(id: "topup", title: "Top Up", systemImage: "creditcard.and.123")
            ],
            activities: [
                ActivityItem(id: "a1", title: "Transfer to Andi", dateText: "21 fev. 2026", status: .success, amountText: "$34", avatarText: "A"),
                ActivityItem(id: "a2", title: "Top Up to Klarna", dateText: "20 fev. 2026", status: .success, amountText: "$90", avatarText: "K."),
                ActivityItem(id: "a3", title: "Transfer to Andry", dateText: "19 fev. 2026", status: .failed, amountText: "$27", avatarText: "C")
            ]
        )
    }
}

private struct FailureHomeWorker: HomeWorkerProtocol {
    struct MockError: Error {}
    func fetchHomeData() async throws -> HomeData {
        throw MockError()
    }
}

@MainActor
@Test func loadIfNeededSuccessSetsContentState() async {
    let viewModel = HomeViewModel(worker: SuccessHomeWorker())

    await viewModel.loadIfNeeded()

    #expect(viewModel.state == .content)
    #expect(viewModel.user == "Cooper")
}

@MainActor
@Test func loadIfNeededFailureSetsErrorState() async {
    let viewModel = HomeViewModel(worker: FailureHomeWorker())

    await viewModel.loadIfNeeded()

    #expect(viewModel.state == .error)
}

@MainActor
@Test func filtersActivitiesByQuery() async {
    let viewModel = HomeViewModel()
    await viewModel.loadIfNeeded()

    let titleMatches = viewModel.filteredActivities(using: "Klarna")
    #expect(titleMatches.count == 1)

    let dateMatches = viewModel.filteredActivities(using: "21 fev. 2026")
    #expect(dateMatches.count == 1)

    let amountMatches = viewModel.filteredActivities(using: "$27")
    #expect(amountMatches.count == 1)

    let allItems = viewModel.filteredActivities(using: "")
    #expect(allItems.count == viewModel.activities.count)
}
