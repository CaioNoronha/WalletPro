import Foundation

public enum CurrencyFormatting {
    public static func amount(
        _ amount: Decimal,
        currencySymbol: String,
        minimumFractionDigits: Int = 2,
        maximumFractionDigits: Int = 2
    ) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = maximumFractionDigits

        let value = NSDecimalNumber(decimal: amount)
        let amountText = formatter.string(from: value) ?? "0.00"
        return "\(currencySymbol)\(amountText)"
    }
}
