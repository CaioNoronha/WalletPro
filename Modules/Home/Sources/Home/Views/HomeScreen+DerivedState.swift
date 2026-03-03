import SwiftUI
import Utils

// MARK: - Derived State
extension HomeScreen {
    var visibleActivities: [ActivityItem] {
        if isSearchOnly, let searchActivitiesOverride {
            return filter(searchActivitiesOverride, using: searchContext.text)
        }
        return viewModel.filteredActivities(using: searchContext.text)
    }

    var isSearchOnly: Bool {
        presentationMode == .searchOnly
    }

    var effectiveActivitiesTopInset: CGFloat {
        isSearchOnly ? transitionController.searchEntryInset : transitionController.homeEntryInset
    }

    var shouldShowMainSections: Bool {
        isSearchOnly == false
            && searchContext.isSearching == false
            && transitionController.isAnimatingHomeEntry == false
    }

    var shouldLoadHomeData: Bool {
        !(isSearchOnly && searchActivitiesOverride != nil)
    }

    var effectiveState: ScreenState {
        shouldLoadHomeData ? viewModel.state : .content
    }

    var hasSearchActivitiesForEntryAnimation: Bool {
        (searchActivitiesOverride?.isEmpty == false)
    }
}
