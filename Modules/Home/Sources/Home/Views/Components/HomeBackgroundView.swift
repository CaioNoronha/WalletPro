import SwiftUI
import DesignSystem

struct HomeBackgroundView: View {
    var body: some View {
        ZStack {
            Color.ds.background

            RadialGradient(
                colors: [
                    Color.ds.primary1.opacity(0.78),
                    Color.ds.primary1.opacity(0.28),
                    .clear
                ],
                center: .topTrailing,
                startRadius: 20,
                endRadius: 360
            )
        }
    }
}
