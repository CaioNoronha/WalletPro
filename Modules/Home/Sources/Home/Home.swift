import SwiftUI

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

public enum HomeFeatureEntryTransitionSource: Sendable {
    case none
    case search
}

public struct HomeFeatureView: View {
    private let searchContext: HomeSearchContext
    private let presentationMode: HomeFeaturePresentationMode
    private let entryTransitionSource: HomeFeatureEntryTransitionSource
    private let entryTransitionToken: Int

    public init(
        searchText: String = "",
        isSearchPresented: Bool = false,
        presentationMode: HomeFeaturePresentationMode = .full,
        entryTransitionSource: HomeFeatureEntryTransitionSource = .none,
        entryTransitionToken: Int = 0
    ) {
        self.searchContext = HomeSearchContext(
            text: searchText,
            isPresented: isSearchPresented
        )
        self.presentationMode = presentationMode
        self.entryTransitionSource = entryTransitionSource
        self.entryTransitionToken = entryTransitionToken
    }

    public var body: some View {
        HomeScreen(
            searchContext: searchContext,
            presentationMode: presentationMode,
            entryTransitionSource: entryTransitionSource,
            entryTransitionToken: entryTransitionToken
        )
    }
}

#Preview {
    HomeFeatureView()
}
