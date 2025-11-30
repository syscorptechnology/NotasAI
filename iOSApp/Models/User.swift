import Foundation

struct User: Identifiable, Hashable {
    let id: UUID
    var name: String
    var email: String
    var role: String
    var notificationsEnabled: Bool
}
