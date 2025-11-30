import Foundation

@MainActor
final class ProjectsViewModel: ObservableObject {
    @Published private(set) var projects: [Project] = []
    @Published var selectedProject: Project?

    private let service: MockDataService

    init(service: MockDataService = .shared) {
        self.service = service
        loadProjects()
    }

    func loadProjects() {
        projects = service.projects
        if selectedProject == nil {
            selectedProject = projects.first
        }
    }

    func refresh() {
        loadProjects()
    }
}
