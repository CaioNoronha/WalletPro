import Foundation
import Observation
import Utils

@MainActor
@Observable
public final class HomeViewModel: HomeViewModelProtocol {
    
    // MARK: - Variables
    var state: ScreenState = .loading
    var isBalanceHidden = false

    private var hasLoaded = false
    private var homeData: HomeData?
    private let worker: any HomeWorkerProtocol

    var user: String { data.user }
    var balance: BalanceSummary { data.balance }
    var cardInvoice: CardInvoiceSummary { data.cardInvoice }
    var quickActions: [HomeQuickAction] { data.quickActions }
    var activities: [ActivityItem] { data.activities }

    var displayBalance: String {
        formattedAmount(balance.amount, currencySymbol: balance.currencySymbol)
    }

    var displayCardInvoiceAmount: String {
        formattedAmount(cardInvoice.amount, currencySymbol: cardInvoice.currencySymbol)
    }

    var displayCardAvailableLimit: String {
        formattedAmount(cardInvoice.availableLimit, currencySymbol: cardInvoice.currencySymbol)
    }

    // MARK: - Initializer

    init(worker: any HomeWorkerProtocol = HomeWorker()) {
        self.worker = worker
    }

    // MARK: - Methods

    func loadIfNeeded() async {
        guard hasLoaded == false else { return }
        hasLoaded = true
        state = .loading

        do {
            homeData = try await worker.fetchHomeData()
            state = .content
        } catch {
            state = .error
            hasLoaded = false
        }
    }

    func filteredActivities(using query: String) -> [ActivityItem] {
        let normalizedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard normalizedQuery.isEmpty == false else { return activities }

        return activities.filter { item in
            matches(item, query: normalizedQuery)
        }
    }

    func toggleBalanceVisibility() {
        isBalanceHidden.toggle()
    }

    private func matches(_ item: ActivityItem, query: String) -> Bool {
        item.title.localizedCaseInsensitiveContains(query)
            || item.dateText.localizedCaseInsensitiveContains(query)
            || item.status.title.localizedCaseInsensitiveContains(query)
            || item.amountText.localizedCaseInsensitiveContains(query)
    }

    private var data: HomeData {
        homeData ?? Self.placeholderData
    }

    private func formattedAmount(_ amount: Decimal, currencySymbol: String) -> String {
        guard isBalanceHidden == false else { return Masking.hiddenAmount }
        return CurrencyFormatting.amount(amount, currencySymbol: currencySymbol)
    }

    private static let placeholderData = HomeData(
        user: "--",
        balance: BalanceSummary(
            title: "Account Balance",
            amount: 0,
            currencySymbol: "$"
        ),
        cardInvoice: CardInvoiceSummary(
            title: "Card Statement",
            amount: 0,
            availableLimit: 0,
            currencySymbol: "$",
            isOpen: true
        ),
        quickActions: [],
        activities: []
    )

}
