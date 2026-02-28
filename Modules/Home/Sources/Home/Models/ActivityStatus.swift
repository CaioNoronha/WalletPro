import Foundation

enum ActivityStatus {
    case success
    case failed

    var title: String {
        switch self {
        case .success:
            "Success"
        case .failed:
            "Failed"
        }
    }
}
