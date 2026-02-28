import SwiftUI

struct HomeBackgroundView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.03, green: 0.05, blue: 0.11),
                    .black
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            RadialGradient(
                colors: [
                    Color(red: 0.37, green: 0.13, blue: 0.78).opacity(0.75),
                    .clear
                ],
                center: .topTrailing,
                startRadius: 10,
                endRadius: 320
            )
        }
    }
}
