import Foundation
import SwiftUI

@MainActor
final class TaskListViewModel: ObservableObject {
    enum SortOption: String, CaseIterable { case dueDate, priority, status }

    @Published private(set) var tasks: [Task]
    @Published var searchText: String = ""
    @Published var statusFilter: Task.Status?
    @Published var sortOption: SortOption = .dueDate
    @Published var isPresentingNewTask: Bool = false
    @Published var draft: TaskDraft
    @Published var validationMessage: String?

    init(project: Project) {
        self.tasks = project.tasks
        self.draft = TaskDraft(responsible: project.responsible, projectId: project.id)
    }

    var filteredTasks: [Task] {
        var result = tasks

        if let status = statusFilter {
            result = result.filter { $0.status == status }
        }

        if !searchText.isEmpty {
            result = result.filter { task in
                task.title.localizedCaseInsensitiveContains(searchText) ||
                task.description.localizedCaseInsensitiveContains(searchText) ||
                task.responsible.name.localizedCaseInsensitiveContains(searchText)
            }
        }

        switch sortOption {
        case .dueDate:
            result = result.sorted { $0.dueDate < $1.dueDate }
        case .priority:
            result = result.sorted { $0.priority.sortWeight > $1.priority.sortWeight }
        case .status:
            result = result.sorted { $0.status.sortWeight < $1.status.sortWeight }
        }

        return result
    }

    func updateTask(_ task: Task) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index] = task
    }

    func resetDraft(for project: Project) {
        draft = TaskDraft(responsible: project.responsible, projectId: project.id)
        validationMessage = nil
    }

    func createTask(for project: Project) -> Bool {
        guard let task = draft.build() else {
            validationMessage = "Completa los campos obligatorios y valida fechas."
            return false
        }
        tasks.append(task)
        return true
    }
}

struct TaskDraft {
    var projectId: UUID
    var title: String = ""
    var description: String = ""
    var responsible: UserSummary
    var startDate: Date = Date()
    var dueDate: Date = Date().addingTimeInterval(86400)
    var priority: Task.Priority = .medium

    init(responsible: UserSummary, projectId: UUID) {
        self.responsible = responsible
        self.projectId = projectId
    }

    func build() -> Task? {
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              dueDate >= startDate else { return nil }

        return Task(
            id: UUID(),
            projectId: projectId,
            title: title,
            description: description,
            responsible: responsible,
            startDate: startDate,
            dueDate: dueDate,
            status: .pending,
            priority: priority,
            progress: 0,
            comments: [],
            photos: []
        )
    }
}

private extension Task.Priority {
    var sortWeight: Int {
        switch self {
        case .high: 2
        case .medium: 1
        case .low: 0
        }
    }
}

private extension Task.Status {
    var sortWeight: Int {
        switch self {
        case .pending: 0
        case .inProgress: 1
        case .completed: 2
        }
    }
}
