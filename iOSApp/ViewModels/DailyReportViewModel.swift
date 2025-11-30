import Foundation

@MainActor
final class DailyReportViewModel: ObservableObject {
    @Published var reports: [DailyReport]
    @Published var summary: String = ""
    @Published var workforce: String = ""
    @Published var issues: String = ""
    @Published var attachedPhotos: [PhotoAttachment] = []
    @Published var lastNotification: String? = nil

    private let projectId: UUID
    private let author: UserSummary
    private let director: UserSummary

    init(project: Project, author: UserSummary) {
        self.projectId = project.id
        self.author = author
        self.director = project.responsible
        self.reports = project.dailyReports.sorted { $0.date > $1.date }
    }

    func saveReport() {
        let report = DailyReport(
            id: UUID(),
            projectId: projectId,
            date: Date(),
            summary: summary,
            workforce: workforce,
            issues: issues,
            photos: attachedPhotos,
            createdBy: author
        )
        reports.append(report)
        reports.sort { $0.date > $1.date }
        attachedPhotos.removeAll()
        summary = ""
        workforce = ""
        issues = ""
        lastNotification = "Notificación enviada a \(director.name)"
    }

    func addPhotoAttachment() {
        let sampleURL = URL(string: "https://picsum.photos/200")!
        let attachment = PhotoAttachment(id: UUID(), url: sampleURL, uploadedBy: author, date: Date())
        attachedPhotos.append(attachment)
    }
}
