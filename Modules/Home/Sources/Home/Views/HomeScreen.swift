import SwiftUI
import DesignSystem

struct HomeScreen: View {
    @State private var viewModel = HomeViewModel()
    @State private var transitionController = HomeEntryTransitionController()

    let searchContext: HomeSearchContext
    let presentationMode: HomeFeaturePresentationMode
    let entryTransition: DSMotion.HomeTransitions.Entry.Transition

    private var visibleActivities: [ActivityItem] {
        viewModel.filteredActivities(using: searchContext.text)
    }

    private var isSearchOnly: Bool {
        presentationMode == .searchOnly
    }

    private var effectiveActivitiesTopInset: CGFloat {
        isSearchOnly ? transitionController.searchEntryInset : transitionController.homeEntryInset
    }

    private var shouldShowMainSections: Bool {
        isSearchOnly == false
            && searchContext.isSearching == false
            && transitionController.isAnimatingHomeEntry == false
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
                    .animation(.easeInOut(duration: DSMotion.HomeTransitions.Duration.sectionFade), value: shouldShowMainSections)

                    if effectiveActivitiesTopInset > 0 {
                        Color.clear
                            .frame(height: effectiveActivitiesTopInset)
                            .animation(.easeInOut(duration: DSMotion.HomeTransitions.Duration.entrySlide), value: effectiveActivitiesTopInset)
                    }

                    activitySection

                    Color.clear.frame(height: 110)
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
            }
        }
        .onAppear {
            transitionController.runSearchEntryTransitionIfNeeded(isSearchOnly: isSearchOnly)
        }
        .onChange(of: entryTransition) {
            transitionController.runHomeEntryTransitionIfNeeded(
                isSearchOnly: isSearchOnly,
                entryTransition: entryTransition
            )
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
}

#Preview {
    HomeScreen(
        searchContext: .empty,
        presentationMode: .full,
        entryTransition: .none
    )
}
