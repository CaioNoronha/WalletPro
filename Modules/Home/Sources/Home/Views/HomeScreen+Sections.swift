import SwiftUI
import DesignSystem

// MARK: - Body Sections
extension HomeScreen {
    var errorStateView: some View {
        VStack(spacing: 10) {
            Text("Could not load Home")
                .font(.headline.weight(.semibold))
            Text("Please try again.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    var contentView: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                Group {
                    if shouldShowMainSections {
                        mainSections
                    }
                }
                .animation(.easeInOut(duration: DSMotion.HomeTransitions.Duration.sectionFade), value: shouldShowMainSections)

                if effectiveActivitiesTopInset > 0 {
                    Color.clear
                        .frame(height: effectiveActivitiesTopInset)
                        .animation(.easeInOut(duration: DSMotion.HomeTransitions.Duration.entrySlide), value: effectiveActivitiesTopInset)
                }

                activitySection

                Color.clear.frame(height: 110)
            }
            .padding(.horizontal, 20)
            .padding(.top, 18)
        }
    }

    @ViewBuilder
    var mainSections: some View {
        HomeHeaderSection(user: viewModel.user)
            .transition(.opacity)

        HomeBalanceSection(
            title: viewModel.balance.title,
            balance: viewModel.displayBalance,
            isBalanceHidden: viewModel.isBalanceHidden,
            onToggleVisibility: viewModel.toggleBalanceVisibility
        )
        .transition(.opacity)

        HomeQuickActionsSection(actions: viewModel.quickActions)
            .transition(.opacity)

        HomeCardInvoiceSection(
            invoice: viewModel.cardInvoice,
            amountText: viewModel.displayCardInvoiceAmount,
            availableLimitText: viewModel.displayCardAvailableLimit
        )
        .transition(.opacity)
    }

    var activitySection: some View {
        HomeActivitySection(
            activities: visibleActivities,
            title: isSearchOnly ? "Recent Activity" : (searchContext.isSearching ? "Search Activities" : "Recent Activity"),
            trailingTitle: isSearchOnly ? nil : "See all",
            onSeeAllTap: isSearchOnly ? nil : onSeeAllTap
        )
        .transition(.opacity)
    }
}
