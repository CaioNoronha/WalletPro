import SwiftUI
import DesignSystem
import Observation
import Utils

struct HomeScreen<ViewModel: HomeViewModelProtocol & Observable>: View {
    @State var viewModel: ViewModel
    @State var transitionController = HomeEntryTransitionController()

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

    var body: some View {
        ZStack {
            HomeBackgroundView()
                .ignoresSafeArea()

            switch effectiveState {
            case .loading:
                ProgressView()
                    .tint(.primary)
            case .error:
                errorStateView
            case .content:
                contentView
            }
        }
        .task {
            guard shouldLoadHomeData else { return }
            await viewModel.loadIfNeeded()
        }
        .onAppear {
            if isSearchOnly, searchEntryShouldAnimate, hasSearchActivitiesForEntryAnimation == false {
                return
            }

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
        .onChange(of: searchActivitiesOverride?.count ?? 0) { _, newValue in
            guard isSearchOnly else { return }
            guard searchEntryShouldAnimate else { return }
            guard newValue > 0 else { return }
            guard effectiveActivitiesTopInset > 0 else { return }

            transitionController.runSearchEntryTransitionIfNeeded(
                isSearchOnly: isSearchOnly,
                shouldAnimateFromHome: searchEntryShouldAnimate
            )
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
