import Foundation

// MARK: - Helpers
extension HomeScreen {
    func filter(_ activities: [ActivityItem], using query: String) -> [ActivityItem] {
        let normalizedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard normalizedQuery.isEmpty == false else { return activities }

        return activities.filter { item in
            item.title.localizedCaseInsensitiveContains(normalizedQuery)
                || item.dateText.localizedCaseInsensitiveContains(normalizedQuery)
                || item.status.title.localizedCaseInsensitiveContains(normalizedQuery)
                || item.amountText.localizedCaseInsensitiveContains(normalizedQuery)
        }
    }
}
