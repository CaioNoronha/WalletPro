import SwiftUI
import Home

public struct SearchFeatureView: View {
    @Binding private var searchText: String
    @State private var isSearchPresented = true

    public init(searchText: Binding<String>) {
        self._searchText = searchText
    }

    public var body: some View {
        NavigationStack {
            HomeFeatureView(
                searchText: searchText,
                isSearchPresented: isSearchPresented
            )
        }
        .searchable(
            text: $searchText,
            isPresented: $isSearchPresented,
            placement: .automatic,
            prompt: "Search activities"
        )
        .onAppear {
            DispatchQueue.main.async {
                isSearchPresented = true
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
