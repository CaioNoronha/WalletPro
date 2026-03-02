public enum Masking {
    public static let hiddenAmount = "••••••••"

    public static func bullets(count: Int) -> String {
        String(repeating: "•", count: max(0, count))
    }
}
