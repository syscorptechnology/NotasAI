import Foundation

struct Project: Identifiable, Hashable {
    let id: UUID
    var name: String
    var client: String
    var location: String
    var startDate: Date
    var endDate: Date?
    var progress: Double
    var responsible: UserSummary
    var tasks: [Task]
    var dailyReports: [DailyReport]
    var documents: [Document]
}

struct UserSummary: Identifiable, Hashable {
    let id: UUID
    var name: String
    var role: String
}
