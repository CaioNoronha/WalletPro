import Foundation

protocol HomeDataProvider: Sendable {
    func fetchHomeData() async throws -> HomeData
}

struct MockHomeDataProvider: HomeDataProvider {
    func fetchHomeData() async throws -> HomeData {
        HomeData(
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
}
