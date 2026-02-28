import Foundation
import Observation

@MainActor
@Observable
final class HomeViewModel {
    let user = "Cooper"
    var isBalanceHidden = false

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

    let activities: [ActivityItem] = [
        ActivityItem(id: "a1", title: "Transfer to Andi", status: .success, amountText: "$34", avatarText: "A"),
        ActivityItem(id: "a2", title: "Top Up to Klarna", status: .success, amountText: "$90", avatarText: "K."),
        ActivityItem(id: "a3", title: "Transfer to Andry", status: .failed, amountText: "$27", avatarText: "C"),
        ActivityItem(id: "a3", title: "Top Up to Aero", status: .success, amountText: "$16", avatarText: "G"),
        ActivityItem(id: "a3", title: "Top Up to Cleber", status: .success, amountText: "$47", avatarText: "A"),
    ]

    var displayBalance: String {
        if isBalanceHidden {
            return "••••••••"
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        let value = NSDecimalNumber(decimal: balance.amount)
        let amountText = formatter.string(from: value) ?? "0.00"
        return "\(balance.currencySymbol)\(amountText)"
    }


    func toggleBalanceVisibility() {
        isBalanceHidden.toggle()
    }
}
