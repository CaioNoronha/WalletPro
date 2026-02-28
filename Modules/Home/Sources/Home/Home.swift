import SwiftUI

public struct HomeFeatureView: View {
    private let searchText: Binding<String>
    private let isSearchPresented: Binding<Bool>

    public init(
        searchText: Binding<String> = .constant(""),
        isSearchPresented: Binding<Bool> = .constant(false)
    ) {
        self.searchText = searchText
        self.isSearchPresented = isSearchPresented
    }

    public var body: some View {
        HomeScreen(
            searchText: searchText.wrappedValue,
            isSearchPresented: isSearchPresented.wrappedValue
        )
    }
}

#Preview {
    HomeFeatureView()
}
