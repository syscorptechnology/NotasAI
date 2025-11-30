import Foundation

@MainActor
final class DailyReportViewModel: ObservableObject {
    @Published var reports: [DailyReport]
    @Published var summary: String = ""
    @Published var workforce: String = ""
    @Published var issues: String = ""

    private let projectId: UUID
    private let author: UserSummary

    init(project: Project, author: UserSummary) {
        self.projectId = project.id
        self.author = author
        self.reports = project.dailyReports
    }

    func saveReport() {
        let report = DailyReport(
            id: UUID(),
            projectId: projectId,
            date: Date(),
            summary: summary,
            workforce: workforce,
            issues: issues,
            photos: [],
            createdBy: author
        )
        reports.insert(report, at: 0)
        summary = ""
        workforce = ""
        issues = ""
    }
}
