import SwiftUI
import Testing
@testable import Search

@MainActor
@Test func createsSearchFeatureView() {
    let view = SearchFeatureView(searchText: .constant(""))
    #expect(String(describing: type(of: view)) == "SearchFeatureView")
}
