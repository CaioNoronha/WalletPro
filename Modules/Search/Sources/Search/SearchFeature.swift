import SwiftUI
import Home

public struct SearchFeatureView: View {
    @Binding private var searchText: String
    @State private var isSearchPresented = true
    @State private var viewModel = SearchViewModel()

    private let autoFocusSearchField: Bool
    private let searchEntryShouldAnimate: Bool

    public init(
        searchText: Binding<String>,
        autoFocusSearchField: Bool = true,
        searchEntryShouldAnimate: Bool = true
    ) {
        self._searchText = searchText
        self.autoFocusSearchField = autoFocusSearchField
        self.searchEntryShouldAnimate = searchEntryShouldAnimate
    }

    public var body: some View {
        NavigationStack {
            HomeFeatureView(
                searchText: searchText,
                isSearchPresented: isSearchPresented,
                searchActivitiesOverride: mappedActivities,
                presentationMode: .searchOnly,
                searchEntryShouldAnimate: searchEntryShouldAnimate
            )
        }
        .searchable(
            text: $searchText,
            isPresented: $isSearchPresented,
            placement: .automatic,
            prompt: "Search activities"
        )
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .task(priority: .utility) {
            await viewModel.loadActivitiesIfNeeded()
        }
        .onAppear {
            guard autoFocusSearchField else {
                isSearchPresented = false
                return
            }
            isSearchPresented = true
        }
        .onDisappear {
            isSearchPresented = false
            searchText = ""
        }
    }
}

// MARK: - Mapping
private extension SearchFeatureView {
    var mappedActivities: [ActivityItem] {
        viewModel.activities.map { item in
            ActivityItem(
                id: item.id,
                title: item.title,
                dateText: item.dateText,
                status: item.status,
                amountText: item.amountText,
                avatarText: item.avatarText
            )
        }
    }
}

#Preview {
    SearchFeatureView(searchText: .constant(""))
}
