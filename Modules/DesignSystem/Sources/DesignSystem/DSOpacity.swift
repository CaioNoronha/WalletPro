import SwiftUI

public enum DSOpacity {
    public enum HomeBackground {
        public static func radialStrong(for colorScheme: ColorScheme) -> Double {
            colorScheme == .dark ? 0.36 : 0.72
        }

        public static func radialSoft(for colorScheme: ColorScheme) -> Double {
            colorScheme == .dark ? 0.14 : 0.36
        }

        public static func linearStrong(for colorScheme: ColorScheme) -> Double {
            colorScheme == .dark ? 0.09 : 0.28
        }

        public static func linearSoft(for colorScheme: ColorScheme) -> Double {
            colorScheme == .dark ? 0.04 : 0.08
        }
    }
}
