import Foundation
import Home
import DesignSystem

struct NavigationCoordinator {
    var selectedTab: AppTab = .home
    var previousTab: AppTab = .home
    var searchText: String = ""
    var homeEntryTransition: DSMotion.HomeTransitions.Entry.Transition = .none

    private var transitionID: Int = 0

    mutating func selectTab(_ tab: AppTab) {
        guard tab != selectedTab else { return }

        if selectedTab == .search && tab == .home {
            transitionID += 1
            homeEntryTransition = .fromSearch(id: transitionID)
        } else {
            homeEntryTransition = .none
        }

        previousTab = selectedTab
        selectedTab = tab
    }
}
