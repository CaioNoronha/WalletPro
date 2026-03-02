import Foundation
import Observation
import Utils

@MainActor
@Observable
public final class HomeViewModel: HomeViewModelProtocol {
    // MARK: - Variables

    var state: HomeScreenState = .loading
    var isBalanceHidden = false

    private var hasLoaded = false
    private var homeData = HomeViewModel.mockedHomeData

    var user: String { homeData.user }

    var balance: BalanceSummary {
        homeData.balance
    }

    var cardInvoice: CardInvoiceSummary {
        homeData.cardInvoice
    }

    var quickActions: [HomeQuickAction] { homeData.quickActions }
    var activities: [ActivityItem] { homeData.activities }

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

    init() {}

    // MARK: - Methods

    func loadIfNeeded() async {
        guard hasLoaded == false else { return }
        hasLoaded = true
        state = .content
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

    private static let mockedHomeData = HomeData(
        user: "Cooper",
        balance: BalanceSummary(
            title: "Account Balance",
            amount: 3890.99,
            currencySymbol: "$"
        ),
        cardInvoice: CardInvoiceSummary(
            title: "Card Statement",
            amount: 1200.00,
            availableLimit: 4000.00,
            currencySymbol: "$",
            isOpen: true
        ),
        quickActions: [
            HomeQuickAction(id: "topup", title: "Top Up", systemImage: "creditcard.and.123"),
            HomeQuickAction(id: "transfer", title: "Transfer", systemImage: "arrow.left.arrow.right"),
            HomeQuickAction(id: "bill", title: "Bill", systemImage: "doc.text"),
            HomeQuickAction(id: "withdraw", title: "Withdraw", systemImage: "qrcode.viewfinder")
        ],
        activities: [
            ActivityItem(id: "a1", title: "Transfer to Andi", dateText: "21 fev. 2026", status: .success, amountText: "$34", avatarText: "A"),
            ActivityItem(id: "a2", title: "Top Up to Klarna", dateText: "20 fev. 2026", status: .success, amountText: "$90", avatarText: "K."),
            ActivityItem(id: "a3", title: "Transfer to Andry", dateText: "19 fev. 2026", status: .failed, amountText: "$27", avatarText: "C"),
            ActivityItem(id: "a4", title: "Top Up to Aero", dateText: "18 fev. 2026", status: .success, amountText: "$16", avatarText: "G"),
            ActivityItem(id: "a5", title: "Top Up to Cleber", dateText: "17 fev. 2026", status: .success, amountText: "$47", avatarText: "A")
        ]
    )
}
