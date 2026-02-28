import SwiftUI
import DesignSystem

struct HomeQuickActionsSection: View {
    let actions: [QuickAction]

    var body: some View {
        quickActionsContent
            .modifier(HomeQuickActionsGlassStyle())
    }

    private var quickActionsContent: some View {
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
                .foregroundStyle(Color.ds.primary1)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
            }
        }
        .padding(.horizontal, 10)
    }
}
private struct HomeQuickActionsGlassStyle: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .glassEffect(.regular, in: Capsule())
        } else {
            content
                .background(.ultraThinMaterial, in: Capsule())
        }
    }
}

