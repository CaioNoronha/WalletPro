import SwiftUI

struct HomeHeaderSection: View {
    let user: String

    var body: some View {
        HStack(alignment: .center) {
            Text("Hello, \(user)!")
                .font(.title2.weight(.semibold))

            Spacer()

            bellButton
        }
    }

    private var bellButton: some View {
        Button {
        } label: {
            Image(systemName: "bell")
                .foregroundStyle(.primary)
                .frame(width: 44, height: 44)
                .overlay(alignment: .topTrailing) {
                    Circle()
                        .fill(.red)
                        .frame(width: 9, height: 9)
                        .offset(x: -2, y: 2)
                }
        }
        .buttonStyle(.plain)
        .modifier(HomeBellGlassStyle())
    }
}

private struct HomeBellGlassStyle: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .glassEffect(.regular.interactive(), in: .circle)
        } else {
            content
                .background(.ultraThinMaterial, in: Circle())
        }
    }
}
