import SwiftUI
import Home
import Search
import DesignSystem

public struct NavigationRootView: View {
    @State private var coordinator = NavigationCoordinator()

    public init() {}

    public var body: some View {
        TabView(selection: selectedTabBinding) {
            Tab("Home", systemImage: "house", value: AppTab.home) {
                HomeFeatureView(entryTransition: coordinator.homeEntryTransition)
            }

            Tab("Rewards", systemImage: "gift", value: AppTab.rewards) {
                NavigationPlaceholderView(title: "Rewards", systemImage: "gift")
            }

            Tab("Profile", systemImage: "person.crop.circle", value: AppTab.profile) {
                NavigationPlaceholderView(title: "Profile", systemImage: "person.crop.circle")
            }

            Tab(value: AppTab.search, role: .search) {
                SearchFeatureView(searchText: searchTextBinding)
            }
        }
        .tint(Color.ds.primary2)
    }

    private var selectedTabBinding: Binding<AppTab> {
        Binding(
            get: { coordinator.selectedTab },
            set: { coordinator.selectTab($0) }
        )
    }

    private var searchTextBinding: Binding<String> {
        Binding(
            get: { coordinator.searchText },
            set: { coordinator.searchText = $0 }
        )
    }
}

#Preview {
    NavigationRootView()
}
