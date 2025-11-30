import Foundation

final class MockDataService {
    static let shared = MockDataService()

    let users: [User]
    private(set) var projects: [Project]

    private init() {
        let director = User(id: UUID(), name: "Ana Directora", email: "ana@constructora.com", role: "Directora", password: "director123", notificationsEnabled: true)
        let supervisor = User(id: UUID(), name: "Carlos Supervisor", email: "carlos@constructora.com", role: "Supervisor", password: "supervisor123", notificationsEnabled: true)
        let contractor = User(id: UUID(), name: "Lucía Contratista", email: "lucia@proveedor.com", role: "Contratista", password: "proveedor123", notificationsEnabled: false)
        users = [director, supervisor, contractor]

        let directorSummary = UserSummary(id: director.id, name: director.name, role: director.role)
        let supervisorSummary = UserSummary(id: supervisor.id, name: supervisor.name, role: supervisor.role)
        let contractorSummary = UserSummary(id: contractor.id, name: contractor.name, role: contractor.role)
        let projectUUID = UUID()

        let task1 = Task(
            id: UUID(),
            projectId: projectUUID,
            title: "Replanteo de cimentación",
            description: "Marcar ejes y verificar niveles iniciales.",
            responsible: supervisorSummary,
            startDate: Date().addingTimeInterval(-86400 * 3),
            dueDate: Date().addingTimeInterval(86400 * 4),
            status: .inProgress,
            priority: .high,
            progress: 0.4,
            comments: [
                Comment(id: UUID(), author: contractorSummary, message: "Terreno limpio y listo para replanteo", date: Date().addingTimeInterval(-3600 * 18)),
                Comment(id: UUID(), author: supervisorSummary, message: "Se marca eje norte mañana", date: Date().addingTimeInterval(-3600 * 3))
            ],
            photos: []
        )

        let task2 = Task(
            id: UUID(),
            projectId: projectUUID,
            title: "Losas segundo nivel",
            description: "Colado de losas y revisión de acabados.",
            responsible: contractorSummary,
            startDate: Date().addingTimeInterval(-86400 * 10),
            dueDate: Date().addingTimeInterval(86400 * 2),
            status: .pending,
            priority: .medium,
            progress: 0.15,
            comments: [],
            photos: []
        )

        let reportPhoto = PhotoAttachment(id: UUID(), url: URL(string: "https://picsum.photos/300")!, uploadedBy: supervisorSummary, date: Date().addingTimeInterval(-3600 * 5))
        let report = DailyReport(
            id: UUID(),
            projectId: projectUUID,
            date: Date().addingTimeInterval(-86400),
            summary: "Excavación y armado de zapatas iniciales.",
            workforce: "2 cuadrillas de 5 personas",
            issues: "Retraso por lluvia, se protege el área.",
            photos: [reportPhoto],
            createdBy: supervisorSummary
        )

        let olderReport = DailyReport(
            id: UUID(),
            projectId: projectUUID,
            date: Date().addingTimeInterval(-86400 * 3),
            summary: "Revisión de accesos y cercado perimetral.",
            workforce: "1 cuadrilla de 4 personas",
            issues: "Sin incidencias.",
            photos: [],
            createdBy: supervisorSummary
        )

        let document = Document(
            id: UUID(),
            projectId: projectUUID,
            taskId: nil,
            name: "Plano cimentación v3",
            type: .plan,
            url: URL(string: "https://example.com/plano.pdf")!,
            uploadDate: Date().addingTimeInterval(-86400 * 5),
            uploadedBy: directorSummary
        )

        let project = Project(
            id: projectUUID,
            name: "Centro logístico norte",
            client: "ACME Logistics",
            location: "Monterrey, MX",
            startDate: Date().addingTimeInterval(-86400 * 30),
            endDate: Date().addingTimeInterval(86400 * 120),
            progress: 0.32,
            responsible: directorSummary,
            tasks: [task1, task2],
            dailyReports: [report, olderReport],
            documents: [document]
        )

        projects = [project]
    }
}
