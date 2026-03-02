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
    private let dataProvider: any HomeDataProvider

    var user: String { homeData?.user ?? "--" }

    var balance: BalanceSummary {
        homeData?.balance ?? BalanceSummary(title: "Account Balance", amount: 0, currencySymbol: "$")
    }

    var cardInvoice: CardInvoiceSummary {
        homeData?.cardInvoice ?? CardInvoiceSummary(
            title: "Card Statement",
            amount: 0,
            availableLimit: 0,
            currencySymbol: "$",
            isOpen: true
        )
    }

    var quickActions: [HomeQuickAction] { homeData?.quickActions ?? [] }
    var activities: [ActivityItem] { homeData?.activities ?? [] }

    var displayBalance: String {
        if isBalanceHidden {
            return Masking.hiddenAmount
        }

        return CurrencyFormatting.amount(balance.amount, currencySymbol: balance.currencySymbol)
    }

    var displayCardInvoiceAmount: String {
        if isBalanceHidden {
            return Masking.hiddenAmount
        }

        return CurrencyFormatting.amount(cardInvoice.amount, currencySymbol: cardInvoice.currencySymbol)
    }

    var displayCardAvailableLimit: String {
        if isBalanceHidden {
            return Masking.hiddenAmount
        }

        return CurrencyFormatting.amount(cardInvoice.availableLimit, currencySymbol: cardInvoice.currencySymbol)
    }

    // MARK: - Initializer

    init(dataProvider: any HomeDataProvider = MockHomeDataProvider()) {
        self.dataProvider = dataProvider
    }

    // MARK: - Methods

    func loadIfNeeded() async {
        guard hasLoaded == false else { return }
        hasLoaded = true
        state = .loading

        do {
            homeData = try await dataProvider.fetchHomeData()
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

}
