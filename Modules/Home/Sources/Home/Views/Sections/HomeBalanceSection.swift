import SwiftUI

struct HomeBalanceSection: View {
    let title: String
    let balance: String
    let isBalanceHidden: Bool
    let onToggleVisibility: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.white)

                Button(action: onToggleVisibility) {
                    Image(systemName: isBalanceHidden ? "eye.slash" : "eye")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.9))
                }
                .buttonStyle(.plain)
            }

            Text(balance)
                .font(.title.bold())
                .lineLimit(1)
                .foregroundStyle(.white)
        }
    }
}
