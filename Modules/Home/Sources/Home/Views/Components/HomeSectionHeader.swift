import SwiftUI

struct HomeSectionHeader: View {
    let title: String
    let trailingTitle: String

    var body: some View {
        HStack {
            Text(title)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.primary)
            Spacer()
            Text(trailingTitle)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.primary)
        }
    }
}
