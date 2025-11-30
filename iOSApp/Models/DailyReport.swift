import Foundation

struct DailyReport: Identifiable, Hashable {
    let id: UUID
    var projectId: UUID
    var date: Date
    var summary: String
    var workforce: String
    var issues: String
    var photos: [PhotoAttachment]
    var createdBy: UserSummary
}
