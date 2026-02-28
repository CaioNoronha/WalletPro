import SwiftUI
import DesignSystem

struct HomeSectionHeader: View {
    let title: String
    let trailingTitle: String?
    var onTrailingTap: (() -> Void)?

    var body: some View {
        HStack {
            Text(title)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.primary)

            Spacer()

            if let trailingTitle {
                if let onTrailingTap {
                    Button(action: onTrailingTap) {
                        Text(trailingTitle)
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(Color.ds.primary1)
                    }
                    .buttonStyle(.plain)
                } else {
                    Text(trailingTitle)
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(Color.ds.primary1)
                }
            }
        }
    }
}
