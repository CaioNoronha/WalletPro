import Home

struct SearchActivity: Identifiable, Hashable, Sendable, Decodable {
    let id: String
    let title: String
    let dateText: String
    let status: ActivityStatus
    let amountText: String
    let avatarText: String
}
