import SwiftUI

struct HomeScreen: View {
    @State private var viewModel = HomeViewModel()

    let searchContext: HomeSearchContext
    let showsOnlyActivities: Bool
    let activitiesTopInset: CGFloat

    private var visibleActivities: [ActivityItem] {
        viewModel.filteredActivities(using: searchContext.text)
    }

    private var shouldShowMainSections: Bool {
        showsOnlyActivities == false && searchContext.isSearching == false
    }

    var body: some View {
        ZStack {
            HomeBackgroundView()
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    Group {
                        if shouldShowMainSections {
                            mainSections
                        }
                    }
                    .animation(.easeInOut(duration: 0.45), value: shouldShowMainSections)

                    if showsOnlyActivities {
                        Color.clear
                            .frame(height: activitiesTopInset)
                            .animation(.easeInOut(duration: 0.45), value: activitiesTopInset)
                    }

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
            title: showsOnlyActivities ? "Recent Activity" : (searchContext.isSearching ? "Search Activities" : "Recent Activity"),
            trailingTitle: showsOnlyActivities ? nil : "See all"
        )
        .transition(.opacity)
    }
}

#Preview {
    HomeScreen(searchContext: .empty, showsOnlyActivities: false, activitiesTopInset: 0)
}
