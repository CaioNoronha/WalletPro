import Testing
@testable import Navigation

@Test func appTabMetadataIsStable() {
    #expect(AppTab.allCases.count == 5)
    #expect(AppTab.home.title == "Home")
    #expect(AppTab.search.systemImage == "magnifyingglass")
}
