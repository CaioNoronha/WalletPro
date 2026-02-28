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

public struct HomeFeatureView: View {
    private let searchContext: HomeSearchContext
    private let showsOnlyActivities: Bool
    private let activitiesTopInset: CGFloat

    public init(
        searchText: String = "",
        isSearchPresented: Bool = false,
        showsOnlyActivities: Bool = false,
        activitiesTopInset: CGFloat = 0
    ) {
        self.searchContext = HomeSearchContext(
            text: searchText,
            isPresented: isSearchPresented
        )
        self.showsOnlyActivities = showsOnlyActivities
        self.activitiesTopInset = activitiesTopInset
    }

    public var body: some View {
        HomeScreen(
            searchContext: searchContext,
            showsOnlyActivities: showsOnlyActivities,
            activitiesTopInset: activitiesTopInset
        )
    }
}

#Preview {
    HomeFeatureView()
}
