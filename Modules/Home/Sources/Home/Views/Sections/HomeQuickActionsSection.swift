import SwiftUI

struct HomeQuickActionsSection: View {
    let actions: [QuickAction]

    var body: some View {
        HStack(spacing: 10) {
            ForEach(actions) { action in
                VStack(spacing: 10) {
                    Image(systemName: action.systemImage)
                        .font(.title3.weight(.semibold))
                        .frame(width: 28, height: 28)
                    Text(action.title)
                        .font(.footnote.weight(.medium))
                        .lineLimit(1)
                }
                .foregroundStyle(.white.opacity(0.96))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
            }
        }
        .padding(.horizontal, 10)
        .background(.ultraThinMaterial, in: Capsule())
    }
}
