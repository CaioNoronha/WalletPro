import Foundation
import Home
import DesignSystem

struct NavigationCoordinator {
    var selectedTab: AppTab = .home
    var previousTab: AppTab = .home
    var searchText: String = ""
    var homeEntryTransition: DSMotion.HomeTransitions.Entry.Transition = .none
    var searchAutoFocus: Bool = true
    var searchEntryShouldAnimate: Bool = true

    private var transitionID: Int = 0
    private var pendingSearchAutoFocus: Bool?
    private var pendingSearchEntryShouldAnimate: Bool?

    mutating func selectTab(_ tab: AppTab) {
        guard tab != selectedTab else { return }

        if selectedTab == .search && tab == .home {
            transitionID += 1
            homeEntryTransition = .fromSearch(id: transitionID)
        } else {
            homeEntryTransition = .none
        }

        if tab == .search {
            searchAutoFocus = pendingSearchAutoFocus ?? true
            searchEntryShouldAnimate = pendingSearchEntryShouldAnimate ?? (selectedTab == .home)
            pendingSearchAutoFocus = nil
            pendingSearchEntryShouldAnimate = nil
        }

        previousTab = selectedTab
        selectedTab = tab
    }

    mutating func openSearchListingAllTransactions() {
        searchText = ""
        pendingSearchAutoFocus = false
        pendingSearchEntryShouldAnimate = true
        selectTab(.search)
    }
}
