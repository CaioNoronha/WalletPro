import Foundation
import Observation

@MainActor
@Observable
final class HomeViewModel {
    let user = WalletUser(
        firstName: "Cooper",
        subtitle: "Ready to start your today"
    )

    let balance = BalanceSummary(
        title: "My Balance",
        amount: 3890.99,
        currencySymbol: "$"
    )

    let quickActions: [QuickAction] = [
        QuickAction(id: "topup", title: "Top Up", systemImage: "creditcard.and.123"),
        QuickAction(id: "transfer", title: "Transfer", systemImage: "arrow.left.arrow.right"),
        QuickAction(id: "bill", title: "Bill", systemImage: "doc.text"),
        QuickAction(id: "withdraw", title: "Withdraw", systemImage: "qrcode.viewfinder")
    ]

    let promo = PromoHighlight(
        title: "Discount up to",
        discountText: "25%",
        subtitle: "minimum transaction $500\nin IKEA with Credit Card",
        dateRange: "25-29 June 2025",
        legalText: "Term of Condition",
        ctaTitle: "See Details"
    )

    let activities: [ActivityItem] = [
        ActivityItem(id: "a1", title: "Transfer to Andi", status: .success, amountText: "$34", avatarText: "A"),
        ActivityItem(id: "a2", title: "Top Up to Klarna", status: .success, amountText: "$90", avatarText: "K."),
        ActivityItem(id: "a3", title: "Transfer to From", status: .failed, amountText: "$27", avatarText: "F")
    ]

    var formattedBalance: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        let value = NSDecimalNumber(decimal: balance.amount)
        let amountText = formatter.string(from: value) ?? "0.00"
        return "\(balance.currencySymbol)\(amountText)"
    }
}
