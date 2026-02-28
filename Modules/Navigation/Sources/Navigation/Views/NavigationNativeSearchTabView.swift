import SwiftUI
import Home

struct NavigationNativeSearchTabView: View {
    @Binding var searchText: String
    @State private var isSearchPresented = true

    var body: some View {
        NavigationStack {
            HomeFeatureView(
                searchText: $searchText,
                isSearchPresented: $isSearchPresented
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
    NavigationNativeSearchTabView(searchText: .constant(""))
}
