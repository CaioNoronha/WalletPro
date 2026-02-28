import SwiftUI
import DesignSystem

struct HomeSearchContext {
    let text: String
    let isPresented: Bool

    var isSearching: Bool {
        isPresented || normalizedText.isEmpty == false
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
    private let searchContext: HomeSearchContext
    private let presentationMode: HomeFeaturePresentationMode
    private let entryTransition: DSMotion.HomeTransitions.Entry.Transition

    public init(
        searchText: String = "",
        isSearchPresented: Bool = false,
        presentationMode: HomeFeaturePresentationMode = .full,
        entryTransition: DSMotion.HomeTransitions.Entry.Transition = .none
    ) {
        self.searchContext = HomeSearchContext(
            text: searchText,
            isPresented: isSearchPresented
        )
        self.presentationMode = presentationMode
        self.entryTransition = entryTransition
    }

    public var body: some View {
        HomeScreen(
            searchContext: searchContext,
            presentationMode: presentationMode,
            entryTransition: entryTransition
        )
    }
}

#Preview {
    HomeFeatureView()
}
