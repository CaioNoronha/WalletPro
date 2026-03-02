import Foundation

@MainActor
protocol HomeViewModelProtocol: AnyObject {
    var state: HomeScreenState { get }
    var isBalanceHidden: Bool { get set }

    var user: String { get }
    var balance: BalanceSummary { get }
    var cardInvoice: CardInvoiceSummary { get }
    var quickActions: [HomeQuickAction] { get }
    var activities: [ActivityItem] { get }

    var displayBalance: String { get }
    var displayCardInvoiceAmount: String { get }
    var displayCardAvailableLimit: String { get }

    func loadIfNeeded() async
    func filteredActivities(using query: String) -> [ActivityItem]
    func toggleBalanceVisibility()
}

enum HomeScreenState: Equatable {
    case loading
    case content
    case error
}
