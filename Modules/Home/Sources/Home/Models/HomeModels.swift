import Foundation

struct WalletUser {
    let firstName: String
    let subtitle: String
}

struct BalanceSummary {
    let title: String
    let amount: Decimal
    let currencySymbol: String
}

struct QuickAction: Identifiable {
    let id: String
    let title: String
    let systemImage: String
}

struct PromoHighlight {
    let title: String
    let discountText: String
    let subtitle: String
    let dateRange: String
    let legalText: String
    let ctaTitle: String
}

enum ActivityStatus {
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

struct ActivityItem: Identifiable {
    let id: String
    let title: String
    let status: ActivityStatus
    let amountText: String
    let avatarText: String
}

struct FooterTabItem: Identifiable {
    let id: String
    let title: String
    let systemImage: String
}