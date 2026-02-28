import SwiftUI
import DesignSystem

struct HomeBackgroundView: View {
    var body: some View {
        ZStack {
            Color.ds.background

            RadialGradient(
                colors: [
                    Color.ds.primary1.opacity(0.36),
                    Color.ds.primary1.opacity(0.14),
                    .clear
                ],
                center: UnitPoint(x: 0.86, y: 0.02),
                startRadius: 8,
                endRadius: 360
            )

            LinearGradient(
                colors: [
                    Color.ds.primary1.opacity(0.09),
                    Color.ds.primary1.opacity(0.04),
                    .clear
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
    }
}
