import SwiftUI

struct NavigationNativeSearchTabView: View {
    @Binding var searchText: String
    @State private var isSearchPresented = true

    private let items: [String] = [
        "Transfer",
        "Top Up",
        "Rewards",
        "Activity",
        "Profile",
        "My Card"
    ]

    private var filteredItems: [String] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if query.isEmpty { return items }
        return items.filter { $0.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        NavigationStack {
            List(filteredItems, id: \.self) { item in
                Text(item)
            }
            .listStyle(.plain)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(
            text: $searchText,
            isPresented: $isSearchPresented,
            placement: .automatic,
            prompt: "Search"
        )
        .onAppear {
            DispatchQueue.main.async {
                isSearchPresented = true
            }
        }
    }
}

#Preview {
    NavigationNativeSearchTabView(searchText: .constant(""))
}
