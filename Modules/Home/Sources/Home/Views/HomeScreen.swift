import SwiftUI
import DesignSystem
import Observation

struct HomeScreen<ViewModel: HomeViewModelProtocol & Observable>: View {
    @State private var viewModel: ViewModel
    @State private var transitionController = HomeEntryTransitionController()

    let searchContext: HomeSearchContext
    let searchActivitiesOverride: [ActivityItem]?
    let presentationMode: HomeFeaturePresentationMode
    let entryTransition: DSMotion.HomeTransitions.Entry.Transition
    let searchEntryShouldAnimate: Bool
    let onSeeAllTap: (() -> Void)?

    init(
        viewModel: ViewModel,
        searchContext: HomeSearchContext,
        searchActivitiesOverride: [ActivityItem]?,
        presentationMode: HomeFeaturePresentationMode,
        entryTransition: DSMotion.HomeTransitions.Entry.Transition,
        searchEntryShouldAnimate: Bool,
        onSeeAllTap: (() -> Void)?
    ) {
        self.searchContext = searchContext
        self.searchActivitiesOverride = searchActivitiesOverride
        self.presentationMode = presentationMode
        self.entryTransition = entryTransition
        self.searchEntryShouldAnimate = searchEntryShouldAnimate
        self.onSeeAllTap = onSeeAllTap
        self._viewModel = State(initialValue: viewModel)
    }

    private var visibleActivities: [ActivityItem] {
        if isSearchOnly, let searchActivitiesOverride {
            return filter(searchActivitiesOverride, using: searchContext.text)
        }
        return viewModel.filteredActivities(using: searchContext.text)
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

            switch viewModel.state {
            case .loading:
                ProgressView()
                    .tint(.primary)
            case .error:
                VStack(spacing: 10) {
                    Text("Could not load Home")
                        .font(.headline.weight(.semibold))
                    Text("Please try again.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            case .content:
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
        }
        .task {
            await viewModel.loadIfNeeded()
        }
        .onAppear {
            transitionController.runSearchEntryTransitionIfNeeded(
                isSearchOnly: isSearchOnly,
                shouldAnimateFromHome: searchEntryShouldAnimate
            )
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

        HomeCardInvoiceSection(
            invoice: viewModel.cardInvoice,
            amountText: viewModel.displayCardInvoiceAmount,
            availableLimitText: viewModel.displayCardAvailableLimit
        )
            .transition(.opacity)
    }

    private var activitySection: some View {
        HomeActivitySection(
            activities: visibleActivities,
            title: isSearchOnly ? "Recent Activity" : (searchContext.isSearching ? "Search Activities" : "Recent Activity"),
            trailingTitle: isSearchOnly ? nil : "See all",
            onSeeAllTap: isSearchOnly ? nil : onSeeAllTap
        )
        .transition(.opacity)
    }

    private func filter(_ activities: [ActivityItem], using query: String) -> [ActivityItem] {
        let normalizedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard normalizedQuery.isEmpty == false else { return activities }

        return activities.filter { item in
            item.title.localizedCaseInsensitiveContains(normalizedQuery)
                || item.dateText.localizedCaseInsensitiveContains(normalizedQuery)
                || item.status.title.localizedCaseInsensitiveContains(normalizedQuery)
                || item.amountText.localizedCaseInsensitiveContains(normalizedQuery)
        }
    }
}

#Preview {
    HomeScreen(
        viewModel: HomeViewModel(),
        searchContext: .empty,
        searchActivitiesOverride: nil,
        presentationMode: .full,
        entryTransition: .none,
        searchEntryShouldAnimate: true,
        onSeeAllTap: nil
    )
}
