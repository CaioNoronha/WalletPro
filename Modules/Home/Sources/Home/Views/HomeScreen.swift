import SwiftUI

struct HomeScreen: View {
    @State private var viewModel = HomeViewModel()
    @State private var isAnimatingHomeEntry = false
    @State private var homeEntryInset: CGFloat = 0

    let searchContext: HomeSearchContext
    let showsOnlyActivities: Bool
    let activitiesTopInset: CGFloat
    let homeEntryTransitionToken: Int
    let homeEntryStartInset: CGFloat

    private var visibleActivities: [ActivityItem] {
        viewModel.filteredActivities(using: searchContext.text)
    }

    private var effectiveActivitiesTopInset: CGFloat {
        showsOnlyActivities ? activitiesTopInset : homeEntryInset
    }

    private var shouldShowMainSections: Bool {
        showsOnlyActivities == false
            && searchContext.isSearching == false
            && isAnimatingHomeEntry == false
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
                    .animation(.easeInOut(duration: 0.36), value: shouldShowMainSections)

                    if effectiveActivitiesTopInset > 0 {
                        Color.clear
                            .frame(height: effectiveActivitiesTopInset)
                            .animation(.easeInOut(duration: 0.36), value: effectiveActivitiesTopInset)
                    }

                    activitySection

                    Color.clear.frame(height: 110)
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
            }
        }
        .onChange(of: homeEntryTransitionToken) {
            runHomeEntryTransitionIfNeeded()
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

    private func runHomeEntryTransitionIfNeeded() {
        guard showsOnlyActivities == false, homeEntryStartInset > 0 else {
            return
        }

        isAnimatingHomeEntry = true
        homeEntryInset = homeEntryStartInset

        withAnimation(.easeInOut(duration: 0.36)) {
            homeEntryInset = 0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
            withAnimation(.easeInOut(duration: 0.24)) {
                isAnimatingHomeEntry = false
            }
        }
    }
}

#Preview {
    HomeScreen(
        searchContext: .empty,
        showsOnlyActivities: false,
        activitiesTopInset: 0,
        homeEntryTransitionToken: 0,
        homeEntryStartInset: 0
    )
}
