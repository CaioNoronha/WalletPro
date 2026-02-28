import SwiftUI
import Home

public struct SearchFeatureView: View {
    @Binding private var searchText: String
    @State private var isSearchPresented = true
    @State private var activitiesTopInset: CGFloat = 210

    public init(searchText: Binding<String>) {
        self._searchText = searchText
    }

    public var body: some View {
        NavigationStack {
            HomeFeatureView(
                searchText: searchText,
                isSearchPresented: isSearchPresented,
                showsOnlyActivities: true,
                activitiesTopInset: activitiesTopInset
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
                isSearchPresented = true
                withAnimation(.easeInOut(duration: 0.45)) {
                    activitiesTopInset = 0
                }
            }
        }
        .onDisappear {
            isSearchPresented = false
            searchText = ""
            activitiesTopInset = 210
        }
    }
}

#Preview {
    SearchFeatureView(searchText: .constant(""))
}
