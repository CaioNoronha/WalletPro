struct SearchSuggestion: Identifiable, Hashable, Sendable, Decodable {
    let text: String

    var id: String { text }
}
