import Foundation

// MARK: - Activity Item
struct ActivityItem: Identifiable, Decodable, Sendable {
    let id: String
    let title: String
    let dateText: String
    let status: ActivityStatus
    let amountText: String
    let avatarText: String
}

// MARK: - Activity Status
enum ActivityStatus: String, Decodable, Sendable {
    case success
    case failed

    var title: String {
        switch self {
        case .success:
            "Success"
        case .failed:
            "Failed"
        }
    }
}

// MARK: - Balance Summary
struct BalanceSummary: Decodable, Sendable {
    let title: String
    let amount: Decimal
    let currencySymbol: String
}

// MARK: - Card Invoice Summary
struct CardInvoiceSummary: Decodable, Sendable {
    let title: String
    let amount: Decimal
    let availableLimit: Decimal
    let currencySymbol: String
    let isOpen: Bool
}

// MARK: - Home Quick Action
struct HomeQuickAction: Identifiable, Decodable, Sendable {
    let id: String
    let title: String
    let systemImage: String
}

// MARK: - Home Data
public struct HomeData: Decodable, Sendable {
    let user: String
    let balance: BalanceSummary
    let cardInvoice: CardInvoiceSummary
    let quickActions: [HomeQuickAction]
    let activities: [ActivityItem]
}
