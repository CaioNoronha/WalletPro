import Testing
@testable import DesignSystem

@Test func homeMotionTokensAreValid() {
    #expect(DSMotion.HomeTransitions.sectionFadeDuration > 0)
    #expect(DSMotion.HomeTransitions.homeEntrySlideDuration > 0)
    #expect(DSMotion.HomeTransitions.homeEntryRevealDelay >= 0)
    #expect(DSMotion.HomeTransitions.homeEntryRevealDuration > 0)
    #expect(DSMotion.HomeTransitions.sharedEntryInset > 0)
}
