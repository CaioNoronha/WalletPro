import SwiftUI
import DesignSystem

struct HomeCardInvoiceSection: View {
    let invoice: CardInvoiceSummary
    let amountText: String
    let availableLimitText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text(invoice.title)
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.primary)

                Spacer()

                if invoice.isOpen {
                    HStack(spacing: 7) {
                        Circle()
                            .fill(Color.ds.primary2)
                            .frame(width: 7, height: 7)

                        Text("Open")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.primary)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(.ultraThinMaterial, in: Capsule())
                }
            }

            HStack(spacing: 8) {
                Text(amountText)
                    .font(.title2).bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }

            Text("Available credit \(availableLimitText)")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
        }
        .padding(18)
        .frame(maxWidth: .infinity, minHeight: 158, alignment: .topLeading)
        .background {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.ds.primary2.opacity(0.18),
                                    .clear
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .strokeBorder(.white.opacity(0.10), lineWidth: 1)
                }
        }
    }
}
