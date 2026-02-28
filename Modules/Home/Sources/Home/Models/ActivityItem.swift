import Foundation

struct ActivityItem: Identifiable {
    let id: String
    let title: String
    let dateText: String
    let status: ActivityStatus
    let amountText: String
    let avatarText: String
}
