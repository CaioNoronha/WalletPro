import SwiftUI
import Home

public struct NavigationRootView: View {
    @State private var selectedTab: AppTab = .home
    @State private var searchText = ""

    public init() {}

    public var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house", value: AppTab.home) {
                HomeFeatureView()
            }

            Tab("Activity", systemImage: "chart.bar.xaxis", value: AppTab.activity) {
                NavigationPlaceholderView(title: "Activity", systemImage: "chart.bar.xaxis")
            }

            Tab("Rewards", systemImage: "gift", value: AppTab.rewards) {
                NavigationPlaceholderView(title: "Rewards", systemImage: "gift")
            }

            Tab("Profile", systemImage: "person.crop.circle", value: AppTab.profile) {
                NavigationPlaceholderView(title: "Profile", systemImage: "person.crop.circle")
            }

            Tab(value: AppTab.search, role: .search) {
                NavigationNativeSearchTabView(searchText: $searchText)
            }
        }
        .tint(Color(red: 0.78, green: 0.58, blue: 0.98))
    }
}

#Preview {
    NavigationRootView()
}
