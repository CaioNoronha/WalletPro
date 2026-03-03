import SwiftUI
import Home

public struct SearchFeatureView: View {
    @Binding private var searchText: String
    @State private var isSearchPresented = true

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
