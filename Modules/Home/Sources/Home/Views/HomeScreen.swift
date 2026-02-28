import SwiftUI

struct HomeScreen: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        ZStack {
            HomeBackgroundView()
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    HomeHeaderSection(user: viewModel.user)
                    HomeBalanceSection(
                        title: viewModel.balance.title,
                        balance: viewModel.displayBalance,
                        isBalanceHidden: viewModel.isBalanceHidden,
                        onToggleVisibility: viewModel.toggleBalanceVisibility
                    )
                    HomeQuickActionsSection(actions: viewModel.quickActions)
                    HomePromoSection(promo: viewModel.promo)
                    HomeActivitySection(activities: viewModel.activities)
                    Color.clear.frame(height: 110)
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
            }
        }
    }
}

#Preview {
    HomeScreen()
}
