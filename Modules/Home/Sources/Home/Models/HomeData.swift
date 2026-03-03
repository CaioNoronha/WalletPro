import Foundation

// MARK: - Activity Item
public struct ActivityItem: Identifiable, Decodable, Sendable {
    public let id: String
    let title: String
    let dateText: String
    let status: ActivityStatus
    let amountText: String
    let avatarText: String

    public init(
        id: String,
        title: String,
        dateText: String,
        status: ActivityStatus,
        amountText: String,
        avatarText: String
    ) {
        self.id = id
        self.title = title
        self.dateText = dateText
        self.status = status
        self.amountText = amountText
        self.avatarText = avatarText
    }
}

// MARK: - Activity Status
public enum ActivityStatus: String, Decodable, Sendable {
    case success
    case failed

    public var title: String {
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
