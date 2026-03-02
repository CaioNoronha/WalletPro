import SwiftUI
import Home

public struct SearchFeatureView: View {
    @Binding private var searchText: String
    @State private var isSearchPresented = true
    @State private var suggestedQueries: [String] = []

    private let autoFocusSearchField: Bool
    private let searchEntryShouldAnimate: Bool
    private let worker = SearchWorker.liveMock()

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
        .searchSuggestions {
            ForEach(suggestedQueries, id: \.self) { query in
                Text(query)
                    .searchCompletion(query)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .task {
            await loadSuggestionsIfNeeded()
        }
        .onAppear {
            DispatchQueue.main.async {
                isSearchPresented = autoFocusSearchField
            }
        }
        .onDisappear {
            isSearchPresented = false
            searchText = ""
        }
    }

    private func loadSuggestionsIfNeeded() async {
        guard suggestedQueries.isEmpty else { return }

        if let queries = try? await worker.fetchSuggestedQueries() {
            suggestedQueries = queries
        }
    }
}

#Preview {
    SearchFeatureView(searchText: .constant(""))
}
