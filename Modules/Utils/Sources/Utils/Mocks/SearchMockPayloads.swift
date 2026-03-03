public extension MockPayloads {
    static let searchActivities = """
    [
      { "id": "a1", "title": "Transfer to Andi", "dateText": "21 fev. 2026", "status": "success", "amountText": "$34", "avatarText": "A" },
      { "id": "a2", "title": "Top Up to Klarna", "dateText": "20 fev. 2026", "status": "success", "amountText": "$90", "avatarText": "K." },
      { "id": "a3", "title": "Transfer to Andry", "dateText": "19 fev. 2026", "status": "failed", "amountText": "$27", "avatarText": "C" },
      { "id": "a4", "title": "Top Up to Aero", "dateText": "18 fev. 2026", "status": "success", "amountText": "$16", "avatarText": "G" },
      { "id": "a5", "title": "Top Up to Cleber", "dateText": "17 fev. 2026", "status": "success", "amountText": "$47", "avatarText": "A" }
    ]
    """
}
