import SwiftUI
import DesignSystem

struct HomeScreen: View {
    @State private var viewModel = HomeViewModel()
    @State private var isAnimatingHomeEntry = false
    @State private var homeEntryInset: CGFloat = 0
    @State private var searchEntryInset: CGFloat = DSMotion.HomeTransitions.sharedEntryInset

    let searchContext: HomeSearchContext
    let presentationMode: HomeFeaturePresentationMode
    let entryTransitionSource: HomeFeatureEntryTransitionSource
    let entryTransitionToken: Int

    private var visibleActivities: [ActivityItem] {
        viewModel.filteredActivities(using: searchContext.text)
    }

    private var isSearchOnly: Bool {
        presentationMode == .searchOnly
    }

    private var effectiveActivitiesTopInset: CGFloat {
        isSearchOnly ? searchEntryInset : homeEntryInset
    }

    private var shouldShowMainSections: Bool {
        isSearchOnly == false
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
                    .animation(.easeInOut(duration: DSMotion.HomeTransitions.sectionFadeDuration), value: shouldShowMainSections)

                    if effectiveActivitiesTopInset > 0 {
                        Color.clear
                            .frame(height: effectiveActivitiesTopInset)
                            .animation(.easeInOut(duration: DSMotion.HomeTransitions.homeEntrySlideDuration), value: effectiveActivitiesTopInset)
                    }

                    activitySection

                    Color.clear.frame(height: 110)
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
            }
        }
        .onAppear {
            runSearchEntryTransitionIfNeeded()
        }
        .onChange(of: entryTransitionToken) {
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
            title: isSearchOnly ? "Recent Activity" : (searchContext.isSearching ? "Search Activities" : "Recent Activity"),
            trailingTitle: isSearchOnly ? nil : "See all"
        )
        .transition(.opacity)
    }

    private func runSearchEntryTransitionIfNeeded() {
        guard isSearchOnly else { return }

        searchEntryInset = DSMotion.HomeTransitions.sharedEntryInset
        withAnimation(.easeInOut(duration: DSMotion.HomeTransitions.homeEntrySlideDuration)) {
            searchEntryInset = 0
        }
    }

    private func runHomeEntryTransitionIfNeeded() {
        guard isSearchOnly == false, entryTransitionSource == .search else {
            return
        }

        isAnimatingHomeEntry = true
        homeEntryInset = DSMotion.HomeTransitions.sharedEntryInset

        withAnimation(.easeInOut(duration: DSMotion.HomeTransitions.homeEntrySlideDuration)) {
            homeEntryInset = 0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + DSMotion.HomeTransitions.homeEntryRevealDelay) {
            withAnimation(.easeInOut(duration: DSMotion.HomeTransitions.homeEntryRevealDuration)) {
                isAnimatingHomeEntry = false
            }
        }
    }
}

#Preview {
    HomeScreen(
        searchContext: .empty,
        presentationMode: .full,
        entryTransitionSource: .none,
        entryTransitionToken: 0
    )
}
