import SwiftUI

struct HomeScreen: View {
    @State private var viewModel = HomeViewModel()

    let searchContext: HomeSearchContext

    private var visibleActivities: [ActivityItem] {
        viewModel.filteredActivities(using: searchContext.text)
    }

    var body: some View {
        ZStack {
            HomeBackgroundView()
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    Group {
                        if searchContext.isSearching == false {
                            mainSections
                        }
                    }
                    .animation(.easeInOut(duration: 0.30), value: searchContext.isSearching)

                    activitySection

                    Color.clear.frame(height: 110)
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
            }
        }
    }

    @ViewBuilder
    private var mainSections: some View {
        HomeHeaderSection(user: viewModel.user)
            .transition(.opacity)

        HomeBalanceSection(
            title: viewModel.balance.title,
            balance: viewModel.displayBalance,
            isBalanceHidden: viewModel.isBalanceHidden,
            onToggleVisibility: viewModel.toggleBalanceVisibility
        )
        .transition(.opacity)

        HomeQuickActionsSection(actions: viewModel.quickActions)
            .transition(.opacity)
    }

    private var activitySection: some View {
        HomeActivitySection(
            activities: visibleActivities,
            title: searchContext.isSearching ? "Search Activities" : "Recent Activity",
            trailingTitle: searchContext.isSearching ? nil : "See all"
        )
        .transition(.opacity)
    }
}

#Preview {
    HomeScreen(searchContext: .empty)
}
