import SwiftUI

struct HomeHeaderSection: View {
    let user: String

    var body: some View {
        HStack(alignment: .center) {
            Text("Hello, \(user)!")
                .font(.title2.weight(.semibold))
            
            Spacer()
            
            Button {
            } label: {
                Image(systemName: "bell")
                    .foregroundStyle(.white.opacity(0.92))
                    .frame(width: 44, height: 44)
                    .overlay(alignment: .topTrailing) {
                        Circle()
                            .fill(.red)
                            .frame(width: 9, height: 9)
                            .offset(x: -2, y: 2)
                    }
            }
            .buttonStyle(.plain)
            .glassEffect(.regular.interactive(), in: .circle)
        }
    }
}
