import SwiftUI
import DesignSystem

struct HomeBalanceSection: View {
    let title: String
    let balance: String
    let isBalanceHidden: Bool
    let onToggleVisibility: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.ds.primary,
                            Color.ds.primary1
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            BalanceWavePattern()
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))

            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(title)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.95))

                    Spacer()

                    Text("08/26")
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.9))
                }

                HStack(spacing: 10) {
                    Text(balance)
                        .font(.system(size: 56, weight: .bold, design: .rounded))
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                        .foregroundStyle(.white)

                    Button {
                        withAnimation(.spring(response: 0.28, dampingFraction: 0.72)) {
                            onToggleVisibility()
                        }
                    } label: {
                        Image(systemName: isBalanceHidden ? "eye.slash" : "eye")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.white.opacity(0.9))
                            .frame(width: 24, height: 24)
                            .contentTransition(.symbolEffect(.replace))
                            .symbolEffect(.bounce, value: isBalanceHidden)
                            .offset(x: isBalanceHidden ? -2 : 2)
                            .animation(.spring(response: 0.3, dampingFraction: 0.75), value: isBalanceHidden)
                    }
                    .buttonStyle(.plain)
                }

                Spacer(minLength: 0)

                HStack {
                    Text("Premium Card")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.95))

                    Spacer()

                    ZStack {
                        Circle()
                            .fill(Color(red: 0.95, green: 0.23, blue: 0.16))
                            .frame(width: 34, height: 34)
                            .offset(x: -10)

                        Circle()
                            .fill(Color(red: 0.96, green: 0.71, blue: 0.18))
                            .frame(width: 34, height: 34)
                            .offset(x: 10)
                    }
                    .frame(width: 52, height: 34)
                }
            }
            .padding(24)
        }
        .frame(height: 220)
    }
}
private struct BalanceWavePattern: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height

            VStack(spacing: 12) {
                ForEach(0..<10, id: \.self) { index in
                    Path { path in
                        let y = CGFloat(index) * (height / 10)
                        path.move(to: CGPoint(x: -20, y: y))
                        path.addCurve(
                            to: CGPoint(x: width + 20, y: y + 8),
                            control1: CGPoint(x: width * 0.25, y: y - 14),
                            control2: CGPoint(x: width * 0.75, y: y + 22)
                        )
                    }
                    .stroke(.white.opacity(0.08), lineWidth: 2)
                }
            }
        }
    }
}

