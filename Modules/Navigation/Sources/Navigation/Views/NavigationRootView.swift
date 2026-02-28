import SwiftUI
import Home
import Search
import DesignSystem

public struct NavigationRootView: View {
    @State private var selectedTab: AppTab = .home
    @State private var previousTab: AppTab = .home
    @State private var searchText = ""
    @State private var homeEntryTransitionToken = 0
    @State private var homeEntryTransitionSource: HomeFeatureEntryTransitionSource = .none

    public init() {}

    public var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house", value: AppTab.home) {
                HomeFeatureView(
                    entryTransitionSource: homeEntryTransitionSource,
                    entryTransitionToken: homeEntryTransitionToken
                )
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
                SearchFeatureView(searchText: $searchText)
            }
        }
        .tint(Color.ds.primary2)
        .onChange(of: selectedTab) {
            if previousTab == .search && selectedTab == .home {
                homeEntryTransitionSource = .search
                homeEntryTransitionToken += 1
            } else {
                homeEntryTransitionSource = .none
            }

            previousTab = selectedTab
        }
    }
}

#Preview {
    NavigationRootView()
}
