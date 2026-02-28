import SwiftUI

struct HomePromoSection: View {
    let promo: PromoHighlight

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HomeSectionHeader(title: "Promo & Rewards", trailingTitle: "See all")

            ZStack(alignment: .bottomTrailing) {
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.16, green: 0.17, blue: 0.20),
                                Color(red: 0.07, green: 0.08, blue: 0.11)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 26, style: .continuous)
                            .strokeBorder(.white.opacity(0.14), lineWidth: 1)
                    }

                VStack(alignment: .leading, spacing: 4) {
                    Text(promo.title)
                        .font(.title3)
                        .foregroundStyle(.primary)

                    Text(promo.discountText)
                        .font(.system(size: 58, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary)

                    Text(promo.subtitle)
                        .font(.headline.weight(.medium))
                        .foregroundStyle(.primary)

                    Text(promo.dateRange)
                        .font(.callout)
                        .foregroundStyle(.primary)
                        .padding(.top, 2)

                    Text(promo.legalText)
                        .font(.footnote)
                        .foregroundStyle(.primary)
                        .padding(.top, 4)
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)

                Text(promo.ctaTitle)
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 13)
                    .padding(.vertical, 8)
                    .background(
                        LinearGradient(
                            colors: [
                                Color(red: 0.53, green: 0.22, blue: 0.98),
                                Color(red: 0.37, green: 0.09, blue: 0.89)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        in: Capsule()
                    )
                    .padding(16)
            }
            .frame(height: 250)

            HStack(spacing: 7) {
                Circle().fill(Color(red: 0.44, green: 0.19, blue: 0.96)).frame(width: 9, height: 9)
                Circle().fill(.white.opacity(0.45)).frame(width: 7, height: 7)
                Circle().fill(.white.opacity(0.45)).frame(width: 7, height: 7)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
