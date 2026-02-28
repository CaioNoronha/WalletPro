import SwiftUI
import DesignSystem

struct HomeBackgroundView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            Color.ds.background

            RadialGradient(
                colors: [
                    Color.ds.primary1.opacity(DSOpacity.HomeBackground.radialStrong(for: colorScheme)),
                    Color.ds.primary1.opacity(DSOpacity.HomeBackground.radialSoft(for: colorScheme)),
                    .clear
                ],
                center: UnitPoint(x: 0.86, y: 0.02),
                startRadius: 8,
                endRadius: 360
            )

            LinearGradient(
                colors: [
                    Color.ds.primary1.opacity(DSOpacity.HomeBackground.linearStrong(for: colorScheme)),
                    Color.ds.primary1.opacity(DSOpacity.HomeBackground.linearSoft(for: colorScheme)),
                    .clear
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
    }
}
