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
        ActivityItem(id: "a1", title: "Transfer to Andi", dateText: "21 fev. 2026", status: .success, amountText: "$34", avatarText: "A"),
        ActivityItem(id: "a2", title: "Top Up to Klarna", dateText: "20 fev. 2026", status: .success, amountText: "$90", avatarText: "K."),
        ActivityItem(id: "a3", title: "Transfer to Andry", dateText: "19 fev. 2026", status: .failed, amountText: "$27", avatarText: "C"),
        ActivityItem(id: "a4", title: "Top Up to Aero", dateText: "18 fev. 2026", status: .success, amountText: "$16", avatarText: "G"),
        ActivityItem(id: "a5", title: "Top Up to Cleber", dateText: "17 fev. 2026", status: .success, amountText: "$47", avatarText: "A")
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
