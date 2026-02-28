import SwiftUI

struct HomeScreen: View {
    @State private var viewModel = HomeViewModel()

    let searchText: String
    let isSearchPresented: Bool

    private var isSearching: Bool {
        isSearchPresented || searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false
    }

    private var visibleActivities: [ActivityItem] {
        viewModel.filteredActivities(using: searchText)
    }

    var body: some View {
        ZStack {
            HomeBackgroundView()
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: isSearching ? 16 : 24) {
                    if isSearching == false {
                        HomeHeaderSection(user: viewModel.user)
                            .transition(.move(edge: .top).combined(with: .opacity))

                        HomeBalanceSection(
                            title: viewModel.balance.title,
                            balance: viewModel.displayBalance,
                            isBalanceHidden: viewModel.isBalanceHidden,
                            onToggleVisibility: viewModel.toggleBalanceVisibility
                        )
                        .transition(.move(edge: .top).combined(with: .opacity))

                        HomeQuickActionsSection(actions: viewModel.quickActions)
                            .transition(.move(edge: .top).combined(with: .opacity))
                    }

                    HomeActivitySection(
                        activities: visibleActivities,
                        title: isSearching ? "Search Activities" : "Recent Activity",
                        trailingTitle: isSearching ? nil : "See all"
                    )
                    .transition(.move(edge: .bottom).combined(with: .opacity))

                    Color.clear.frame(height: 110)
                }
                .padding(.horizontal, 20)
                .padding(.top, isSearching ? 8 : 18)
                .animation(.spring(response: 0.35, dampingFraction: 0.86), value: isSearching)
            }
        }
    }
}

#Preview {
    HomeScreen(searchText: "", isSearchPresented: false)
}
