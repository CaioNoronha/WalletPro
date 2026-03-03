import SwiftUI
import Home

public struct SearchFeatureView: View {
    @Binding private var searchText: String
    @State private var isSearchPresented = true
    @State private var viewModel: SearchViewModel

    private let autoFocusSearchField: Bool
    private let searchEntryShouldAnimate: Bool

    public init(
        searchText: Binding<String>,
        autoFocusSearchField: Bool = true,
        searchEntryShouldAnimate: Bool = true
    ) {
        self.init(
            searchText: searchText,
            viewModel: SearchViewModel(worker: SearchWorker.mocked()),
            autoFocusSearchField: autoFocusSearchField,
            searchEntryShouldAnimate: searchEntryShouldAnimate
        )
    }

    init(
        searchText: Binding<String>,
        viewModel: SearchViewModel,
        autoFocusSearchField: Bool,
        searchEntryShouldAnimate: Bool
    ) {
        self._searchText = searchText
        self._viewModel = State(initialValue: viewModel)
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
            ForEach(viewModel.suggestedQueries) { suggestion in
                Text(suggestion.text)
                    .searchCompletion(suggestion.text)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .task {
            await viewModel.loadSuggestionsIfNeeded()
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
}

#Preview {
    SearchFeatureView(searchText: .constant(""))
}
