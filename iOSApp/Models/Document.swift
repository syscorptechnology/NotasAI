import Foundation

struct Document: Identifiable, Hashable {
    enum DocumentType: String, CaseIterable, Codable { case plan, contract, report, photo, checklist, specification }

    let id: UUID
    var projectId: UUID
    var taskId: UUID?
    var name: String
    var type: DocumentType
    var url: URL
    var uploadDate: Date
    var uploadedBy: UserSummary
}
