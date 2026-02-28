import Foundation

public enum DSMotion {
    public enum HomeTransitions {
        public enum Duration {
            public static let sectionFade: TimeInterval = 0.36
            public static let entrySlide: TimeInterval = 0.26
            public static let entryReveal: TimeInterval = 0.18
        }

        public enum Delay {
            public static let entryReveal: TimeInterval = 0.10
        }

        public enum Entry {
            public static let sharedInset: CGFloat = 210

            public enum Transition: Sendable, Equatable {
                case none
                case fromSearch(id: Int)
            }
        }
    }
}
