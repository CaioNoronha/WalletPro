import SwiftUI
import DesignSystem

struct HomeActivitySection: View {
    let activities: [ActivityItem]
    var title: String = "Recent Activity"
    var trailingTitle: String? = "See all"
    var onSeeAllTap: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HomeSectionHeader(
                title: title,
                trailingTitle: trailingTitle,
                onTrailingTap: onSeeAllTap
            )

            if activities.isEmpty {
                Text("No activities found")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)
                    .padding(.vertical, 24)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                VStack(spacing: 8) {
                    ForEach(activities) { item in
                        HomeActivityRow(item: item)

                        if item.id != activities.last?.id {
                            Divider().overlay(.white.opacity(0.12))
                        }
                    }
                }
            }
        }
    }
}

private struct HomeActivityRow: View {
    let item: ActivityItem

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            HomeActivityAvatar(avatarText: item.avatarText)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline.weight(.medium))
                    .foregroundStyle(.primary)

                Text(item.dateText)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 12)

            Text(item.amountText)
                .font(.title3.weight(.semibold))
                .foregroundStyle(.primary)
        }
        .padding(.vertical, 12)
    }
}

private struct HomeActivityAvatar: View {
    let avatarText: String

    var body: some View {
        Circle()
            .fill(
                LinearGradient(
                    colors: [
                        Color.ds.secondary1.opacity(0.78),
                        Color.ds.primary2.opacity(0.58)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: 40, height: 40)
            .overlay {
                Text(avatarText)
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(.black.opacity(0.75))
            }
    }
}
