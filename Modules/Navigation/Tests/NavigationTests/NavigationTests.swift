import Testing
import DesignSystem
@testable import Navigation

@Test func appTabMetadataIsStable() {
    #expect(AppTab.allCases.count == 4)
    #expect(AppTab.home.title == "Home")
    #expect(AppTab.search.systemImage == "magnifyingglass")
}

@Test func coordinatorTriggersHomeEntryOnlyFromSearch() {
    var coordinator = NavigationCoordinator()

    coordinator.selectTab(.rewards)
    #expect(coordinator.homeEntryTransition == .none)

    coordinator.selectTab(.search)
    coordinator.selectTab(.home)

    if case .fromSearch = coordinator.homeEntryTransition {
        #expect(true)
    } else {
        #expect(Bool(false))
    }
}
