import SwiftUI

struct NavigationPlaceholderView: View {
    let title: String
    let systemImage: String

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
            .ignoresSafeArea()

            ContentUnavailableView(
                title,
                systemImage: systemImage,
                description: Text("Coming soon")
            )
            .foregroundStyle(.white.opacity(0.85))
        }
    }
}
