import SwiftUI

struct HomeBalanceSection: View {
    let title: String
    let balance: String
    let isBalanceHidden: Bool
    let onToggleVisibility: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.white)

            HStack(spacing: 8) {
                Text(balance)
                    .font(.title.bold())
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .foregroundStyle(.white)

                Spacer(minLength: 0)

                Button(action: onToggleVisibility) {
                    Image(systemName: isBalanceHidden ? "eye.slash" : "eye")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.9))
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(.plain)
            }
        }
    }
}
