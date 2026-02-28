import SwiftUI

struct HomeScreen: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    headerSection
                    balanceSection
                    quickActionsSection
                    promoSection
                    activitySection
                    Color.clear.frame(height: 110)
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
            }
        }
    }

    private var backgroundGradient: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.03, green: 0.05, blue: 0.11),
                    Color.black
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            RadialGradient(
                colors: [
                    Color(red: 0.37, green: 0.13, blue: 0.78).opacity(0.75),
                    .clear
                ],
                center: .topTrailing,
                startRadius: 10,
                endRadius: 320
            )
        }
    }

    private var headerSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 6) {
                    Text("Hi, \(viewModel.user.firstName)")
                        .font(.title3.weight(.semibold))
                    Image(systemName: "chevron.down")
                        .font(.caption.weight(.semibold))
                }
                .foregroundStyle(.white)

                Text(viewModel.user.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
            }

            Spacer()

            HStack(spacing: 10) {
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: 44, height: 44)
                    .overlay {
                        Image(systemName: "bell")
                            .foregroundStyle(.white.opacity(0.92))
                    }
                    .overlay(alignment: .topTrailing) {
                        Circle()
                            .fill(.red)
                            .frame(width: 9, height: 9)
                            .offset(x: -5, y: 5)
                    }

                HStack(spacing: 8) {
                    Image(systemName: "creditcard")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white)
                    Text("My Card")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.92))
                }
                .padding(.horizontal, 13)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial, in: Capsule())
            }
        }
    }

    private var balanceSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(viewModel.balance.title)
                .font(.title2.weight(.medium))
                .foregroundStyle(.white.opacity(0.95))

            Text(viewModel.formattedBalance)
                .font(.system(size: 56, weight: .bold, design: .rounded))
                .kerning(-1.2)
                .minimumScaleFactor(0.75)
                .lineLimit(1)
                .foregroundStyle(.white)
        }
    }

    private var quickActionsSection: some View {
        HStack(spacing: 10) {
            ForEach(viewModel.quickActions) { action in
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

    private var promoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Promo & Rewards")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.white)
                Spacer()
                Text("See all")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.white.opacity(0.65))
            }

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
                    Text(viewModel.promo.title)
                        .font(.title3)
                        .foregroundStyle(.white.opacity(0.86))

                    Text(viewModel.promo.discountText)
                        .font(.system(size: 58, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)

                    Text(viewModel.promo.subtitle)
                        .font(.headline.weight(.medium))
                        .foregroundStyle(.white.opacity(0.84))

                    Text(viewModel.promo.dateRange)
                        .font(.callout)
                        .foregroundStyle(.white.opacity(0.8))
                        .padding(.top, 2)

                    Text(viewModel.promo.legalText)
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.62))
                        .padding(.top, 4)
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)

                Text(viewModel.promo.ctaTitle)
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.white)
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

    private var activitySection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Recent Activity")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.white)
                Spacer()
                Text("See all")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.white.opacity(0.65))
            }

            VStack(spacing: 2) {
                ForEach(viewModel.activities) { item in
                    HStack(spacing: 12) {
                        avatar(for: item)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(item.title)
                                .font(.headline.weight(.medium))
                                .foregroundStyle(.white.opacity(0.92))

                            Text(item.status.title)
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(item.status == .success ? .green : .red)
                        }

                        Spacer()

                        Text(item.amountText)
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(.white)
                    }
                    .padding(.vertical, 8)

                    if item.id != viewModel.activities.last?.id {
                        Divider().overlay(.white.opacity(0.12))
                    }
                }
            }
        }
    }

    private func avatar(for item: ActivityItem) -> some View {
        Circle()
            .fill(
                LinearGradient(
                    colors: [
                        Color(red: 0.99, green: 0.78, blue: 0.55),
                        Color(red: 0.87, green: 0.48, blue: 0.54)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: 40, height: 40)
            .overlay {
                Text(item.avatarText)
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(.black.opacity(0.75))
            }
    }

}

#Preview {
    HomeScreen()
}
