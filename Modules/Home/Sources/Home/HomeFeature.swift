import SwiftUI
import DesignSystem

struct HomeSearchContext {
    let text: String
    let isPresented: Bool

    var isSearching: Bool {
        normalizedText.isEmpty == false
    }

    var normalizedText: String {
        text.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    static let empty = HomeSearchContext(text: "", isPresented: false)
}

public enum HomeFeaturePresentationMode: Sendable {
    case full
    case searchOnly
}

public struct HomeFeatureView: View {
    private let viewModel: HomeViewModel
    private let searchContext: HomeSearchContext
    private let searchActivitiesOverride: [ActivityItem]?
    private let presentationMode: HomeFeaturePresentationMode
    private let entryTransition: DSMotion.HomeTransitions.Entry.Transition
    private let searchEntryShouldAnimate: Bool
    private let onSeeAllTap: (() -> Void)?

    public init(
        viewModel: HomeViewModel = HomeViewModel(),
        searchText: String = "",
        isSearchPresented: Bool = false,
        searchActivitiesOverride: [ActivityItem]? = nil,
        presentationMode: HomeFeaturePresentationMode = .full,
        entryTransition: DSMotion.HomeTransitions.Entry.Transition = .none,
        searchEntryShouldAnimate: Bool = true,
        onSeeAllTap: (() -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.searchContext = HomeSearchContext(
            text: searchText,
            isPresented: isSearchPresented
        )
        self.searchActivitiesOverride = searchActivitiesOverride
        self.presentationMode = presentationMode
        self.entryTransition = entryTransition
        self.searchEntryShouldAnimate = searchEntryShouldAnimate
        self.onSeeAllTap = onSeeAllTap
    }

    public var body: some View {
        HomeScreen(
            viewModel: viewModel,
            searchContext: searchContext,
            searchActivitiesOverride: searchActivitiesOverride,
            presentationMode: presentationMode,
            entryTransition: entryTransition,
            searchEntryShouldAnimate: searchEntryShouldAnimate,
            onSeeAllTap: onSeeAllTap
        )
    }
}

#Preview {
    HomeFeatureView()
}
