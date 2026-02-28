import Foundation

enum AppTab: String, CaseIterable, Identifiable {
    case home
    case activity
    case rewards
    case profile
    case search

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home:
            "Home"
        case .activity:
            "Activity"
        case .rewards:
            "Rewards"
        case .profile:
            "Profile"
        case .search:
            "Search"
        }
    }

    var systemImage: String {
        switch self {
        case .home:
            "house"
        case .activity:
            "chart.bar.xaxis"
        case .rewards:
            "gift"
        case .profile:
            "person.crop.circle"
        case .search:
            "magnifyingglass"
        }
    }
}
