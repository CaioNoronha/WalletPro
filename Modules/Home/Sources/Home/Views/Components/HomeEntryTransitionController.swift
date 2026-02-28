import SwiftUI
import Observation
import DesignSystem

@MainActor
@Observable
final class HomeEntryTransitionController {
    var isAnimatingHomeEntry = false
    var homeEntryInset: CGFloat = 0
    var searchEntryInset: CGFloat = DSMotion.HomeTransitions.Entry.sharedInset

    func runSearchEntryTransitionIfNeeded(isSearchOnly: Bool) {
        guard isSearchOnly else { return }

        searchEntryInset = DSMotion.HomeTransitions.Entry.sharedInset
        withAnimation(.easeInOut(duration: DSMotion.HomeTransitions.Duration.entrySlide)) {
            searchEntryInset = 0
        }
    }

    func runHomeEntryTransitionIfNeeded(
        isSearchOnly: Bool,
        entryTransition: DSMotion.HomeTransitions.Entry.Transition
    ) {
        guard isSearchOnly == false else { return }
        guard case .fromSearch = entryTransition else { return }

        isAnimatingHomeEntry = true
        homeEntryInset = DSMotion.HomeTransitions.Entry.sharedInset

        withAnimation(.easeInOut(duration: DSMotion.HomeTransitions.Duration.entrySlide)) {
            homeEntryInset = 0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + DSMotion.HomeTransitions.Delay.entryReveal) {
            withAnimation(.easeInOut(duration: DSMotion.HomeTransitions.Duration.entryReveal)) {
                self.isAnimatingHomeEntry = false
            }
        }
    }
}
