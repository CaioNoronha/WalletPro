import Testing
@testable import DesignSystem

@Test func homeMotionTokensAreValid() {
    #expect(DSMotion.HomeTransitions.Duration.sectionFade > 0)
    #expect(DSMotion.HomeTransitions.Duration.entrySlide > 0)
    #expect(DSMotion.HomeTransitions.Delay.entryReveal >= 0)
    #expect(DSMotion.HomeTransitions.Duration.entryReveal > 0)
    #expect(DSMotion.HomeTransitions.Entry.sharedInset > 0)
}
