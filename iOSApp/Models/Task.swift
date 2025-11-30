import Foundation

struct Task: Identifiable, Hashable {
    enum Status: String, CaseIterable, Codable { case pending, inProgress, completed }
    enum Priority: String, CaseIterable, Codable { case low, medium, high }

    let id: UUID
    var projectId: UUID
    var title: String
    var description: String
    var responsible: UserSummary
    var startDate: Date
    var dueDate: Date
    var status: Status
    var priority: Priority
    var progress: Double
    var comments: [Comment]
    var photos: [PhotoAttachment]
}

struct Comment: Identifiable, Hashable {
    let id: UUID
    var author: UserSummary
    var message: String
    var date: Date
}

struct PhotoAttachment: Identifiable, Hashable {
    let id: UUID
    var url: URL
    var uploadedBy: UserSummary
    var date: Date
}
